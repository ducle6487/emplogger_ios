//
//  URLProtocolStub.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import UIKit

public class URLProtocolStub: URLProtocol {
    // Stub store map of urls to our data
    public static var stubUrls = [URL?: (data: Data, response: URLResponse, error: Error?)]()

    // Mark ourselves as the handler of any request
    public override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    public override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    public override func startLoading() {
        guard let url = request.url,
              let response = URLProtocolStub.stubUrls[url] else {
            self.client?.urlProtocolDidFinishLoading(self)
            return
        }

        if let error = response.error {
            client?.urlProtocol(self, didFailWithError: error)
            client?.urlProtocolDidFinishLoading(self)
            return
        }

        // Return our stubbed data without hitting the network
        client?.urlProtocol(self, didReceive: response.response, cacheStoragePolicy: .notAllowed)
        client?.urlProtocol(self, didLoad: response.data)

        // Trigger our finished loading
        self.client?.urlProtocolDidFinishLoading(self)
    }

    public override func stopLoading() {
        // Overriding ensures super's impelmentation is not called
    }
}
