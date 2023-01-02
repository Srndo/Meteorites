//
//  URLTaskStructure.swift
//  Meteorites
//
//  Created by Simon Sestak on 09/10/2021.
//

import Alamofire
import Foundation

protocol URLTaskConfiguration: URLRequestConvertible {
    var endPoint: RequestEndPoint { get }
}

struct URLTask: URLTaskConfiguration {
    let endPoint: RequestEndPoint

    func asURLRequest() throws -> URLRequest {
        var urlRequest = try NetworkServiceConstants.asURLRequest(apiEndPoint: endPoint)

        if let urlParams = endPoint.urlParams {
            let queryParams = urlParams.map { pair in
                URLQueryItem(name: pair.key, value: "\(pair.value)")
            }
            if let url = urlRequest.url {
                var components = URLComponents(string: url.absoluteString)
                components?.queryItems = queryParams
                urlRequest.url = components?.url
            }
        }
        return try URLEncoding.default.encode(urlRequest, with: endPoint.parameters)
    }
}
