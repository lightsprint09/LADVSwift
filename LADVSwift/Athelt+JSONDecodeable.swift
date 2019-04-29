//
//  Athelte+JSONDecodeable.swift
//  Leichatletik
//
//  Created by Lukas Schmidt on 28.01.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation


extension Athlete: JSONCodable {
    public init(object: JSONObject) throws {
        let decoder = JSONDecoder(object: object)
        id = try decoder.decode("id")
        athletnumber = try decoder.decode("athletnumber")
        firstname = try decoder.decode("forename")
        lastname = try decoder.decode("surname")
        gender = Gender(string: try decoder.decode("sex"))!
        yearOfBirth = try decoder.decode("birthyear")
        allClubs = [try? Club(object: object)].compactMap { $0 }
    }
}
