//
//  AgeClass.swift
//  Leichatletik
//
//  Created by Lukas Schmidt on 13.02.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation

public struct Age: Hashable, Sendable {
    public let name: String
    public let shortName: String
    public let ladvID: String
    public let dlvID: String
    
    public init(dlvID: String) {
        if let newSelf = Age.all.first(where: { $0.dlvID == dlvID }) {
            self = newSelf
        } else {
            self.name = dlvID
            self.shortName = dlvID
            self.ladvID = dlvID
            self.dlvID = dlvID
        }
    }
    
    init(any: String) {
        if let newSelf = Age.all.first(where: { $0.dlvID == any }) ?? Age.all.first(where: { $0.shortName == any }) ?? Age.all.first(where: { $0.ladvID == any }) ?? Age.all.first(where: { any.contains($0.dlvID) }) {
            self = newSelf
        } else {
            self.name = any
            self.shortName = any
            self.ladvID = any
            self.dlvID = any
        }
    }
    
    public init(name: String, shortName: String, ladvID: String, dlvID: String) {
        self.name = name
        self.shortName = shortName
        self.ladvID = ladvID
        self.dlvID = dlvID
    }
    
    public static let all: [Age] = [
        Age(name: "Kinder M3", shortName: "M03", ladvID: "M3", dlvID: "M3"),
        Age(name: "Kinder M4", shortName: "M04", ladvID: "M4", dlvID: "M4"),
        Age(name: "Kinder M5", shortName: "M05", ladvID: "M5", dlvID: "M5"),
        Age(name: "Kinder M6", shortName: "M06", ladvID: "M6", dlvID: "M6"),
        Age(name: "Kinder M7", shortName: "M07", ladvID: "M7", dlvID: "M7"),
        Age(name: "Kinder M8", shortName: "M08", ladvID: "M8", dlvID: "M8"),
        Age(name: "Kinder M9", shortName: "M09", ladvID: "M9", dlvID: "M9"),
        Age(name: "Kinder M10", shortName: "M10", ladvID: "M10", dlvID: "M10"),
        Age(name: "Kinder M11", shortName: "M11", ladvID: "M11", dlvID: "M11"),
        Age(name: "Jugend M12", shortName: "M12", ladvID: "M12", dlvID: "M12"),
        Age(name: "Jugend M13", shortName: "M13", ladvID: "M13", dlvID: "M13"),
        Age(name: "Jugend M14", shortName: "M14", ladvID: "M14", dlvID: "M14"),
        Age(name: "Jugend M15", shortName: "M15", ladvID: "M15", dlvID: "M15"),
        Age(name: "männliche Kinder U8", shortName: "MK U8", ladvID: "MKU8", dlvID: "SE"),
        Age(name: "männliche Kinder U10", shortName: "MK U10", ladvID: "MKU10", dlvID: "SD"),
        Age(name: "männliche Kinder U12", shortName: "MK U12", ladvID: "MKU12", dlvID: "SC"),
        Age(name: "männliche Jugend U14", shortName: "MJ U14", ladvID: "MJU14", dlvID: "SB"),
        Age(name: "männliche Jugend U16", shortName: "MJ U16", ladvID: "MJU16", dlvID: "SA"),
        Age(name: "männliche Jugend U18", shortName: "MJ U18", ladvID: "MJU18", dlvID: "MJB"),
        Age(name: "männliche Jugend U20", shortName: "MJ U20", ladvID: "MJU20", dlvID: "MJA"),
        Age(name: "Junioren U23", shortName: "M U23", ladvID: "MU23", dlvID: "J"),
        Age(name: "Männer", shortName: "Männer", ladvID: "M", dlvID: "M"),
        Age(name: "Senioren M30", shortName: "M30", ladvID: "M30", dlvID: "M30"),
        Age(name: "Senioren M35", shortName: "M35", ladvID: "M35", dlvID: "M35"),
        Age(name: "Senioren M40", shortName: "M40", ladvID: "M40", dlvID: "M40"),
        Age(name: "Senioren M45", shortName: "M45", ladvID: "M45", dlvID: "M45"),
        Age(name: "Senioren M50", shortName: "M50", ladvID: "M50", dlvID: "M50"),
        Age(name: "Senioren M55", shortName: "M55", ladvID: "M55", dlvID: "M55"),
        Age(name: "Senioren M60", shortName: "M60", ladvID: "M60", dlvID: "M60"),
        Age(name: "Senioren M65", shortName: "M65", ladvID: "M65", dlvID: "M65"),
        Age(name: "Senioren M70", shortName: "M70", ladvID: "M70", dlvID: "M70"),
        Age(name: "Senioren M75", shortName: "M75", ladvID: "M75", dlvID: "M75"),
        Age(name: "Senioren M80", shortName: "M80", ladvID: "M80", dlvID: "M80"),
        Age(name: "Senioren M85", shortName: "M85", ladvID: "M85", dlvID: "M85"),
        Age(name: "Senioren M90", shortName: "M90", ladvID: "M90", dlvID: "M90"),
        Age(name: "Senioren M95", shortName: "M95", ladvID: "M95", dlvID: "M95"),
        Age(name: "Kinder W3", shortName: "W03", ladvID: "W3", dlvID: "W3"),
        Age(name: "Kinder W4", shortName: "W04", ladvID: "W4", dlvID: "W4"),
        Age(name: "Kinder W5", shortName: "W05", ladvID: "W5", dlvID: "W5"),
        Age(name: "Kinder W6", shortName: "W06", ladvID: "W6", dlvID: "W6"),
        Age(name: "Kinder W7", shortName: "W07", ladvID: "W7", dlvID: "W7"),
        Age(name: "Kinder W8", shortName: "W08", ladvID: "W8", dlvID: "W8"),
        Age(name: "Kinder W9", shortName: "W09", ladvID: "W9", dlvID: "W9"),
        Age(name: "Kinder W10", shortName: "W10", ladvID: "W10", dlvID: "W10"),
        Age(name: "Kinder W11", shortName: "W11", ladvID: "W11", dlvID: "W11"),
        Age(name: "Jugend W12", shortName: "W12", ladvID: "W12", dlvID: "W12"),
        Age(name: "Jugend W13", shortName: "W13", ladvID: "W13", dlvID: "W13"),
        Age(name: "Jugend W14", shortName: "W14", ladvID: "W14", dlvID: "W14"),
        Age(name: "Jugend W15", shortName: "W15", ladvID: "W15", dlvID: "W15"),
        Age(name: "weibliche Kinder U8", shortName: "WK U8", ladvID: "WKU8", dlvID: "SIE"),
        Age(name: "weibliche Kinder U10", shortName: "WK U10", ladvID: "WKU10", dlvID: "SID"),
        Age(name: "weibliche Kinder U12", shortName: "WK U12", ladvID: "WKU12", dlvID: "SIC"),
        Age(name: "weibliche Jugend U14", shortName: "WJ U14", ladvID: "WJU14", dlvID: "SIB"),
        Age(name: "weibliche Jugend U16", shortName: "WJ U16", ladvID: "WJU16", dlvID: "SIA"),
        Age(name: "weibliche Jugend U18", shortName: "WJ U18", ladvID: "WJU18", dlvID: "WJB"),
        Age(name: "weibliche Jugend U20", shortName: "WJ U20", ladvID: "WJU20", dlvID: "WJA"),
        Age(name: "Juniorinnen U23", shortName: "W U23", ladvID: "WU23", dlvID: "JI"),
        Age(name: "Frauen", shortName: "Frauen", ladvID: "W", dlvID: "W"),
        Age(name: "Seniorinnen W30", shortName: "W30", ladvID: "W30", dlvID: "W30"),
        Age(name: "Seniorinnen W35", shortName: "W35", ladvID: "W35", dlvID: "W35"),
        Age(name: "Seniorinnen W40", shortName: "W40", ladvID: "W40", dlvID: "W40"),
        Age(name: "Seniorinnen W45", shortName: "W45", ladvID: "W45", dlvID: "W45"),
        Age(name: "Seniorinnen W50", shortName: "W50", ladvID: "W50", dlvID: "W50"),
        Age(name: "Seniorinnen W55", shortName: "W55", ladvID: "W55", dlvID: "W55"),
        Age(name: "Seniorinnen W60", shortName: "W60", ladvID: "W60", dlvID: "W60"),
        Age(name: "Seniorinnen W65", shortName: "W65", ladvID: "W65", dlvID: "W65"),
        Age(name: "Seniorinnen W70", shortName: "W70", ladvID: "W70", dlvID: "W70"),
        Age(name: "Seniorinnen W75", shortName: "W75", ladvID: "W75", dlvID: "W75"),
        Age(name: "Seniorinnen W80", shortName: "W80", ladvID: "W80", dlvID: "W80"),
        Age(name: "Seniorinnen W85", shortName: "W85", ladvID: "W85", dlvID: "W85"),
        Age(name: "Seniorinnen W90", shortName: "W90", ladvID: "W90", dlvID: "W90"),
        Age(name: "Seniorinnen W95", shortName: "W95", ladvID: "W95", dlvID: "W95"),
        Age(name: "Kinder T6", shortName: "Kinder T6", ladvID: "T6", dlvID: "T6"),
        Age(name: "Kinder T7", shortName: "Kinder T7", ladvID: "T7", dlvID: "T7"),
        Age(name: "Kinder T8", shortName: "Kinder T8", ladvID: "T8", dlvID: "T8"),
        Age(name: "Kinder T9", shortName: "Kinder T9", ladvID: "T9", dlvID: "T9"),
        Age(name: "Kinder T10", shortName: "Kinder T10", ladvID: "T10", dlvID: "T10"),
        Age(name: "Kinder T11", shortName: "Kinder T11", ladvID: "T11", dlvID: "T11"),
        Age(name: "Team U8", shortName: "Team U8", ladvID: "TU8", dlvID: "TU8"),
        Age(name: "Team U10", shortName: "Team U10", ladvID: "TU10", dlvID: "TU10"),
        Age(name: "Team U12", shortName: "Team U12", ladvID: "TU12", dlvID: "TU12")
    ]
}
