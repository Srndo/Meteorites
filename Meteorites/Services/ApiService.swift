//
//  ApiService.swift
//  Meteorites
//
//  Created by Simon Sestak on 02/01/2023.
//

import Alamofire
import Foundation
import PromiseKit

class ApiService {
    enum Errors: Error {
        case cannotDecode
    }

    let decoder = JSONDecoder()

    func request<T: Decodable>(of type: T.Type, urlTask: URLTaskConfiguration) -> Promise<T> {
        Promise { seal in
            AF.request(urlTask)
                .responseData(queue: .global()) { response in
                    print(response.debugDescription)
                    switch response.result {
                    case let .success(data):
                        // if status code == positive response
                        if let statusCode = response.response?.statusCode, statusCode < 300, statusCode >= 200 {
                            guard let decodedData = try? self.decoder.decode(type, from: data) else {
                                return seal.reject(Errors.cannotDecode)
                            }
                            return seal.fulfill(decodedData)
                        }
                    case let .failure(error):
                        return seal.reject(error)
                    }
                }
        }
    }
}
