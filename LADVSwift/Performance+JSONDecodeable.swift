//
//  Lsitung+JSONDecodeable.swift
//  Leichatletik
//
//  Created by Lukas Schmidt on 28.01.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation
import JSONCodable

extension Performance: JSONCodable {
    public init(object: JSONObject) throws {
        let decoder = JSONDecoder(object: object)
        location = try decoder.decode("ort")
        disciplin = Disciplin(dlvID: try decoder.decode("disziplin"))
        let valueString: String = try decoder.decode("leistung")
        value = valueString.replacingOccurrences(of: ",", with: ".")
        dateText = try decoder.decode("datum")
        let isPersonalBestString: String? = try decoder.decode("personalbest")
        isPersonalBest = isPersonalBestString == "true"
        let indoorString: String? = try decoder.decode("halle")
        indoor = indoorString == "true"
        wind = try decoder.decode("wind")
    }
}
