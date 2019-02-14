//
//  Stack.swift
//  PowerStone
//
//  Created by Sergio Daniel on 1/8/19.
//

import Foundation

public class PSStack<T> {
    
    public var stackArray = [T]()
    
    public var count: Int {
        return stackArray.count
    }
    
    public var isNotEmpty: Bool {
        return !stackArray.isEmpty
    }
    
    public func push(element: T) {
        stackArray.append(element)
    }
    
    public func pop() -> T? {
        return stackArray.isEmpty ? nil : stackArray.removeLast()
    }
    
    public func iterate(_ iterator: (T, Int) -> Void) {
        var index = stackArray.count - 1
        
        repeat {
            let element = stackArray[index]
            iterator(element, index)
            index = index - 1
        } while index >= 0
    }
    
}
