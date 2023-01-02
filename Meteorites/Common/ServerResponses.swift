//
//  ServerResponses.swift
//  Meteorites
//
//  Created by Simon Sestak on 02/01/2023.
//

import Foundation

// MARK: - Meteorit

struct Meteorit: Codable {
    let name, id: String
    let nametype: Nametype
    let recclass: String
    let mass: String?
    let fall: Fall
    let year, reclat, reclong: String?
    let geolocation: Geolocation?
    let computedRegionCbhkFwbd, computedRegionNnqa25F4: String?

    enum CodingKeys: String, CodingKey {
        case name, id, nametype, recclass, mass, fall, year, reclat, reclong, geolocation
        case computedRegionCbhkFwbd = ":@computed_region_cbhk_fwbd"
        case computedRegionNnqa25F4 = ":@computed_region_nnqa_25f4"
    }
}

enum Fall: String, Codable {
    case fell = "Fell"
    case found = "Found"
}

// MARK: - Geolocation

struct Geolocation: Codable {
    let latitude, longitude: String
}

enum Nametype: String, Codable {
    case valid = "Valid"
}

typealias Meteorits = [Meteorit]
