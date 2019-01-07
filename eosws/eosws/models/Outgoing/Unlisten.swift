//
//  Unlisten.swift
//  eosws
//
//  Created by Charles Billette on 2018-11-12.
//  Copyright © 2018 dfuse. All rights reserved.
//

import Foundation

public struct Unlisten: Encodable {
    public let reqID: String
    var request: OutgoingMessage!
    
    enum CodingKeys: String, CodingKey {
        case reqID = "req_id"
        case data
    }

    public init(withRedID reqID: String) {
        self.reqID = reqID
    }

    public mutating func send(with eosws: EOSWS, withRequestID id: String) throws {
        self.request = OutgoingMessage(withType: "unlisten")
        self.request.requestID = id
        
        let data = try JSONEncoder().encode(self)
        if let s = String(data: data, encoding: String.Encoding.utf8) {
            eosws.send(json: s)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        try request.encode(to: encoder)
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        var data = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        try data.encode(self.reqID, forKey: .reqID)
    }

}
