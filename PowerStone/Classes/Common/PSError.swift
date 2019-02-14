//
//  PSError.swift
//  PowerStone
//
//  Created by Sergio Daniel on 2/13/19.
//

import Foundation

public enum PowerStoneError : Error {
    case httpError(Int, String)
}

public class PSError {
    
    public var completeCode: String
    public var statusCode: Int?
    
    public var error: Error?
    public var oldError: NSError?
    
    public var messages = PSStack<String>()
    public var userMessage: String?
    
    public init(code: String, message: String) {
        self.completeCode = code
        self.messages.push(element: message)
    }
    
    public convenience init(code: String, message: String, statusCode: Int) {
        self.init(code: code, message: message)
        self.statusCode = statusCode
    }
    
    public convenience init(code: String, message: String, error: Error) {
        self.init(code: code, message: message)
        self.error = error
    }
    
    public convenience init(code: String, message: String, oldError: NSError) {
        self.init(code: code, message: message)
        self.oldError = oldError
    }
    
    public var readableUserMessage: String {
        var stringToReturn = ""
        
        if let userMessage = userMessage {
            stringToReturn = userMessage
        } else if let lastMessage = messages.stackArray.last {
            stringToReturn = lastMessage
        } else if let oldError = oldError {
            stringToReturn = oldError.localizedDescription
        } else if let error = error {
            stringToReturn = error.localizedDescription
        } else {
            stringToReturn = completeCode
        }
        
        return stringToReturn
    }
    
    public var readableDeveloperMessage: String {
        var stringToReturn = "\(completeCode)"
        
        if let lastMessage = messages.stackArray.last {
            stringToReturn = "\(stringToReturn) \(lastMessage)"
        } else if let oldError = oldError {
            stringToReturn = "\(stringToReturn) \(oldError.localizedDescription)"
        } else if let error = error {
            stringToReturn = "\(stringToReturn) \(error.localizedDescription)"
            return stringToReturn
        }
        
        if let error = error {
            stringToReturn = "\(stringToReturn) (\(error.localizedDescription))"
        }
        
        if let error = oldError {
            stringToReturn = "\(stringToReturn) [\(error.localizedDescription)]"
        }
        
        return stringToReturn
    }
    
}
