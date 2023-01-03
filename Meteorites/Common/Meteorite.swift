//
//  Meteorite.swift
//  Meteorites
//
//  Created by Simon Sestak on 03/01/2023.
//

import CoreLocation
import RealmSwift

final class Meteorite: Object, Decodable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var name: String?
    @Persisted var recclass: String?
    @Persisted var fall: Fall?
    @Persisted var year: String?
    @Persisted var reclat: String?
    @Persisted var reclong: String?
    @Persisted var geolocation: Geolocation?
    var nametype: Nametype?
    var mass: String?
    var computedRegionCbhkFwbd, computedRegionNnqa25F4: String?

    enum CodingKeys: String, CodingKey {
        case name, id, nametype, recclass, mass, fall, year, reclat, reclong, geolocation
        case computedRegionCbhkFwbd = ":@computed_region_cbhk_fwbd"
        case computedRegionNnqa25F4 = ":@computed_region_nnqa_25f4"
    }

    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        recclass = try container.decodeIfPresent(String.self, forKey: .recclass)
        fall = try container.decodeIfPresent(Fall.self, forKey: .fall)
        year = try container.decodeIfPresent(String.self, forKey: .year)
        reclat = try container.decodeIfPresent(String.self, forKey: .reclat)
        reclong = try container.decodeIfPresent(String.self, forKey: .reclong)
        geolocation = try container.decodeIfPresent(Geolocation.self, forKey: .geolocation)
//        geolocation = try decoder.singleValueContainer().decode(Geolocation.self)
        nametype = try container.decodeIfPresent(Nametype.self, forKey: .nametype)
//        nametype = try decoder.singleValueContainer().decode(Nametype.self)
        mass = try container.decodeIfPresent(String.self, forKey: .mass)
        computedRegionCbhkFwbd = try container.decodeIfPresent(String.self, forKey: .computedRegionCbhkFwbd)
        computedRegionNnqa25F4 = try container.decodeIfPresent(String.self, forKey: .computedRegionNnqa25F4)
    }

    func getLocation() -> CLLocationCoordinate2D? {
        if let geolocation, let long = Double(geolocation.longitude), let lat = Double(geolocation.latitude) {
            return CLLocationCoordinate2D(latitude: lat, longitude: long)
        }
        return nil
    }
}

enum Fall: String, Codable, Equatable, PersistableEnum {
    case fell = "Fell"
    case found = "Found"
}

class Geolocation: EmbeddedObject, Decodable {
    @Persisted var latitude: String
    @Persisted var longitude: String
}

enum Nametype: String, Codable {
    case valid = "Valid"
}

typealias Meteorits = [Meteorite]
