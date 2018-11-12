//
//  Table.swift
//  eosws
//
//  Created by Charles Billette on 2018-11-12.
//  Copyright © 2018 dfuse. All rights reserved.
//

import Foundation

public struct TableSnapshot: Decodable {
    let rows : [TableSnapshotRow]
}

public struct TableDelta: Decodable {
    let blockNum: Int
    let dbop: DBOp
    var redo: Bool = false
    var undo: Bool = false
    
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
    let key: String
    let payer: String
    let json: [String: JSONValue]?
    let hex: String?
}

public struct Row: Decodable {
    let payer: String
    let json: [String: JSONValue]?
    let hex: String?
}

public struct DBOp: Decodable  {
    let op: String
    let actionIndex: Int
    let account: String
    let table: String
    let scope: String
    let key: String
    let oldRow: Row?
    let newRow: Row
    
    enum CodingKeys: String, CodingKey {
        case op, account, table, scope, key
        case actionIndex = "action_idx"
        case oldRow = "old"
        case newRow = "new"
    }
}

