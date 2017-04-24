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
    public let endDate: Date?
    public let locationName: String
    public let tags: [String]
    public let results: [Attachement]
    public let region: Region
    
    public let location: CompetitionLocation

}
