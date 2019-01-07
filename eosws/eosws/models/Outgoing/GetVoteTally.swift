//
//  GetVoteTally.swift
//  eosws
//
//  Created by Charles Billette on 2019-01-02.
//  Copyright © 2019 dfuse. All rights reserved.
//

import Foundation

public struct GetVoteTally: Encodable {
    var request: OutgoingMessage!
    
    public init() {
    }
    
    public mutating func send(with eosws: EOSWS, withRequestID id: String, fetch:Bool = true, listen:Bool = true) throws {
        self.request = OutgoingMessage(withType: "get_vote_tally")
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
    }
}
