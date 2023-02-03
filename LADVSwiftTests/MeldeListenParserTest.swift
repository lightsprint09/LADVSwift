//
//  MeldeListenParserTest.swift
//  LADVSwift
//
//  Created by Lukas Schmidt on 09.06.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import XCTest
@testable import LADVSwift

class MeldeListenParserTest: XCTestCase {
    
    func testParse() {
        //Given
        let bundle = Bundle.module
        let url = bundle.url(forResource: "LADVMEldeListe", withExtension: "html")
        
        let htmlString = try? String(contentsOf: url!)
        guard let parser = try? MeldungParser().parse(html: htmlString!) else {
            XCTFail()
            return
        }
        
        //Then
        XCTAssertEqual(parser.count, 39)
        
        XCTAssertEqual(parser.first!.age, Age(dlvID: "M14"))
        XCTAssertEqual(parser.first?.disciplins.count, 1)
        XCTAssertEqual(parser.first!.disciplins.first?.attendees.count, 4)
        
        XCTAssertEqual(parser[2].disciplins.first?.attendees.count, 6)
        XCTAssertEqual(parser[2].disciplins.first?.attendees.first?.attendees.count, 3)
        XCTAssertEqual(parser[2].disciplins.first?.attendees.first?.attendees.first?.name, "Rami Rudolph")
        XCTAssertEqual(parser[2].disciplins.first?.attendees.first?.attendees.first?.number, 621081)
        XCTAssertEqual(parser[2].disciplins.first?.attendees.first?.attendees.first?.yearOfBirth, 2006)
        XCTAssertEqual(parser[2].disciplins.first?.attendees.first?.attendees.first?.id, "247180")
        
        XCTAssertEqual(parser[9].disciplins.first?.requiredPerformance, "34:00,00")
        
        
    }
    
    func testParse2() {
        //Given
        let bundle = Bundle(for: MeldeListenParserTest.self)
        let url = bundle.url(forResource: "meldung2", withExtension: "html")
        
        let htmlString = try? String(contentsOf: url!)
        guard let parser = try? MeldungParser().parse(html: htmlString!) else {
            XCTFail()
            return
        }
        
        //Then
        XCTAssertEqual(parser.count, 10)
        XCTAssertEqual(parser.first?.disciplins.first?.disciplin.dlvID, "800")
        XCTAssertEqual(parser.first?.disciplins.last?.disciplin.dlvID, "WEI")
        XCTAssertEqual(parser.first?.disciplins.count, 2)
    }
    
    func testPerformance() {
        let bundle = Bundle(for: MeldeListenParserTest.self)
        let url = bundle.url(forResource: "meldung2", withExtension: "html")
        
        let htmlString = try? String(contentsOf: url!)
        measure({
            try? MeldungParser().parse(html: htmlString!)
        })
    }
    
    func testParse3() {
        //https://ladv.de/meldung/teilnehmer/14637
        //Given
        let bundle = Bundle(for: MeldeListenParserTest.self)
        let url = bundle.url(forResource: "meldung3", withExtension: "html")
        
        let htmlString = try? String(contentsOf: url!)
        guard let parser = try? MeldungParser().parse(html: htmlString!) else {
            XCTFail()
            return
        }
        
        //Then
        XCTAssertEqual(parser[3].age.dlvID, "M6")
        XCTAssertEqual(parser[3].disciplins.first?.attendees.count, 2)
        XCTAssertEqual(parser[3].disciplins.first?.attendees.first?.attendees.first?.name, "Moritz Venker")
        XCTAssertEqual(parser[3].disciplins.first?.attendees.last?.attendees.first?.name, "Raphael Ernst")
        XCTAssertNotNil(parser[3].disciplins.first?.attendees.last?.attendees.first?.toAthlete())
        
        XCTAssertEqual(parser[6].disciplins[2].attendees.count, 6)
        XCTAssertEqual(parser[6].disciplins[2].disciplin.dlvID, "3-K")
    }
    
    func testParser4() {
        //https://ladv.de/meldung/teilnehmer/14136
        let bundle = Bundle(for: MeldeListenParserTest.self)
        let url = bundle.url(forResource: "meldung4", withExtension: "html")
        
        let htmlString = try? String(contentsOf: url!)
        guard let parser = try? MeldungParser().parse(html: htmlString!) else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(parser.last?.disciplins.count, 11)
        XCTAssertEqual(parser.last?.disciplins[8].disciplin.name, "Weitsprung")
        XCTAssertEqual(parser.last?.disciplins.last?.attendees.count, 3)
    }

    func testParser5() throws {
        // https://ladv.de/meldung/teilnehmer/33614
        let bundle = Bundle.module
        let url = bundle.url(forResource: "meldung5", withExtension: "html")

        let htmlString = try String(contentsOf: url!)
        let parser = try MeldungParser().parse(html: htmlString)

        XCTAssertEqual(parser.count, 14)
        XCTAssertEqual(parser.first, MeldungPerAge(
            age: Age(dlvID: "M12"),
            disciplins: [
                AttendingDisciplins(
                    requiredPerformance: nil,
                    disciplin: .init(dlvID: "STA"),
                    attendees: [
                        Meldung(performance: nil, rank: nil, region: Region(id: "WÜ")!, clubName: "LG Leinfelden-Echterdingen", attendees: [
                           Attendee(id: "472443", name: "Willi Lehmpfuhl", number: 53355, yearOfBirth: 2011)
                        ])
                    ]
                )
            ]))

        XCTAssertEqual(parser[2], MeldungPerAge(
            age: Age(dlvID: "M14"),
            disciplins: [
                AttendingDisciplins(
                    requiredPerformance: nil,
                    disciplin: .init(dlvID: "STA"),
                    attendees: [
                        Meldung(performance: "2,05", rank: nil, region: Region(id: "WÜ")!, clubName: "SG Weinstadt", attendees: [
                           Attendee(id: "426513", name: "Fill Mikschy", number: 52572, yearOfBirth: 2009)
                        ])
                    ]
                )
            ]))
        //XCTAssertEqual(parser.last?.disciplins.count, 11)
        //XCTAssertEqual(parser.last?.disciplins[8].disciplin.name, "Weitsprung")
        //XCTAssertEqual(parser.last?.disciplins.last?.attendees.count, 3)
    }
}
