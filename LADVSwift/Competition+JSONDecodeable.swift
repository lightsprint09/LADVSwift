//
//  Meldung+JSONDecodeable.swift
//  Leichatletik
//
//  Created by Lukas Schmidt on 28.01.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation


extension Ausschreibung: JSONCodable {
    public init(object: JSONObject) throws {
        let decoder = JSONDecoder(object: object)
        id = try decoder.decode("id")
        name = try decoder.decode("name")
        date = Date(timeIntervalSince1970: try decoder.decode("datum") / 1000)
        city = try decoder.decode("ort")
        locationName = try decoder.decode("sportstaette")
        description = try decoder.decode("beschreibung")
        meldeAdress = try decoder.decode("meldAdresse")
        meldeEMailAdress = try decoder.decode("meldEmail")
        meldeSchlussDate =  Date(timeIntervalSince1970: try decoder.decode("meldDatum") / 1000)
        let endDateSeconds: Double? = try decoder.decode("bisDatum")
        endDate = endDateSeconds.map { Date(timeIntervalSince1970: $0 / 1000) }
    }
}
