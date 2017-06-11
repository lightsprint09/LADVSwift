//
//  CompetitionResultDetails+JSONDecodable.swift
//  LADVSwift
//
//  Created by Lukas Schmidt on 17.04.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation
import JSONCodable

extension CompetitionResultDetails: JSONCodable {
    public init(object: JSONObject) throws {
        let decoder = JSONDecoder(object: object)
        id = try decoder.decode("id")
        name = try decoder.decode("name")
        date = Date(timeIntervalSince1970: try decoder.decode("datum") / 1000)
        let endDateInt: Double? = try decoder.decode("bisDatum")
        endDate = endDateInt.map { Date(timeIntervalSince1970: $0 / 1000) }
        location = try decoder.decode("ort")
        results = try decoder.decode("ergebnisse")
        tags = (try decoder.decode("tags") as String).components(separatedBy: ",")
        let lvsStrings = (try decoder.decode("lvs") as String).components(separatedBy: ",")
        regions = lvsStrings.map { Region(id: $0)! }
    }
}
