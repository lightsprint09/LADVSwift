//
//  CompetitionDetails.swift
//  Leichatletik
//
//  Created by Lukas Schmidt on 11.02.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation

public struct CompetitionDetails {
    public let id: Int
    public let name: String
    public let date: Date
    public let dateText: String
    public let locationName: String
    
    public let description: String
    
    //Meldung
    public let meldeAdress: String
    public let meldeEMailAdress: String
    public let meldeSchlussDate: Date
    
    public let location: CompetitionLocation
    public let competitions: [CompetitionKind]
    
    public let links: [Attachement]
    public let attachments: [Attachement]
    public let veranstaltungen: [Attachement]
    
    public let region: Region
    
}

extension CompetitionDetails: CompetitionDescribing {}
