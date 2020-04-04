//
//  APIConfigurationProtocol.swift
//  reddit-app
//
//  Created by Jackie Ramos on 01/04/2020.
//  Copyright © 2020 Jackie. All rights reserved.
//

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
            
            urlRequest.httpBody = self.parseParameters(parameters: parameters)
//            do {
//                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
//            } catch {
//                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
//            }
        }
       
        return urlRequest
    }
    
    private func parseParameters(parameters: Parameters) -> Data? {

        let body = parameters.map{ "\($0.key)=\($0.value)" }.joined(separator: "&")

        return body.data(using: .utf8)
    }
}

