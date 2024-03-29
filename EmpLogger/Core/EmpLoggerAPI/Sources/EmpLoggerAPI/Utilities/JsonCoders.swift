//
//  File.swift
//  
//
//  Created by AnhDuc on 05/03/2024.
//

import Foundation
import EmpLoggerInjection
import EmpLoggerFoundation

public enum JsonCoders {
    public static var baseApiJsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatters.iso8601Formatter)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}

// MARK: - Provide our json decoder as an injected property
extension DependencyMap {
    private struct BaseJsonDecoderKey: DependencyKey {
        static var dependency: JSONDecoder = JsonCoders.baseApiJsonDecoder
    }
    
    var baseJsonDecoder: JSONDecoder {
        get { resolve(key: BaseJsonDecoderKey.self) }
        set { register(key: BaseJsonDecoderKey.self, dependency: newValue) }
    }
}
