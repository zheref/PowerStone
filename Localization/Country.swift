//
//  Country.swift
//  PowerStone
//
//  Created by Sergio Daniel L. García on 7/12/18.
//

import Foundation

public struct PWSCountry {
    
    public var name: String
    
    public var mainCities: [PWSCity]?
    
    public init(withName name: String, andMainCities mainCities: [PWSCity]? = nil) {
        self.name = name
        self.mainCities = mainCities
    }
    
}
