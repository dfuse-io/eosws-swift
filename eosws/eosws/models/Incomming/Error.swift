//
//  Error.swift
//  eosws
//
//  Created by Charles Billette on 2018-11-12.
//  Copyright © 2018 dfuse. All rights reserved.
//

import Foundation

public struct ErrorMessage: Decodable {
    public let code: String
    public let message: String
    public let details: JSONValue
}
