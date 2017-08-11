//
//  NetworkResponseProcessingTests.swift
//  DBNetworkStack
//
//  Created by Christian Himmelsbach on 20.12.16.
//  Copyright © 2016 DBSystel. All rights reserved.
//

import XCTest
@testable import DBNetworkStack

class NetworkResponseProcessingTests: XCTestCase {
    
    var processor: NetworkResponseProcessor!
    
    override func setUp() {
        super.setUp()
        processor = NetworkResponseProcessor()
    }
    
    func testCancelError() {
        // Given
        let resource = Resource(request: URLRequest.defaultMock, parse: { _ in return 0 })
        let cancelledError = URLError(_nsError: NSError(domain: NSURLErrorDomain, code: NSURLErrorCancelled, userInfo: nil))
        
        // When
        var result: Int? = nil
        do {
            result = try processor.process(response: nil, resource: resource, data: nil, error: cancelledError)
        } catch let error as DBNetworkStackError {
            // Then
            switch error {
            case .cancelled: // Excpected
                break
            default:
                XCTFail("Expected cancelled error (got \(error)")
            }
        } catch let error {
            XCTFail("Expected DBNetworkStackError (got \(type(of:error)))")
        }
        
        XCTAssertNil(result, "Expected processing to fail")
    }
    
    struct UnknownError: Error {}
    
    func testParseThrowsUnknownError() {
        // Given
        let resource = Resource(request: URLRequest.defaultMock, parse: { _  -> Int in
            throw UnknownError() })
        let data: Data! = "Data".data(using: .utf8)
        
        // When
        do {
            _ = try processor.process(response: .defaultMock, resource: resource, data: data, error: nil)
        } catch let error as DBNetworkStackError {
            // Then
            switch error {
            case .serializationError(let description, let recievedData): // Excpected
                XCTAssertEqual(description, "Unknown serialization error")
                XCTAssertEqual(recievedData, data)
                break
            default:
                XCTFail("Expected cancelled error (got \(error)")
            }
        } catch let error {
            XCTFail("Expected DBNetworkStackError (got \(type(of:error)))")
        }
    }
    
    func testParseSucessFullWithNilResponse() {
        //Given
        let resource = Resource(request: URLRequest.defaultMock, parse: { _ in return 0 })
        
        //When
        do {
            _ = try processor.process(response: nil, resource: resource, data: Data(), error: nil)
        } catch let error as DBNetworkStackError {
            // Then
            switch error {
            case .unknownError: // Excpected
                break
            default:
                XCTFail("Expected cancelled error (got \(error)")
            }
        } catch let error {
            XCTFail("Expected DBNetworkStackError (got \(type(of:error)))")
        }
        
    }
}
