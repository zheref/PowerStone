//
//  PSError.swift
//  PowerStone
//
//  Created by Sergio Daniel on 2/13/19.
//

import Foundation

public enum PSKnownError : Error {
    case connectivityError
    
    case httpError(Int, String)
    
    case badRequest(Int)
    case unauthorized
    
    case serverError(Int)
}

public class PSError {
    
    public var completeCode: String
    public var statusCode: Int?
    
    public var error: Error? {
        didSet {
            handleErrorUpdate()
        }
    }
    
    public var oldError: NSError?
    
    public var automaticRetry = false
    public var recoverable = false
    
    // MARK: STACKTRACE
    
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
        
        handleErrorUpdate()
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
    
    public var combinedMessages: String? {
        if messages.isNotEmpty {
            var combined = "PowerStone Error Stack: "
            
            messages.iterate { (message, index) in
                combined = "\(combined)\n\(index). \(message)"
            }
            
            return combined
        } else {
            return nil
        }
    }
    
    public var availableOrGeneratedNextStep: NSError {
        if let oldError = oldError {
            return oldError
        } else {
            let domain = error?.localizedDescription ?? completeCode
            let nsError = NSError(domain: domain, code: statusCode ?? -1, userInfo: [
                "stackMessages": combinedMessages ?? "No messages found"
            ])
            return nsError
        }
    }
    
    private func handleErrorUpdate() {
        if let knownError = error as? PSKnownError {
            switch (knownError) {
            case .unauthorized:
                recoverable = true
                automaticRetry = true
            default:
                break
            }
        }
    }
    
    public var readableDeveloperMessage: String {
        var stringToReturn = "\(completeCode)"
        
        if let combinedMessages = combinedMessages {
            stringToReturn = "\(stringToReturn) - \(combinedMessages)"
        } else if let oldError = oldError {
            stringToReturn = "\(stringToReturn) - \(oldError.localizedDescription)"
        } else if let error = error {
            stringToReturn = "\(stringToReturn) - \(error.localizedDescription)"
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
    
    public func add(message: String) {
        messages.push(element: message)
    }
    
}
