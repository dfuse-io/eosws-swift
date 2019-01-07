//
//  GetAccount.swift
//  eosws
//
//  Created by Charles Billette on 2019-01-02.
//  Copyright © 2019 dfuse. All rights reserved.
//

import Foundation

public class GetAccount: Encodable {
    let accountName: String
    var request: OutgoingMessage!
    
    enum CodingKeys: String, CodingKey {
        case accountName = "name"
        case data
    }
    
    public init(withAccountName account: String, json: Bool = true) {
        self.accountName = account
    }
    
    public func send(with eosws: EOSWS, withRequestID id: String) throws {
        self.request = OutgoingMessage(withType: "get_account")
        self.request.requestID = id
        self.request.fetch = true
        self.request.listen = false
        
        let data = try JSONEncoder().encode(self)
        if let s = String(data: data, encoding: String.Encoding.utf8) {
            eosws.send(json: s)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        try request.encode(to: encoder)
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        var data = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        try data.encode(self.accountName, forKey: .accountName)
    }
}
