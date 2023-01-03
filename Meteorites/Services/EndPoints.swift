//
//  EndPoints.swift
//  Meteorites
//
//  Created by Simon Sestak on 02/01/2023.
//

import Alamofire
import Foundation

enum EndPoints: RequestEndPoint {
    case allMeteors
    case filtered(fromDate: Date?, toDate: Date = .now, fall: Fall? = .fell)

    enum APIParameterKey {
        static let fall = "fall"
        static let year = "year"
        static let `where` = "$where"
    }

    var method: HTTPMethod { .get }
    var contentType: AFContentType { .json }
    var parameters: Parameters? { nil }
    var urlParams: Parameters? {
        switch self {
        case let .filtered(fromDate, toDate, fall):
            var dic = [String: Any]()
            if let fromDate {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                let fromDateString = formatter.string(from: fromDate)
                let toDateString = formatter.string(from: toDate)
                dic[APIParameterKey.where] = "year between '\(fromDateString)' and '\(toDateString)'"
            }
            if let fall { dic[APIParameterKey.fall] = fall.rawValue }
            return dic
        default:
            return nil
        }
    }
}
