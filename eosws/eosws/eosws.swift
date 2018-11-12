//
//  eosws.swift
//  eosws
//
//  Created by Charles Billette on 2018-11-09.
//  Copyright © 2018 dfuse. All rights reserved.
//
import SwiftWebSocket

enum EOSWSError: Error {
    case invalidURL(url: String)
}

public class EOSWS{
    
    let endpoint: String
    let token: String
    let origin: String
    let ws: WebSocket
    
    public init(forEnpoint endpoint: String, token: String, origin: String) throws {
        self.endpoint = endpoint
        self.token = token
        self.origin = origin
        
        print("In init of EOSWS")
        
        let urlString = "\(endpoint)?token=\(token)"
        
        guard let url = URL(string: urlString) else {
            throw EOSWSError.invalidURL(url: urlString)
        }
        
        let ws = WebSocket(url: url)
        self.ws = ws

        ws.event.open = {
            print("opened")
        }
        ws.event.close = { code, reason, clean in
            print("close")
        }
        ws.event.error = { error in
            print("error \(error)")
        }
        ws.event.message = { message in
            if let text = message as? String {
                print("Received text: \(text)" )

                if let data = text.data(using: String.Encoding.utf8) {
                    do {
                        let response = try JSONDecoder().decode(IncomingMessage.self, from: data)
                        print("response: \(response)")
                    } catch {
                        //todo send error to delegate?
                        print("JSON decode error: \(error)")
                    }
                    
                    return
                }
                //todo: error
            }
        }
    }
    
    public func send(json: String) {
        print("Sending json: \(json)")
        ws.send(json)
    }
}

protocol EOSWSDelegate {
    
}
