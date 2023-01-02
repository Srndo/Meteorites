//
//  NetworServiceConstants.swift
//  Meteorites
//
//  Created by Simon Sestak on 02/01/2023.
//

import Alamofire
import Foundation
import UIKit

enum NetworkServiceConstants {
    static func asURLRequest(apiEndPoint: RequestEndPoint) throws -> URLRequest {
        let url = try "https://data.nasa.gov/resource/gh4g-9sfh.json".asURL()
        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = apiEndPoint.method.rawValue
        urlRequest.addValue(apiEndPoint.contentType.toString,
                            forHTTPHeaderField: AFHTTPHeaderField.contentType.rawValue)
        urlRequest.addValue(Configuration.appToken, forHTTPHeaderField: AFHTTPHeaderField.appToken.rawValue)

        let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "0"
        let appBuild = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") ?? "0"
        let charSet = CharacterSet(charactersIn: ".")
        let appBuildNumber = appVersion.components(separatedBy: charSet).joined()

        urlRequest.addValue("ios", forHTTPHeaderField: AFHTTPHeaderField.appPlatform.rawValue)
        urlRequest.addValue("\(appBuildNumber)\(appBuild)", forHTTPHeaderField: AFHTTPHeaderField.appVersion.rawValue)

        return urlRequest
    }
}

enum AFHTTPHeaderField: String {
    case appVersion = "App-Version"
    case appPlatform = "App-Platform"
    case contentType = "Content-Type"
    case appToken = "X-App-Token"
}

enum AFContentType {
    case json
    case xWwwFormUrlencoded
    case formData(uuid: String)

    var toString: String {
        switch self {
        case .xWwwFormUrlencoded:
            return "application/x-www-form-urlencoded"
        case .json:
            return "application/json"
        case let .formData(uuid):
            return "multipart/form-data; boundary=Boundary-\(uuid)"
        }
    }
}

protocol RequestEndPoint {
    var method: HTTPMethod { get }
    var contentType: AFContentType { get }
    var parameters: Parameters? { get }
    var urlParams: Parameters? { get }
}
