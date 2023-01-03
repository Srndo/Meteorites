//
//  String.swift
//  Meteorites
//
//  Created by Simon Sestak on 03/01/2023.
//

import Foundation

extension String {
    func getDate(format: String = "yyyy-MM-dd'T'HH:mm:ss") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: self)
    }
}
