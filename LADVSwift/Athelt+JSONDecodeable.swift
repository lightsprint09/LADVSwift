//
//  Athelte+JSONDecodeable.swift
//  Leichatletik
//
//  Created by Lukas Schmidt on 28.01.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation
import JSONCodable

extension Athlete: JSONCodable {
    public init(object: JSONObject) throws {
        let decoder = JSONDecoder(object: object)
        ladvId = try decoder.decode("id")
        athletnumber = try decoder.decode("athletnumber")
        firstname = try decoder.decode("forename")
        lastname = try decoder.decode("surname")
        gender = Gender(string: try decoder.decode("sex"))!
        yearOfBirth = try decoder.decode("birthyear")
        vereinNumber = try decoder.decode("vereinnumber")
        vereinname = try decoder.decode("vereinname")
        landesverband = try decoder.decode("lv")
    }
}
