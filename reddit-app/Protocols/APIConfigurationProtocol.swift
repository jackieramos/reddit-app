//
//  APIConfigurationProtocol.swift
//  reddit-app
//
//  Created by Jackie Ramos on 01/04/2020.
//  Copyright © 2020 Jackie. All rights reserved.
//

import Foundation
import Alamofire

typealias APIParams = [String : Any]?

protocol APIConfigurationProtocol {
    var method: Alamofire.HTTPMethod { get }
    var path: String { get }
    var parameters: APIParams { get }
    var url: URL { get }
    var authorizationHeader: String { get }
}

extension APIConfigurationProtocol {
    var url: URL {
        return try! K.RedditServer.baseURL.asURL()
    }

    var authorizationHeader: String {
        return "Bearer \(UserDefaults.accessToken ?? "-")"
    }

    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
       
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
       
       // HTTP Method
        urlRequest.httpMethod = method.rawValue
       
       // Common Headers
        urlRequest.setValue(authorizationHeader, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.formUrlEncoded.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)

       // Parameters
        if let parameters = parameters {

            if self.method == .post {
                urlRequest.httpBody = self.parseParameters(parameters: parameters)
            } else if self.method == .get {
                return try URLEncoding.default.encode(urlRequest, with: self.parameters)
            }
        }
       
        return urlRequest
    }
    
    /// Parse parameters for POST data x-www-form-urlencoded
    ///
    /// - Parameters:
    ///   - parameters: Request parameters
    private func parseParameters(parameters: Parameters) -> Data? {

        let body = parameters.map{ "\($0.key)=\($0.value)" }.joined(separator: "&")

        return body.data(using: .utf8)
    }
}

