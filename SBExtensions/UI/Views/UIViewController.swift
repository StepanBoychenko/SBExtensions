//
//  UIViewController.swift
//  SBExtensions
//
//  Created by Admin on 04.03.18.
//  Copyright © 2018 Stepan Boichenko. All rights reserved.
//

import Foundation

extension UIViewController {
    
    static var className: String {
        return String(describing: self)
    }
    
    var className: String {
        return String(describing: type(of: self))
    }
}
