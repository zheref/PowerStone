//
//  Roundable.swift
//  PowerStone
//
//  Created by Sergio Lozano García on 6/30/18.
//

import UIKit

public protocol Roundable {
    
}

extension Roundable {
    
    public func round(view: UIView, to radius: CGFloat) {
        view.layer.masksToBounds = true
        view.layer.cornerRadius = radius
    }
    
}
