//
//  CompetitionDetails+JSONDecodeable.swift
//  Leichatletik
//
//  Created by Lukas Schmidt on 11.02.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation


extension CompetitionDetails: JSONCodable {
    public init(object: JSONObject) throws {
        let decoder = JSONDecoder(object: object)
        id = try decoder.decode("id")
        name = try decoder.decode("name")
        date = Date(timeIntervalSince1970: try decoder.decode("datum") / 1000)
        let endDateSeconds: Double? = try decoder.decode("bisDatum")
        endDate = endDateSeconds.map { Date(timeIntervalSince1970: $0 / 1000) }
        locationName = try decoder.decode("sportstaette")
        description = try decoder.decode("beschreibung")
        meldeAdress = try decoder.decode("meldAdresse")
        meldeEMailAdress = try decoder.decode("meldEmail")
        meldeSchlussDate =  Date(timeIntervalSince1970: try decoder.decode("meldDatum") / 1000)
        location = try decoder.decode("ort")
        competitions = try decoder.decode("wettbewerbe")
        links = try decoder.decode("links")
        attachments = try decoder.decode("attachements")
        veranstaltungen = try decoder.decode("veranstaltungen")
        let lvsStrings = (try decoder.decode("lvs") as String).components(separatedBy: ",")
        regions = lvsStrings.map { Region(id: $0)! }
        tags = (try decoder.decode("tags") as String).components(separatedBy: ",")
        organizer = try decoder.decode("veranstalter")
        ausrichter = try decoder.decode("ausrichter")
    }
}
