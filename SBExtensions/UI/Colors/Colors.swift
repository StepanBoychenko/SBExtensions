//
//  Colors.swift
//  SBExtensions
//
//  Created by Admin on 04.03.18.
//  Copyright © 2018 Stepan Boichenko. All rights reserved.
//

import Foundation

extension UIColor {
        
    open class SBColor {
        public static var main = UIColor.blue
        public static var background = UIColor.white
        public static var error = UIColor.red
        public static var success = UIColor.blue
    }
    
    public static func background() -> UIColor {
        return SBColor.background
    }
    
    public static func error() -> UIColor {
        return SBColor.error
    }
    
    public static func success() -> UIColor {
        return SBColor.success
    }
    
    public static func main() -> UIColor {
        return SBColor.main
    }
}
