//
//  EndPoints.swift
//  Meteorites
//
//  Created by Simon Sestak on 02/01/2023.
//

import Alamofire

enum EndPoints: RequestEndPoint {
    case allMeteors

    var method: HTTPMethod { .get }
    var contentType: AFContentType { .json }
    var parameters: Parameters? { nil }
    var urlParams: Parameters? { nil }
}
