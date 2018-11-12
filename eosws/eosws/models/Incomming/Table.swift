//
//  Table.swift
//  eosws
//
//  Created by Charles Billette on 2018-11-12.
//  Copyright © 2018 dfuse. All rights reserved.
//

import Foundation

public struct TableSnapshot: Decodable {
    public let rows : [TableSnapshotRow]
}

public struct TableDelta: Decodable {
    public let blockNum: Int
    public let dbop: DBOp
    public var redo: Bool = false
    public var undo: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case blockNum = "block_num"
        case dbop = "dbop"
        case redo, undo
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.blockNum = try container.decode(Int.self, forKey: .blockNum)
        self.dbop = try container.decode(DBOp.self, forKey: .dbop)
        if let redo = try container.decodeIfPresent(Bool.self, forKey: .redo){
            self.redo = redo
        }
        if let undo = try container.decodeIfPresent(Bool.self, forKey: .undo){
            self.undo = undo
        }
    }
    
}

public struct TableSnapshotRow: Decodable {
    public let key: String
    public let payer: String
    public let json: [String: JSONValue]?
    public let hex: String?
}

public struct Row: Decodable {
    public let payer: String
    public let json: [String: JSONValue]?
    public let hex: String?
}

public struct DBOp: Decodable  {
    public let op: String
    public let actionIndex: Int
    public let account: String
    public let table: String
    public let scope: String
    public let key: String
    public let oldRow: Row?
    public let newRow: Row
    
    enum CodingKeys: String, CodingKey {
        case op, account, table, scope, key
        case actionIndex = "action_idx"
        case oldRow = "old"
        case newRow = "new"
    }
}

