//
//  String+Helpers.swift
//  PowerStone
//
//  Created by Sergio Lozano García on 6/30/18.
//

import Foundation

extension String {
    
    public var removingWhitespaces: String {
        return components(separatedBy: .whitespaces).joined()
    }
    
}
