//
//  Connectivity.swift
//  Meteorites
//
//  Created by Simon Sestak on 03/01/2023.
//

import Foundation

import Alamofire
import Foundation

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        NetworkReachabilityManager()?.isReachable ?? false
    }
}
