//
//  GetTableRows.swift
//  eosws
//
//  Created by Charles Billette on 2018-11-09.
//  Copyright © 2018 dfuse. All rights reserved.
//

import Foundation
import SwiftWebSocket

public class GetActionTraces: Encodable{
    let account: String
    let actionName: String
    let withInlineTraces: Bool
    let withDTRXOps: Bool
    let withRampOps: Bool
    var request: OutgoingMessage!
    
    enum CodingKeys: String, CodingKey {
        case account, actionName, json, data
        case withInlineTraces = "with_inline_traces"
        case withDTRXOps = "with_dtrxops"
        case withRampOps = "withRampOps"
    }
    
    public init(
        account: String,
        actionName: String,
        withInlineTraces: Bool = true,
        withDTRXOps: Bool = true,
        withRAMOps: Bool = true) {
        
        self.account = account
        self.actionName = actionName
        self.withInlineTraces = withInlineTraces
        self.withDTRXOps = withDTRXOps
        self.withRampOps = withRAMOps
    }
    
    public func send(with eosws: EOSWS, withRequestID id: String) throws {
        self.request = OutgoingMessage(withType: "get_action_traces")
        self.request.requestID = id
        self.request.fetch = false
        self.request.listen = true
        
        let data = try JSONEncoder().encode(self)
        if let s = String(data: data, encoding: String.Encoding.utf8) {
            eosws.send(json: s)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        try request.encode(to: encoder)
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        var data = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)

        try data.encode(self.account, forKey: .account)
        try data.encode(self.actionName, forKey: .actionName)
        try data.encode(self.withInlineTraces, forKey: .withInlineTraces)
        try data.encode(self.withDTRXOps, forKey: .withDTRXOps)
        try data.encode(self.withRampOps, forKey: .withRampOps)
    }
}
