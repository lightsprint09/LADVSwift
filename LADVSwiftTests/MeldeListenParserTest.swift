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
        XCTAssertEqual(parser[6].age, Age(dlvID: "M"))
        XCTAssertEqual(parser[8].age, Age(dlvID: "W13"))
        XCTAssertEqual(parser[8].disciplins[0].attendees.count, 4)
        //XCTAssertEqual(parser.last?.disciplins.count, 11)
        //XCTAssertEqual(parser.last?.disciplins[8].disciplin.name, "Weitsprung")
        //XCTAssertEqual(parser.last?.disciplins.last?.attendees.count, 3)
    }

    func testParser6Staffel() throws {
        let bundle = Bundle.module
        let url = bundle.url(forResource: "meldungStaffel", withExtension: "html")

        let htmlString = try String(contentsOf: url!)
        let parser = try MeldungParser().parse(html: htmlString)

        XCTAssertEqual(parser.count, 6)
    }

    func testParser7Empty() throws {
        let bundle = Bundle.module
        let url = bundle.url(forResource: "meldung6", withExtension: "html")

        let htmlString = try String(contentsOf: url!)
        let parser = try MeldungParser().parse(html: htmlString)

        XCTAssertEqual(parser[1].disciplins[0].attendees.count, 0)
    }
}
