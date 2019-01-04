//
//  TransactionLifecycle.swift
//  eosws
//
//  Created by Charles Billette on 2018-11-12.
//  Copyright © 2018 dfuse. All rights reserved.
//

import Foundation

public struct TransactionLifecycle: Decodable {
    
    let id: String
    let transaction: JSONValue
    let executionTrace: JSONValue
    let executionBlockHeader: JSONValue
    let dtrxops: [JSONValue]
    let ramops: [JSONValue]
    let publicKeys: [String]
    let createdBy: JSONValue?
    let canceledBy: JSONValue
    let executionIrreversible: Bool
    let creationIrreversible: Bool
    let cancelationIrreversible: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case transaction
        case executionTrace = "execution_trace"
        case executionBlockHeader = "execution_block_header"
        case dtrxops = "dtrxops"
        case ramops = "ramops"
        case publicKeys = "pub_keys"
        case createdBy = "created_by"
        case canceledBy = "cancel_by"
        case executionIrreversible = "execution_irreversible"
        case creationIrreversible = "creation_irreversible"
        case cancelationIrreversible = "cancelation_irreversible"
        case lifecycle
    }

    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let nested = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .lifecycle)
        
        self.id = try nested.decode(String.self, forKey: .id)
        self.transaction = try nested.decode(JSONValue.self, forKey: .transaction)
        self.executionTrace = try nested.decode(JSONValue.self, forKey: .executionTrace)
        self.executionBlockHeader = try nested.decode(JSONValue.self, forKey: .executionBlockHeader)
        self.dtrxops = try nested.decode(Array<JSONValue>.self, forKey: .dtrxops)
        self.ramops = try nested.decode(Array<JSONValue>.self, forKey: .ramops)
        self.publicKeys = try nested.decode(Array<String>.self, forKey: .publicKeys)
        self.createdBy = try nested.decode(JSONValue.self, forKey: .createdBy)
        self.canceledBy = try nested.decode(JSONValue.self, forKey: .canceledBy)
        
        self.executionIrreversible = try nested.decode(Bool.self, forKey: .executionIrreversible)
        self.creationIrreversible = try nested.decode(Bool.self, forKey: .creationIrreversible)
        self.cancelationIrreversible = try nested.decode(Bool.self, forKey: .cancelationIrreversible)
        
    }
}
