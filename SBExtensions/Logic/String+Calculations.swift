//
//  String+Calculations.swift
//  UtairUIKit
//
//  Created by KODE-i7-2 on 17/12/2017.
//  Copyright © 2017 KODE-i7-2. All rights reserved.
//

import UIKit
import Foundation

extension String {
    
    /// Размер текста со значениями с плавающей запятой
    /// - Parameters:
    ///   - font: шрифт
    ///   - width: ширина, в которую вписан текст
    ///   - additionalWidth: дополнительная ширина (отступы)
    public func sizeWithCustomFontPrecise(_ font: UIFont, constrainedToWidth width: CGFloat, additionalWidth: CGFloat = 0) -> CGSize {
        return font.sizeOfString(self, constrainedToWidth: width, additionalWidth: additionalWidth)
    }
    
    /// Размер текста с округленными значениями
    /// - Parameters:
    ///   - font: шрифт
    ///   - width: ширина, в которую вписан текст
    ///   - additionalWidth: дополнительная ширина (отступы)
    public func sizeWithCustomFont(_ font: UIFont, constrainedToWidth width: CGFloat, additionalWidth: CGFloat = 0) -> CGSize {
        let precise = sizeWithCustomFontPrecise(font, constrainedToWidth: width, additionalWidth: additionalWidth)
        let ceiled = CGSize(width: ceil(precise.width), height: ceil(precise.height))
        return ceiled
    }
}

extension NSAttributedString {
    
    /// Размер текста со значениями с плавающей запятой
    /// - Parameters:
    ///   - font: шрифт
    ///   - width: ширина, в которую вписан текст
    ///   - additionalWidth: дополнительная ширина (отступы)
    public func sizeWithCustomFontPrecise(_ font: UIFont, constrainedToWidth width: CGFloat, additionalWidth: CGFloat = 0) -> CGSize {
        return font.sizeOfString(self.string, constrainedToWidth: width, additionalWidth: additionalWidth)
    }
    
    /// Размер текста с округленными значениями
    /// - Parameters:
    ///   - font: шрифт
    ///   - width: ширина, в которую вписан текст
    ///   - additionalWidth: дополнительная ширина (отступы)
    public func sizeWithCustomFont(_ font: UIFont, constrainedToWidth width: CGFloat, additionalWidth: CGFloat = 0) -> CGSize {
        let precise = sizeWithCustomFontPrecise(font, constrainedToWidth: width, additionalWidth: additionalWidth)
        let ceiled = CGSize(width: ceil(precise.width), height: ceil(precise.height))
        return ceiled
    }
}

extension UIFont {
    
    public func sizeOfString(_ string: String, constrainedToWidth width: CGFloat, additionalWidth: CGFloat = 0) -> CGSize {
        
        let bounds = CGSize(width: width, height: .greatestFiniteMagnitude)
        let nsString = NSString(string: string)
        let rect = nsString.boundingRect(with: bounds,
                                         options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                         attributes: [NSAttributedStringKey.font: self],
                                         context: nil)
        var size = rect.size
        
        if additionalWidth != 0 { size.width += additionalWidth }
        return size
    }
}
