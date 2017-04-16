//
//  Region.swift
//  Leichatletik
//
//  Created by Lukas Schmidt on 06.03.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation

public struct Region {
    public let id: String
    public let name: String
    
    public static let all = [Region(id: "BA", name: "Baden"),
               Region(id: "BY", name: "Bayern"),
               Region(id: "BE", name: "Berlin"),
               Region(id: "BB", name: "Brandenburg"),
               Region(id: "BR", name: "Bremen"),
               Region(id: "HH", name: "Hamburg"),
               Region(id: "HE", name: "Hessen"),
               Region(id: "MV", name: "Mecklenburg-Vorpommern"),
               Region(id: "NI", name: "Niedersachsen"),
               Region(id: "NO", name: "Nordrhein"),
               Region(id: "PF", name: "Pfalz"),
               Region(id: "RH", name: "Rheinhessen"),
               Region(id: "RL", name: "Rheinland"),
               Region(id: "SL", name: "Saarland"),
               Region(id: "SN", name: "Sachsen"),
               Region(id: "ST", name: "Sachsen-Anhalt"),
               Region(id: "SH", name: "Schleswig-Holstein"),
               Region(id: "TH", name: "Thüringen"),
               Region(id: "WE", name: "Westfalen"),
               Region(id: "WÜ", name: "Württemberg")]
}
