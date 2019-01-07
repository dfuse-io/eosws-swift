//
//  Unlisten.swift
//  eosws
//
//  Created by Charles Billette on 2018-11-12.
//  Copyright © 2018 dfuse. All rights reserved.
//

import Foundation

public struct GetPrice: Encodable {
    var request: OutgoingMessage!
    
    
    public init() {
    }
    
    public mutating func send(with eosws: EOSWS, withRequestID id: String) throws {
        self.request = OutgoingMessage(withType: "get_price")
        self.request.requestID = id
        self.request.listen = true
        
        let data = try JSONEncoder().encode(self)
        if let s = String(data: data, encoding: String.Encoding.utf8) {
            eosws.send(json: s)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        try request.encode(to: encoder)
    }
    
}

