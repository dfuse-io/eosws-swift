//
//  eoswsTests.swift
//  eoswsTests
//
//  Created by Charles Billette on 2018-11-09.
//  Copyright © 2018 dfuse. All rights reserved.
//

import XCTest
@testable import eosws

class eoswsTests: XCTestCase {

    override func setUp() {
        
    }

    override func tearDown() {
        
    }

    func testExample() {
        let expectation = self.expectation(description: #function)
        
        let token = "eyJhbGciOiJLTVNFUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1NDQwMzEzMDksImp0aSI6IjkwM2E4YjI0LWIxMzEtNGQ1YS04ZjVjLWExOThhNTg2NjdjMSIsImlhdCI6MTU0MTQzOTMwOSwiaXNzIjoiZGZ1c2UuaW8iLCJzdWIiOiJDaVFBNmNieWV4eDZJSG9Pd01xNkFXaTQ0amdJQTRvR0hET0RvNWJTYm9yL0RMUG1GM1lTT1FBL0NMUnRVZi8xdnhLc1pmTGpmeU9pamdtSzhlV2RoU0pRUXA4N09EamFQdVEyK2M5MTV4RjRidFkyUEZXODZ0VW9aU3lvODdyem13PT0iLCJ0aWVyIjoiY3VzdC12MSIsInNjb3BlcyI6IioiLCJzdGJsayI6MSwidiI6MX0.pNPxqeiN86MCGx4PgHKrDDhDXK_0N14Ja1kwciyrV7qNkHiAtwECIv9JjXH7NOAvOYP_u2S49EFV9dT-fYTsrw"
        let eosws = try? EOSWS(forEnpoint: "wss://staging-kylin.eos.dfuse.io/v1/stream", token: token, origin: "origin.example.com")
        
        waitForExpectations(timeout: 10)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
