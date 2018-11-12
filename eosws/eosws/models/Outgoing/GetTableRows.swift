//
//  GetTableRows.swift
//  eosws
//
//  Created by Charles Billette on 2018-11-09.
//  Copyright © 2018 dfuse. All rights reserved.
//

import Foundation
import SwiftWebSocket

public class GetTableRows: Encodable{
    let code: String
    let scope: String
    let table: String
    let json: Bool
    var request: OutgoingMessage!
    
    enum CodingKeys: String, CodingKey {
        case code, scope, table, json, data
    }
    
    public init(withAccount account: String, scope: String, table: String, json: Bool = true) {
        self.code = account
        self.scope = scope
        self.table = table
        self.json = json
    }
    
    public func send(with eosws: EOSWS, withRequestID id: String, fetch:Bool = true, listen:Bool) throws {
        self.request = OutgoingMessage(withType: "get_table_rows")
        self.request.requestID = id
        self.request.fetch = fetch
        self.request.listen = listen
        
        let data = try JSONEncoder().encode(self)
        if let s = String(data: data, encoding: String.Encoding.utf8) {
            eosws.send(json: s)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        try request.encode(to: encoder)
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        var data = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        try data.encode(self.code, forKey: .code)
        try data.encode(self.scope, forKey: .scope)
        try data.encode(self.table, forKey: .table)
        try data.encode(self.json, forKey: .json)
    }
}
