//
//  CompetitionKind+JSONDecodeable.swift
//  Leichatletik
//
//  Created by Lukas Schmidt on 11.02.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation


extension CompetitionKind: JSONCodable {
    public init(object: JSONObject) throws {
        let decoder = JSONDecoder(object: object)
        age = Age(dlvID: try decoder.decode("klasse"))
        disciplin = Disciplin(dlvID: try decoder.decode("disziplin"))
    }
}
