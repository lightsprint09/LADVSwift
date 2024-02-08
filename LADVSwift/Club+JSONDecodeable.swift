//
//  Club+JSONDecodeable.swift
//  LADVSwift
//
//  Created by Lukas Schmidt on 11.08.17.
//  Copyright © 2017 freiraum. All rights reserved.
//



extension Club: JSONDecodable {
    public init(object: JSONObject) throws {
        let decoder = JSONDecoder(object: object)
        name = try decoder.decode("vereinname")
        number = try decoder.decode("vereinnumber")
        let regionId: String = try decoder.decode("lv")
        region = Region(id: regionId) ?? Region(id: regionId, name: "Unbekannte Region (\(regionId))")
    }
}
