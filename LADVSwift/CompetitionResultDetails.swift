//
//  CompetitionResultsDetails.swift
//  Leichatletik
//
//  Created by Lukas Schmidt on 15.04.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation

public struct CompetitionResultDetails {
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

}
