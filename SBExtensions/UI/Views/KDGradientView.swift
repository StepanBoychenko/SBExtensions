//
//  SBGradientView.swift
//  utair
//
//  Created by Admin on 04.03.18.
//  Copyright © 2018 Stepan Boichenko. All rights reserved.
//

import UIKit

/// View with gradient layer as root layer. Root layer automatically resizes when view resizes.
open class SBGradientView: UIView {

    override open class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
}
