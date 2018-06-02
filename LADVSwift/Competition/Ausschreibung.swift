//
//  Meldung.swift
//  Leichatletik
//
//  Created by Lukas Schmidt on 28.01.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation

public protocol CompetitionDescribing {
    var id: Int { get }
    var name: String { get }
    var date: Date { get }
    var endDate: Date? { get }
    var locationName: String { get }
}

extension CompetitionDescribing {
    /// TODO: Use url proberty
    public var ladvURL: URL {
        return URL(string: "https://ladv.de/ausschreibung/detail/\(id)")!
    }
    
    public var attendeesURL: URL {
        return URL(string: "https://ladv.de/meldung/teilnehmer/\(id)")!
    }
}

public struct Ausschreibung: Hashable, Codable {
    public let id: Int
    public let name: String
    public let date: Date
    public let endDate: Date?
    public let city: String?
    public let locationName: String

    public let description: String

    //Meldung
    public let meldeAdress: String
    public let meldeEMailAdress: String
    public let meldeSchlussDate: Date
 
    public enum CodingKeys: String, CodingKey {
        case id
        case name
        case date = "datum"
        case endDate = "bisDatum"
        case city = "ort"
        case description = "beschreibung"
        case locationName = "sportstaette"
        case meldeAdress = "meldAdresse"
        case meldeEMailAdress = "meldEmail"
        case meldeSchlussDate = "meldDatum"
    }
    
    
}

extension Ausschreibung: CompetitionDescribing {}

