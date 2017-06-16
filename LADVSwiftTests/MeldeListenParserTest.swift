//
//  MeldeListenParserTest.swift
//  LADVSwift
//
//  Created by Lukas Schmidt on 09.06.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import XCTest
import LADVSwift

class MeldeListenParserTest: XCTestCase {
    
    func testParse() {
        //Given
        let bundle = Bundle(for: MeldeListenParserTest.self)
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
    
    func testParse3() {
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
        let x = parser[3].disciplins.first?.attendees
        XCTAssertEqual(parser[3].disciplins.first?.attendees.first?.attendees.first?.name, "Moritz Venker")
        XCTAssertEqual(parser[3].disciplins.first?.attendees.last?.attendees.first?.name, "Raphael Ernst")
        
        XCTAssertEqual(parser[6].disciplins[2].attendees.count, 6)
        XCTAssertEqual(parser[6].disciplins[2].disciplin.dlvID, "3-K")
        print(parser[6].disciplins)
    }
}
