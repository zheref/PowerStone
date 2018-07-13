//
//  Form.swift
//  PowerStone
//
//  Created by Sergio Lozano García on 6/29/18.
//

import Foundation

public protocol PWSForm : class {
    
    associatedtype TKey : Hashable
    
    var currentState: [TKey: Any?] { get }
    
    var isValid: Bool { get }
    
    func userDidChangeState(forKey key: TKey)
    
}

extension PWSForm {
    
    public func getString(_ key: TKey) -> String? {
        return currentState[key] as? String
    }
    
    public func getInt(_ key: TKey) -> Int? {
        return currentState[key] as? Int
    }
    
}
