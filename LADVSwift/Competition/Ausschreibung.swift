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
    public var id: Int
    public var name: String
    public var date: Date
    public var endDate: Date?
    public var city: String?
    public var locationName: String

    public var description: String

    //Meldung
    public var meldeAdress: String?
    public var meldeEMailAdress: String?
    public var meldeSchlussDate: Date
    
    public init(id: Int, name: String, date: Date, endDate: Date?, city: String?, locationName: String, description: String, meldeAdress: String, meldeEMailAdress: String, meldeSchlussDate: Date) {
        self.id = id
        self.name = name
        self.date = date
        self.endDate = endDate
        self.city = city
        self.locationName = locationName
        self.description = description
        self.meldeAdress = meldeAdress
        self.meldeEMailAdress = meldeEMailAdress
        self.meldeSchlussDate = meldeSchlussDate
    }
 
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

