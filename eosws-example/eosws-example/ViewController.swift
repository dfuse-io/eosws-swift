//
//  ViewController.swift
//  eosws-example
//
//  Created by Charles Billette on 2018-11-09.
//  Copyright © 2018 dfuse. All rights reserved.
//

import UIKit
import eosws


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let token = "eyJhbGciOiJLTVNFUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1NDQwMzEzMDksImp0aSI6IjkwM2E4YjI0LWIxMzEtNGQ1YS04ZjVjLWExOThhNTg2NjdjMSIsImlhdCI6MTU0MTQzOTMwOSwiaXNzIjoiZGZ1c2UuaW8iLCJzdWIiOiJDaVFBNmNieWV4eDZJSG9Pd01xNkFXaTQ0amdJQTRvR0hET0RvNWJTYm9yL0RMUG1GM1lTT1FBL0NMUnRVZi8xdnhLc1pmTGpmeU9pamdtSzhlV2RoU0pRUXA4N09EamFQdVEyK2M5MTV4RjRidFkyUEZXODZ0VW9aU3lvODdyem13PT0iLCJ0aWVyIjoiY3VzdC12MSIsInNjb3BlcyI6IioiLCJzdGJsayI6MSwidiI6MX0.pNPxqeiN86MCGx4PgHKrDDhDXK_0N14Ja1kwciyrV7qNkHiAtwECIv9JjXH7NOAvOYP_u2S49EFV9dT-fYTsrw"
        
        if let eosws = try? EOSWS(forEnpoint: "wss://mainnet.eos.dfuse.io/v1/stream", token: token, origin: "origin.example.com"){
            
//            let getTableRowsRequest = GetTableRows(account: "eosio", scope: "eosio", table: "producers")
//            try? getTableRowsRequest.send(with: eosws, withRequestID: "abc", fetch: true, listen: false)
            
//            let getActionTraces = GetActionTraces(account: "eosio.token", actionName: "transfer")
//            try? getActionTraces.send(with: eosws, withRequestID: "abc")
            
            let getTrasactionLifeCycle = GetTransactionLifecycle(withTransactionID: "775ec1d06805cd80fb37ff790127d6946a8f20a395d3635693b1e49cb214eb97")
            try? getTrasactionLifeCycle.send(with: eosws, withRequestID: "abc")
        }
    }
}

