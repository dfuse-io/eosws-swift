//
//  json.swift
//  eosws
//
//  Created by Charles Billette on 2018-11-12.
//  Copyright © 2018 dfuse. All rights reserved.
//

import Foundation

public enum JSONValue: Decodable {
    case string(String)
    case int(Int)
    case double(Double)
    case bool(Bool)
    case object([String: JSONValue])
    case array([JSONValue])
    case null
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(String.self) {
            self = .string(value)
        } else if let value = try? container.decode(Int.self) {
            self = .int(value)
        } else if let value = try? container.decode(Double.self) {
            self = .double(value)
        } else if let value = try? container.decode(Bool.self) {
            self = .bool(value)
        } else if let value = try? container.decode([String: JSONValue].self) {
            self = .object(value)
        } else if let value = try? container.decode([JSONValue].self) {
            self = .array(value)
        } else if container.decodeNil() {
            self = .null
        } else {
            throw DecodingError.typeMismatch(JSONValue.self, DecodingError.Context(codingPath: container.codingPath, debugDescription: "Not a JSON"))
        }
    }
    
    public func value<ValueType>() throws -> ValueType {
        print("value:ValueType =s \(ValueType.self)")
        switch self {
        case .string(let value): return (value as! ValueType)
        case .double(let v) where ValueType.self == Swift.Double.self: return (v as! ValueType)
        case .int(let value): return (value as! ValueType)
        case .bool(let value): return (value as! ValueType)
        case .array(let value): return (value as! ValueType)
        case .object(let value): return (value as! ValueType)
        case .null: throw JSONValueError.noValue
        default: throw JSONValueError.typeMismatch
        }
    }
    
    public enum JSONValueError: Error {
        case typeMismatch
        case noValue
    }
}
