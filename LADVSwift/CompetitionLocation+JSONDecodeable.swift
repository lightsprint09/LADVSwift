//
//  CompetitionLocation+JSONDecodeable.swift
//  Leichatletik
//
//  Created by Lukas Schmidt on 11.02.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation
import JSONCodable

extension CompetitionLocation: JSONCodable {
    public init(object: JSONObject) throws {
        let decoder = JSONDecoder(object: object)
        id = try decoder.decode("id")
        name = try decoder.decode("name")
        let regionId: String = try decoder.decode("lv")
        region = Region(id: regionId)!
        latitude = try decoder.decode("lat")
        longitude = try decoder.decode("lng")
    }
}
