//
//  UITableViewCell+Dividers.swift
//  SBExtensions
//
//  Created by Admin on 04.03.18.
//  Copyright © 2018 Stepan Boichenko. All rights reserved.
//

import Foundation
import UIKit

/// Cell top/bottom separator
extension UITableViewCell {
    
    /// add/remove top separator
    public func setTopSeparator(isEnabled: Bool,
                              withConfig config: Separator.SeparatorConfiguration? = nil) {
        setSeparator(isEnabled: isEnabled, isTop: true, withConfig: config)
    }
    
    /// add/remove bottom separator
    public func setBottomSeparator(isEnabled: Bool,
                                 withOptions config: Separator.SeparatorConfiguration? = nil) {
        setSeparator(isEnabled: isEnabled, isTop: false, withConfig: config)
    }
    
    fileprivate func setSeparator(isEnabled: Bool, isTop: Bool,
                                withConfig config: Separator.SeparatorConfiguration?) {
        if !isEnabled {
            if let separator = getSeparator(isTop: isTop) {
                separator.removeFromSuperlayer()
            }
        }
        else {
            if getSeparator(isTop: isTop) != nil {
                return
            }
            let separator = Separator.createSeparator(withWidth: self.bounds.width, isTop: isTop, withConfig: config)
            self.contentView.layer.addSublayer(separator)
        }
    }
    
    public func resizeSeparators() {
        let currentCellWidth = self.bounds.width
        for layer in self.contentView.layer.sublayers ?? [] {
            if layer.value(forKey: Separator.Keys.tagName) != nil, layer.frame.width != currentCellWidth {
                return layer.frame.size = CGSize(width: currentCellWidth, height: layer.frame.size.height)
            }
        }
    }
    
    func getSeparator(isTop: Bool) -> CALayer? {
        let tag = isTop ? Separator.Keys.valueTop : Separator.Keys.valueBottom
        for layer in self.contentView.layer.sublayers ?? [] {
            if let value = layer.value(forKey: Separator.Keys.tagName) as? String, value == tag {
                return layer
            }
        }
        return nil
    }
    
    public struct Separator {
        
        public class SeparatorConfiguration {
            var height: CGFloat = 1
            var color: CGColor = UIColor.black.cgColor
            
            init() { }
            
            init(height: CGFloat, color: CGColor) {
                self.height = height
                self.color = color
            }
        }
        
        public enum Keys {
            static let tagName = "layerTag"
            static let valueTop = "_topSeparator"
            static let valueBottom = "_bottomSeparator"
        }
        
        public static let defaultConfig = SeparatorConfiguration()
        
        public static func createSeparator(withWidth width: CGFloat,
                                         isTop: Bool,
                                         withConfig config: Separator.SeparatorConfiguration?) -> CALayer {
            let _config = config ?? Separator.defaultConfig
            let separator = CALayer()
            let tag = isTop ? Separator.Keys.valueTop : Separator.Keys.valueBottom
            separator.setValue(tag, forKey: Separator.Keys.tagName)
            separator.frame = CGRect(x: 0,
                                   y: 0,
                                   width: width,
                                   height: _config.height)
            separator.backgroundColor = _config.color
            return separator
        }
    }
}

