//
//  Disciplin.swift
//  Leichatletik
//
//  Created by Lukas Schmidt on 02.02.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

public struct Disciplin: Hashable {
    
    public enum Unit {
        case punkte
        case zeit
        case metrisch
        case unknown
    }
    
    public let name: String
    public let shortName: String
    public let ladvID: String
    public let dlvID: String
    public let unit: Unit
    
    public init(dlvID: String) {
        if let newSelf = Disciplin.all.first(where: { $0.dlvID == dlvID }) {
            self = newSelf
        } else {
            self.name = dlvID
            self.shortName = dlvID
            self.ladvID = dlvID
            self.dlvID = dlvID
            self.unit = .unknown
        }
    }
    
    public init(ladvId: String) {
        if let newSelf = Disciplin.all.first(where: { $0.ladvID == ladvId }) {
            self = newSelf
        } else {
            self.name = ladvId
            self.shortName = ladvId
            self.ladvID = ladvId
            self.dlvID = ladvId
            self.unit = .unknown
        }
    }
    
    public init(name: String, shortName: String, ladvID: String, dlvID: String, unit: Unit) {
        self.name = name
        self.shortName = shortName
        self.ladvID = ladvID
        self.dlvID = dlvID
        self.unit = unit
    }
    
    public static let all: [Disciplin] = [Disciplin(name: "DMM Gruppe 1", shortName: "DMM G.1", ladvID: "ADM1", dlvID: "DM1", unit: .punkte),
                                          Disciplin(name: "DMM Gruppe 2", shortName: "DMM G.2", ladvID: "ADM2", dlvID: "DM2", unit: .punkte),
                                          Disciplin(name: "DMM Gruppe 3", shortName: "DMM G.3", ladvID: "ADM3", dlvID: "DM3", unit: .punkte),
                                          Disciplin(name: "DMM Gruppe 4", shortName: "DMM G.4", ladvID: "ADM4", dlvID: "DM4", unit: .punkte),
                                          Disciplin(name: "30 m Lauf", shortName: "30m", ladvID: "L30", dlvID: "30", unit: .zeit),
                                          Disciplin(name: "40 m Lauf", shortName: "40m", ladvID: "L40", dlvID: "40", unit: .zeit),
                                          Disciplin(name: "50 m Lauf", shortName: "50m", ladvID: "L50", dlvID: "50", unit: .zeit),
                                          Disciplin(name: "60 m Lauf", shortName: "60m", ladvID: "L60", dlvID: "60", unit: .zeit),
                                          Disciplin(name: "75 m Lauf", shortName: "75m", ladvID: "L75", dlvID: "75", unit: .zeit),
                                          Disciplin(name: "80 m Lauf", shortName: "80m", ladvID: "L80", dlvID: "80", unit: .zeit),
                                          Disciplin(name: "100 m Lauf", shortName: "100m", ladvID: "L100", dlvID: "100", unit: .zeit),
                                          Disciplin(name: "150 m Lauf", shortName: "150m", ladvID: "L150", dlvID: "150", unit: .zeit),
                                          Disciplin(name: "200 m Lauf", shortName: "200m", ladvID: "L200", dlvID: "200", unit: .zeit),
                                          Disciplin(name: "300 m Lauf", shortName: "300m", ladvID: "L300", dlvID: "300", unit: .zeit),
                                          Disciplin(name: "400 m Lauf", shortName: "400m", ladvID: "L400", dlvID: "400", unit: .zeit),
                                          Disciplin(name: "500 m Lauf", shortName: "500m", ladvID: "L500", dlvID: "500", unit: .zeit),
                                          Disciplin(name: "600 m Lauf", shortName: "600m", ladvID: "L600", dlvID: "600", unit: .zeit),
                                          Disciplin(name: "800 m Lauf", shortName: "800m", ladvID: "L800", dlvID: "800", unit: .zeit),
                                          Disciplin(name: "1.000 m Lauf", shortName: "1.000m", ladvID: "L1K0", dlvID: "1K0", unit: .zeit),
                                          Disciplin(name: "1.500 m Lauf", shortName: "1.500m", ladvID: "L1K5", dlvID: "1K5", unit: .zeit),
                                          Disciplin(name: "1 Meile", shortName: "1 Meile", ladvID: "LMEI", dlvID: "MEI", unit: .zeit),
                                          Disciplin(name: "2.000 m Lauf", shortName: "2.000m", ladvID: "L2K0", dlvID: "2K0", unit: .zeit),
                                          Disciplin(name: "3.000 m Lauf", shortName: "3.000m", ladvID: "L3K0", dlvID: "3K0", unit: .zeit),
                                          Disciplin(name: "2 Meilen ", shortName: "2 Meilen ", ladvID: "L2MEI", dlvID: "2MEI", unit: .zeit),
                                          Disciplin(name: "5.000 m Lauf", shortName: "5.000m", ladvID: "L5K0", dlvID: "5K0", unit: .zeit),
                                          Disciplin(name: "10.000 m Lauf", shortName: "10.000m", ladvID: "L10K", dlvID: "10K", unit: .zeit),
                                          Disciplin(name: "3 km Strasse", shortName: "3km Str.", ladvID: "S3K", dlvID: "3S", unit: .zeit),
                                          Disciplin(name: "3 km Strasse Mannschaft", shortName: "3km Str.M.", ladvID: "S3KM", dlvID: "3M", unit: .zeit),
                                          Disciplin(name: "5 km Strasse", shortName: "5km Str.", ladvID: "S5K", dlvID: "5S", unit: .zeit),
                                          Disciplin(name: "5 km Strasse Mannschaft", shortName: "5km Str.M.", ladvID: "S5KM", dlvID: "5M", unit: .zeit),
                                          Disciplin(name: "7,5 km Strasse", shortName: "7,5km Str.", ladvID: "S7K5", dlvID: "7K5S", unit: .zeit),
                                          Disciplin(name: "7,5 km Strasse Mannschaft", shortName: "7,5kmStr.M", ladvID: "S7K5M", dlvID: "7K5M", unit: .zeit),
                                          Disciplin(name: "10 km Strasse", shortName: "10km Str.", ladvID: "S10K", dlvID: "10S", unit: .zeit),
                                          Disciplin(name: "10 km Strasse Mannschaft", shortName: "10km Str.M", ladvID: "S10KM", dlvID: "10M", unit: .zeit),
                                          Disciplin(name: "15 km Strasse", shortName: "15km Str.", ladvID: "S15K", dlvID: "15S", unit: .zeit),
                                          Disciplin(name: "15 km Strasse Mannschaft", shortName: "15km Str.M", ladvID: "S15KM", dlvID: "15M", unit: .zeit),
                                          Disciplin(name: "20 km Strasse", shortName: "20km Str.", ladvID: "S20K", dlvID: "20S", unit: .zeit),
                                          Disciplin(name: "20 km Strasse Mannschaft", shortName: "20km Str.M", ladvID: "S20KM", dlvID: "20M", unit: .zeit),
                                          Disciplin(name: "Halbmarathon", shortName: "HM", ladvID: "SHAL", dlvID: "HAL", unit: .zeit),
                                          Disciplin(name: "Halbmarathon Mannschaft", shortName: "HM Man.", ladvID: "SHALM", dlvID: "HALM", unit: .zeit),
                                          Disciplin(name: "25 km Strasse", shortName: "25km Str.", ladvID: "S25K", dlvID: "25S", unit: .zeit),
                                          Disciplin(name: "25 km Strasse Mannschaft", shortName: "25km Str.M", ladvID: "S25KM", dlvID: "25M", unit: .zeit),
                                          Disciplin(name: "Marathon", shortName: "Marathon", ladvID: "SMAR", dlvID: "MAR", unit: .zeit),
                                          Disciplin(name: "Marathon Mannschaft", shortName: "Marathon M", ladvID: "SMARM", dlvID: "MARM", unit: .zeit),
                                          Disciplin(name: "100 km Strasse", shortName: "100km Str.", ladvID: "S100K", dlvID: "100S", unit: .zeit),
                                          Disciplin(name: "100 km Strasse Mannschaft", shortName: "100kmStr.M", ladvID: "S100KM", dlvID: "100M", unit: .zeit),
                                          Disciplin(name: "Volkslauf", shortName: "Volkslauf", ladvID: "SVOL", dlvID: "VOL", unit: .zeit),
                                          Disciplin(name: "Volkslauf Mannschaft", shortName: "Volksl. M.", ladvID: "SVOLM", dlvID: "VOLM", unit: .zeit),
                                          Disciplin(name: "Berglauf", shortName: "Brgl.", ladvID: "SBRG", dlvID: "BRG", unit: .zeit),
                                          Disciplin(name: "Berglauf Mannschaft", shortName: "Brgl. Man.", ladvID: "SBRGM", dlvID: "BRGM", unit: .zeit),
                                          Disciplin(name: "Cross Lauf", shortName: "Crs. Lauf", ladvID: "SCR", dlvID: "CROS", unit: .zeit),
                                          Disciplin(name: "Cross Lauf Kurz", shortName: "Crs. Kurz", ladvID: "SCRK", dlvID: "CROK", unit: .zeit),
                                          Disciplin(name: "Cross Lauf Lang", shortName: "Crs. Lang", ladvID: "SCRL", dlvID: "CROL", unit: .zeit),
                                          Disciplin(name: "Cross Sprint", shortName: "Crs.Sprint", ladvID: "SCRS", dlvID: "CRSS", unit: .zeit),
                                          Disciplin(name: "Strassenlauf", shortName: "Str.-lauf", ladvID: "SL", dlvID: "SL", unit: .zeit),
                                          Disciplin(name: "Strassenlauf Kurz", shortName: "Str. Kurz", ladvID: "SLK", dlvID: "SLK", unit: .zeit),
                                          Disciplin(name: "Strassenlauf Lang", shortName: "Str. Lang", ladvID: "SLL", dlvID: "SLL", unit: .zeit),
                                          Disciplin(name: "Waldlauf", shortName: "Waldlauf", ladvID: "SWLD", dlvID: "WLD", unit: .zeit),
                                          Disciplin(name: "30 m Hürden", shortName: "30m Hürd.", ladvID: "H30", dlvID: "30H", unit: .zeit),
                                          Disciplin(name: "50 m Hürden", shortName: "50m Hürd.", ladvID: "H50", dlvID: "50H", unit: .zeit),
                                          Disciplin(name: "60 m Hürden", shortName: "60m Hürd.", ladvID: "H60", dlvID: "60H", unit: .zeit),
                                          Disciplin(name: "80 m Hürden", shortName: "80m Hürd.", ladvID: "H80", dlvID: "80H", unit: .zeit),
                                          Disciplin(name: "100 m Hürden", shortName: "100m Hürd.", ladvID: "H100", dlvID: "100H", unit: .zeit),
                                          Disciplin(name: "110 m Hürden", shortName: "110m Hürd.", ladvID: "H110", dlvID: "110H", unit: .zeit),
                                          Disciplin(name: "200 m Hürden", shortName: "200m Hürd.", ladvID: "H200", dlvID: "200H", unit: .zeit),
                                          Disciplin(name: "300 m Hürden", shortName: "300m Hürd.", ladvID: "H300", dlvID: "300H", unit: .zeit),
                                          Disciplin(name: "400 m Hürden", shortName: "400m Hürd.", ladvID: "H400", dlvID: "400H", unit: .zeit),
                                          Disciplin(name: "1.500 m Hindernis", shortName: "1.500m Hin", ladvID: "H1K5", dlvID: "1K5H", unit: .zeit),
                                          Disciplin(name: "2.000 m Hindernis", shortName: "2.000m Hin", ladvID: "H2K0", dlvID: "2K0H", unit: .zeit),
                                          Disciplin(name: "3.000 m Hindernis", shortName: "3.000m Hin", ladvID: "H3K0", dlvID: "3K0H", unit: .zeit),
                                          Disciplin(name: "4 x 50 m Staffel", shortName: "4x50m", ladvID: "X4X5", dlvID: "4X5", unit: .zeit),
                                          Disciplin(name: "4 x 60 m Staffel", shortName: "4x60m", ladvID: "X4X6", dlvID: "4X6", unit: .zeit),
                                          Disciplin(name: "4 x 75 m Staffel", shortName: "4x75m", ladvID: "X4X7", dlvID: "4X7", unit: .zeit),
                                          Disciplin(name: "4 x 100 m Staffel", shortName: "4x100m", ladvID: "X4X1", dlvID: "4X1", unit: .zeit),
                                          Disciplin(name: "4 x 200 m Staffel", shortName: "4x200m", ladvID: "X4X2", dlvID: "4X2", unit: .zeit),
                                          Disciplin(name: "4 x 400 m Staffel", shortName: "4x400m", ladvID: "X4X4", dlvID: "4X4", unit: .zeit),
                                          Disciplin(name: "3 x 800 m Staffel", shortName: "3x800m", ladvID: "X3X8", dlvID: "3X8", unit: .zeit),
                                          Disciplin(name: "4 x 800 m Staffel", shortName: "4x800m", ladvID: "X4X8", dlvID: "4X8", unit: .zeit),
                                          Disciplin(name: "3 x 1.000 m Staffel", shortName: "3x1.000m", ladvID: "X3X1", dlvID: "3X1", unit: .zeit),
                                          Disciplin(name: "4 x 1.500 m Staffel", shortName: "4x1.500m", ladvID: "X4X15", dlvID: "4X15", unit: .zeit),
                                          Disciplin(name: "6 x 50 m Staffel", shortName: "6x50m", ladvID: "X6X5", dlvID: "6X5", unit: .zeit),
                                          Disciplin(name: "Olympische Staffel", shortName: "Olymp.Stf.", ladvID: "XOLY", dlvID: "OLY", unit: .zeit),
                                          Disciplin(name: "Marathon Staffel", shortName: "Mar.Stfl.", ladvID: "XMARS", dlvID: "MARS", unit: .zeit),
                                          Disciplin(name: "Pendelstaffel", shortName: "Pndlstfl.", ladvID: "XPEN", dlvID: "PEN", unit: .zeit),
                                          Disciplin(name: "Schwedenstaffel", shortName: "Schwedens.", ladvID: "XSWE", dlvID: "SWE", unit: .zeit),
                                          Disciplin(name: "1.000 m Bahngehen", shortName: "1.000BG", ladvID: "GB1", dlvID: "1G", unit: .zeit),
                                          Disciplin(name: "2.000 m Bahngehen", shortName: "2.000BG", ladvID: "GB2", dlvID: "2G", unit: .zeit),
                                          Disciplin(name: "3.000 m Bahngehen", shortName: "3.000BG", ladvID: "GB3", dlvID: "3G", unit: .zeit),
                                          Disciplin(name: "5.000 m Bahngehen", shortName: "5.000BG", ladvID: "GB5", dlvID: "5G", unit: .zeit),
                                          Disciplin(name: "10.000 m Bahngehen", shortName: "10.000BG", ladvID: "GB10", dlvID: "10G", unit: .zeit),
                                          Disciplin(name: "20.000 m Bahngehen", shortName: "20.000BG", ladvID: "GB20", dlvID: "20G", unit: .zeit),
                                          Disciplin(name: "50.000 m Bahngehen", shortName: "50.000BG", ladvID: "GB50", dlvID: "50G", unit: .zeit),
                                          Disciplin(name: "1 km Strassengehen", shortName: "1 km SG", ladvID: "GS1", dlvID: "1GS", unit: .zeit),
                                          Disciplin(name: "1 km Strassengehen Mannschaft", shortName: "1km SG M.", ladvID: "GS1M", dlvID: "1GM", unit: .zeit),
                                          Disciplin(name: "2 km Strassengehen", shortName: "2 km SG", ladvID: "GS2", dlvID: "2GS", unit: .zeit),
                                          Disciplin(name: "2 km Strassengehen Mannschaft", shortName: "2km SG M.", ladvID: "GS2M", dlvID: "2GM", unit: .zeit),
                                          Disciplin(name: "3 km Strassengehen", shortName: "3 km SG", ladvID: "GS3", dlvID: "3GS", unit: .zeit),
                                          Disciplin(name: "3 km Strassengehen Mannschaft", shortName: "3km SG M.", ladvID: "GS3M", dlvID: "3GM", unit: .zeit),
                                          Disciplin(name: "5 km Strassengehen", shortName: "5 km SG", ladvID: "GS5", dlvID: "5GS", unit: .zeit),
                                          Disciplin(name: "5 km Strassengehen Mannschaft", shortName: "5km SG M.", ladvID: "GS5M", dlvID: "5GM", unit: .zeit),
                                          Disciplin(name: "10 km Strassengehen", shortName: "10 km SG", ladvID: "GS10", dlvID: "10GS", unit: .zeit),
                                          Disciplin(name: "10 km Strassengehen Mannschaft", shortName: "10km SG M.", ladvID: "GS10M", dlvID: "10GM", unit: .zeit),
                                          Disciplin(name: "20 km Strassengehen", shortName: "20 km SG", ladvID: "GS20", dlvID: "20GS", unit: .zeit),
                                          Disciplin(name: "20 km Strassengehen Mannschaft", shortName: "20km SG M.", ladvID: "GS20M", dlvID: "20GM", unit: .zeit),
                                          Disciplin(name: "30 km Strassengehen", shortName: "30 km SG", ladvID: "GS30", dlvID: "30GS", unit: .zeit),
                                          Disciplin(name: "30 km Strassengehen Mannschaft", shortName: "30km SG M.", ladvID: "GS30M", dlvID: "30GM", unit: .zeit),
                                          Disciplin(name: "50 km Strassengehen", shortName: "50 km SG", ladvID: "GS50", dlvID: "50GS", unit: .zeit),
                                          Disciplin(name: "50 km Strassengehen Mannschaft", shortName: "50km SG M.", ladvID: "GS50M", dlvID: "50GM", unit: .zeit),
                                          Disciplin(name: "Hochsprung", shortName: "Hoch", ladvID: "THOC", dlvID: "HOC", unit: .metrisch),
                                          Disciplin(name: "Stabhochsprung", shortName: "Stab", ladvID: "TSTA", dlvID: "STA", unit: .metrisch),
                                          Disciplin(name: "Standweitsprung", shortName: "Standweit", ladvID: "TSTW", dlvID: "STW", unit: .metrisch),
                                          Disciplin(name: "Weitsprung", shortName: "Weit", ladvID: "TWEI", dlvID: "WEI", unit: .metrisch),
                                          Disciplin(name: "Weitsprungzone", shortName: "Weitzone", ladvID: "TWEZ", dlvID: "WEZ", unit: .metrisch),
                                          Disciplin(name: "Dreisprung", shortName: "Dreispr.", ladvID: "TDRE", dlvID: "DRE", unit: .metrisch),
                                          Disciplin(name: "Kugelstoß", shortName: "Kugel", ladvID: "TKUG", dlvID: "KUG", unit: .metrisch),
                                          Disciplin(name: "Gewichtwurf", shortName: "Gwicht", ladvID: "TGEW", dlvID: "GEW", unit: .metrisch),
                                          Disciplin(name: "Diskuswurf", shortName: "Diskus", ladvID: "TDIS", dlvID: "DIS", unit: .metrisch),
                                          Disciplin(name: "Hammerwurf", shortName: "Hammer", ladvID: "THAM", dlvID: "HAM", unit: .metrisch),
                                          Disciplin(name: "Speerwurf", shortName: "Speer", ladvID: "TSPE", dlvID: "SPE", unit: .metrisch),
                                          Disciplin(name: "Schlagball", shortName: "SBall", ladvID: "TSBAL", dlvID: "SCH", unit: .metrisch),
                                          Disciplin(name: "Ballwurf", shortName: "Ball", ladvID: "TBAL", dlvID: "BAL", unit: .metrisch),
                                          Disciplin(name: "Schleuderball", shortName: "SchlBall", ladvID: "TSLBAL", dlvID: "SBA", unit: .metrisch),
                                          Disciplin(name: "Steinstoß", shortName: "Stein", ladvID: "TSTE", dlvID: "STE", unit: .metrisch),
                                          Disciplin(name: "5er Sprunglauf", shortName: "5er Spglf.", ladvID: "TFER", dlvID: "FER", unit: .metrisch),
                                          Disciplin(name: "Vortex (Heuler)", shortName: "Vortex", ladvID: "TVOR", dlvID: "VOR", unit: .metrisch),
                                          Disciplin(name: "2-Kampf", shortName: "2-Kampf", ladvID: "M2K", dlvID: "2-K", unit: .punkte),
                                          Disciplin(name: "3-Kampf", shortName: "3-Kampf", ladvID: "M3K", dlvID: "3-K", unit: .punkte),
                                          Disciplin(name: "3-Kampf Mannschaft", shortName: "3-K Man.", ladvID: "M3KM", dlvID: "3-M", unit: .punkte),
                                          Disciplin(name: "4-Kampf", shortName: "4-Kampf", ladvID: "M4K", dlvID: "4-K", unit: .punkte),
                                          Disciplin(name: "4-Kampf Mannschaft", shortName: "4-K Man.", ladvID: "M4KM", dlvID: "4-M", unit: .punkte),
                                          Disciplin(name: "5-Kampf", shortName: "5-Kampf", ladvID: "M5K", dlvID: "5-K", unit: .punkte),
                                          Disciplin(name: "5-Kampf Mannschaft", shortName: "5-K Man.", ladvID: "M5KM", dlvID: "5-M", unit: .punkte),
                                          Disciplin(name: "6-Kampf", shortName: "6-Kampf", ladvID: "M6K", dlvID: "6-K", unit: .punkte),
                                          Disciplin(name: "6-Kampf Mannschaft", shortName: "6-K Man.", ladvID: "M6KM", dlvID: "6-M", unit: .punkte),
                                          Disciplin(name: "7-Kampf", shortName: "7-Kampf", ladvID: "M7K", dlvID: "7-K", unit: .punkte),
                                          Disciplin(name: "7-Kampf Mannschaft", shortName: "7-K Man.", ladvID: "M7KM", dlvID: "7-M", unit: .punkte),
                                          Disciplin(name: "8-Kampf", shortName: "8-Kampf", ladvID: "M8K", dlvID: "8-K", unit: .punkte),
                                          Disciplin(name: "8-Kampf Mannschaft", shortName: "8-K Man.", ladvID: "M8KM", dlvID: "8-M", unit: .punkte),
                                          Disciplin(name: "9-Kampf", shortName: "9-Kampf", ladvID: "M9K", dlvID: "9-K", unit: .punkte),
                                          Disciplin(name: "9-Kampf Mannschaft", shortName: "9-K Man.", ladvID: "M9KM", dlvID: "9-M", unit: .punkte),
                                          Disciplin(name: "10-Kampf", shortName: "10-Kampf", ladvID: "M10K", dlvID: "10-K", unit: .punkte),
                                          Disciplin(name: "10-Kampf Mannschaft", shortName: "10-K Man.", ladvID: "M10KM", dlvID: "10-M", unit: .punkte),
                                          Disciplin(name: "Block Sprint/Sprung", shortName: "Block S/S", ladvID: "MBLS", dlvID: "BLS", unit: .punkte), 
                                          Disciplin(name: "Block Lauf", shortName: "Block L", ladvID: "MBLL", dlvID: "BLL", unit: .punkte),
                                          Disciplin(name: "Block Wurf", shortName: "Block W", ladvID: "MBLW", dlvID: "BLW", unit: .punkte),
                                          Disciplin(name: "Block Mannschaft", shortName: "Block Man.", ladvID: "MBLM", dlvID: "BLM", unit: .punkte),
                                          Disciplin(name: "Block Einzel", shortName: "Block E", ladvID: "MBLE", dlvID: "BLE", unit: .punkte),
                                          Disciplin(name: "Block Basis", shortName: "Block B", ladvID: "MBLB", dlvID: "BLB", unit: .punkte),
                                          Disciplin(name: "Werfer 3-Kampf", shortName: "Wrfr 3K", ladvID: "MW3K", dlvID: "W3-K", unit: .punkte),
                                          Disciplin(name: "Werfer 4-Kampf", shortName: "Wrfr 4K", ladvID: "MW4K", dlvID: "W4-K", unit: .punkte),
                                          Disciplin(name: "Werfer 5-Kampf", shortName: "Wrfr 5K", ladvID: "MW5K", dlvID: "W5-K", unit: .punkte),
                                          Disciplin(name: "Werfer 5-Kampf Mannschaft", shortName: "Wrfr5K Man", ladvID: "MW5KM", dlvID: "W5-M", unit: .punkte),
                                          Disciplin(name: "Werfer 6-Kampf", shortName: "Wrfr 6K", ladvID: "MW6K", dlvID: "W6-K", unit: .punkte),
                                          Disciplin(name: "Viertelstundenlauf", shortName: "1/4Stdlauf", ladvID: "AVSTD", dlvID: "VSTD", unit: .metrisch),
                                          Disciplin(name: "Halbstundenlauf", shortName: "1/2Stdlauf", ladvID: "AHSTD", dlvID: "HSTD", unit: .metrisch),
                                          Disciplin(name: "Stundenlauf", shortName: "Std.-lauf", ladvID: "ASTD", dlvID: "STD", unit: .metrisch),
                                          Disciplin(name: "100m Rollstuhl", shortName: "100m R.", ladvID: "BL100", dlvID: "R100", unit: .zeit),
                                          Disciplin(name: "200m Rollstuhl", shortName: "200m R.", ladvID: "BL200", dlvID: "R200", unit: .zeit),
                                          Disciplin(name: "400m Rollstuhl", shortName: "400m R.", ladvID: "BL400", dlvID: "R400", unit: .zeit),
                                          Disciplin(name: "800m Rollstuhl", shortName: "800m R.", ladvID: "BL800", dlvID: "R800", unit: .zeit),
                                          Disciplin(name: "1500m Rollstuhl", shortName: "1500m R.", ladvID: "BL1K5", dlvID: "R1K5", unit: .zeit),
                                          Disciplin(name: "3000m Rollstuhl", shortName: "3000m R.", ladvID: "BL3K0", dlvID: "R3K0", unit: .zeit),
                                          Disciplin(name: "5000m Rollstuhl", shortName: "5000m R.", ladvID: "BL5K0", dlvID: "R5K0", unit: .zeit),
                                          Disciplin(name: "10.000m Rollstuhl", shortName: "10.000m R.", ladvID: "BL10K", dlvID: "R10K", unit: .zeit),
                                          Disciplin(name: "10km Rollstuhl", shortName: "10km R.", ladvID: "BS10K", dlvID: "R10S", unit: .zeit),
                                          Disciplin(name: "Marathon Rollstuhl", shortName: "Marathon R", ladvID: "BSMAR", dlvID: "RMAR", unit: .zeit),
                                          Disciplin(name: "4x100m Rollstuhl", shortName: "4x100m R.", ladvID: "BX4X1", dlvID: "R4X1", unit: .zeit),
                                          Disciplin(name: "4x400m Rollstuhl", shortName: "4x400m R.", ladvID: "BX4X4", dlvID: "R4X4", unit: .zeit),
                                          Disciplin(name: "Kugel Rollstuhl", shortName: "Kugel R.", ladvID: "BTKUG", dlvID: "RKUG", unit: .metrisch),
                                          Disciplin(name: "Diskus Rollstuhl", shortName: "Diskus R.", ladvID: "BTDIS", dlvID: "RDIS", unit: .metrisch),
                                          Disciplin(name: "Speer Rollstuhl", shortName: "Speer R.", ladvID: "BTSPE", dlvID: "RSPE", unit: .metrisch),
                                          Disciplin(name: "Keule", shortName: "Keule", ladvID: "BKEUL", dlvID: "RKLE", unit: .metrisch)]
}




