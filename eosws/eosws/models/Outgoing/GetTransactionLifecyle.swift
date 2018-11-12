public class GetTransactionLifecycle: Encodable{
    let transactionID: String
    var request: OutgoingMessage!
    
    enum CodingKeys: String, CodingKey {
        case transactionID = "id"
        case data
    }
    
    public init(withTransactionID transactionID: String) {
        self.transactionID = transactionID
    }
    
    public func send(with eosws: EOSWS, withRequestID id: String, fetch:Bool = true, listen:Bool = true) throws {
        self.request = OutgoingMessage(withType: "get_transaction")
        self.request.requestID = id
        self.request.fetch = fetch
        self.request.listen = listen
        
        let data = try JSONEncoder().encode(self)
        if let s = String(data: data, encoding: String.Encoding.utf8) {
            eosws.send(json: s)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        try request.encode(to: encoder)
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        var data = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        try data.encode(self.transactionID, forKey: .transactionID)
    }
}

