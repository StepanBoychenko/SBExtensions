//
//  SBNotifiConfig.swift
//  SBExtensions
//
//  Created by Admin on 04.03.18.
//  Copyright © 2018 Stepan Boichenko. All rights reserved.
//

import Foundation
import UIKit

open class SBNotifyConfig: Equatable {
    
    var animationDuration: TimeInterval = 0.2
    var isAutoHideEnabled: Bool = true
    var autoHideDelay: TimeInterval = 2.0
    var hideOnTap: Bool = true
    var color: UIColor = .red
    var tintColor: UIColor = .white
    var alpha: CGFloat = 0.6
    
    var height: CGFloat = 64
    var imagePadding: CGFloat = 16
    var imageBoundSize: CGFloat = 32
    var messageRightPadding: CGFloat = 24
    
    var defaultImageName = ""
    
    var font: UIFont? = nil
}

public func == (lhs: SBNotifyConfig, rhs: SBNotifyConfig) -> Bool {
    guard lhs.animationDuration == rhs.animationDuration else { return false }
    guard lhs.isAutoHideEnabled == rhs.isAutoHideEnabled else { return false }
    guard lhs.hideOnTap == rhs.hideOnTap else { return false }
    guard lhs.color == rhs.color else { return false }
    guard lhs.tintColor == rhs.tintColor else { return false }
    return true
}
