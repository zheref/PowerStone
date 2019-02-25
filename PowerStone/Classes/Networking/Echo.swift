//
//  Echo.swift
//  PowerStone
//
//  Created by Sergio Daniel on 2/24/19.
//

import Foundation

public enum PSResponseForm {
    case codable
    case serialized
}

public class PSEcho {
    public var request: URLRequest
    
    public var response: URLResponse?
    
    public var codableBody: String?
    public var jsonBody: [PSJson]?
    
    public var error: PSError?
    
    public init(request: URLRequest, response: URLResponse?, body: String) {
        self.request = request
        self.response = response
        self.codableBody = body
    }
    
    public init(request: URLRequest, response: URLResponse?, body: [PSJson]) {
        self.request = request
        self.response = response
        self.jsonBody = body
    }
    
    public init(request: URLRequest, error: PSError, response: URLResponse? = nil, codableBody: String? = nil, jsonBody: [PSJson]? = nil) {
        self.request = request
        self.response = response
        self.error = error
        self.codableBody = codableBody
        self.jsonBody = jsonBody
    }
}
