//
//  Table.swift
//  eosws
//
//  Created by Charles Billette on 2018-11-12.
//  Copyright © 2018 dfuse. All rights reserved.
//

import Foundation

public struct TableSnapshot: Decodable {
    let rows : [Row]
}

//todo: missing

public struct Row: Decodable {
    let key: String
    let payer: String
    let json: [String: JSONValue]
}
