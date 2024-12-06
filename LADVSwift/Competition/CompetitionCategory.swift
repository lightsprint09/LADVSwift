//
//  CompetitionCategory.swift
//  Leichatletik
//
//  Created by Lukas Schmidt on 06.03.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation

public struct CompetitionCategory: Sendable {
    public let id: String
    public let name: String
    
    public static let all = [CompetitionCategory(id: "203", name:"Aktive"),
                      CompetitionCategory(id: "40", name:"Bahn"),
                      CompetitionCategory(id: "357", name:"Behindertensport"),
                      CompetitionCategory(id: "205", name:"Berglauf"),
                      CompetitionCategory(id: "41", name:"Cross"),
                      CompetitionCategory(id: "44", name:"Extern"),
                      CompetitionCategory(id: "39", name:"Halle"),
                      CompetitionCategory(id: "59", name:"International"),
                      CompetitionCategory(id: "202", name:"Jugend"),
                      CompetitionCategory(id: "200", name:"Kinder"),
                      CompetitionCategory(id: "199", name:"Kinderleichtathletik"),
                      CompetitionCategory(id: "57", name:"Landesoffen"),
                      CompetitionCategory(id: "58", name:"National"),
                      CompetitionCategory(id: "46", name:"Rasenkraftsport"),
                      CompetitionCategory(id: "201", name:"Schüler"),
                      CompetitionCategory(id: "204", name:"Senioren"),
                      CompetitionCategory(id: "43", name:"Strasse"),
                      CompetitionCategory(id: "42", name:"Vergleichskampf"),
                      CompetitionCategory(id: "207", name:"Volkslauf"),
                      CompetitionCategory(id: "206", name:"Waldlauf")]
}

