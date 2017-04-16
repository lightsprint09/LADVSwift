//
//  AthletDetails+JSONDecodable.swift
//  Leichatletik
//
//  Created by Lukas Schmidt on 28.01.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation
import JSONCodable

extension AthletDetails: JSONCodable {
    public init(object: JSONObject) throws {
        let decoder = JSONDecoder(object: object)
        id = try decoder.decode("id")
        athletnumber = try decoder.decode("athletnumber")
        firstname = try decoder.decode("forename")
        lastname = try decoder.decode("surname")
        gender = try decoder.decode("sex")
        yearOfBith = try decoder.decode("birthyear")
        vereinNumber = try decoder.decode("vereinnumber")
        vereinname = try decoder.decode("vereinname")
        landesverband = try decoder.decode("lv")
        let competitions = (try decoder.decode("meldungen") as [Competition]?) ?? []
        self.competitions = competitions.sorted(by: { $0.date > $1.date })
        performances = (try decoder.decode("leistungen")as [Performance]?) ?? []
    }
}
