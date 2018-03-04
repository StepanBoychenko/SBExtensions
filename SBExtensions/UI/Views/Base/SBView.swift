//
//  SBView.swift
//  SBExtensions
//
//  Created by Admin on 04.03.18.
//  Copyright © 2018 Stepan Boichenko. All rights reserved.
//

import UIKit

open class SBView: UIView {
    
    public init() {
        super.init(frame: .zero)
        setupDefaults()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupDefaults()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupDefaults()
    }
    
    private func setupDefaults() {
        backgroundColor = UIColor.background()
    }
}
