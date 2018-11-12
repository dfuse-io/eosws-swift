//
//  Listening.swift
//  eosws
//
//  Created by Charles Billette on 2018-11-12.
//  Copyright © 2018 dfuse. All rights reserved.
//

import Foundation

public struct Listening: Decodable {
    let nextBlock: Int
    
    enum CodingKeys: String, CodingKey {
        case nextBlock = "next_block"
    }
}
