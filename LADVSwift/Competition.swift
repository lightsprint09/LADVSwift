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
    var locationName: String { get }
}

extension CompetitionDescribing {
    public var ladvURL: URL {
        return URL(string: "https://ladv.de/ausschreibung/detail/\(id)")!
    }
}

public struct Competition {
    public let id: Int
    public let name: String
    public let date: Date
    public let dateText: String
    public let city: String?
    public let locationName: String
    
    public let description: String
    
    //Meldung
    public let meldeAdress: String
    public let meldeEMailAdress: String
    public let meldeSchlussDate: Date
    
}

extension Competition: CompetitionDescribing {}

extension Competition: Identifieable { }


