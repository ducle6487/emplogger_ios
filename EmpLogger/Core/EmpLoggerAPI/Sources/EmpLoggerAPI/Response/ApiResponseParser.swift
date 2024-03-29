//
//  ApiResponseParser.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import Foundation

class ApiResponseParser {
    class func parse(
        _ response: some DataConformable,
        customCodes: [Int] = []
    ) throws -> NetworkResponse {
        let data = response.data
        guard let httpResponse = response.response as? HTTPURLResponse else {
            throw ApiError.connection
        }
        
        switch httpResponse.statusCode {
        case 401: throw ApiError.unauthorized
        case 403: throw ApiError.denied
        case 404: throw ApiError.notFound
        case 409: throw ApiError.conflict
        default: break
        }

        guard !customCodes.contains(httpResponse.statusCode), case 200...299 = httpResponse.statusCode else {
            throw mapOtherError(httpResponse.statusCode, payload: data)
        }

        return NetworkResponse(data: data, response: httpResponse, statusCode: httpResponse.statusCode)
    }
    
    private class func mapOtherError(_ statusCode: Int, payload: Data?) -> ApiError {
        let decoder = JSONDecoder()
        if let payload, !payload.isEmpty {
            if let message = try? decoder.decode(ApiMessageError.self, from: payload) {
                return ApiError.errorMessage(message: message, statusCode: statusCode)
            // Only decode to string if not JSON
            } else if let message = String(data: payload, encoding: .utf8), !message.contains("{") {
                return ApiError.message(message: message, statusCode: statusCode)
            }
        }
        return ApiError.server(statusCode: statusCode, payload: payload)
    }
}
