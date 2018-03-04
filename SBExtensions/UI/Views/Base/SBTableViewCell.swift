//
//  SBTableViewCell.swift
//  SBExtensions
//
//  Created by Admin on 04.03.18.
//  Copyright © 2018 Stepan Boichenko. All rights reserved.
//

import Foundation
import UIKit

open class SBTableViewCell: UITableViewCell, ProvidesIdentifier {
    
    override open var frame: CGRect {
        didSet {
            resizeSeparators()
        }
    }
    
    override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupDefaults()
        createViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupDefaults()
        createViews()
    }
    
    private func setupDefaults() {
        backgroundColor = UIColor.background()
        selectionStyle = .none
    }
    
    public static var identifier: String {
        return String(describing: self)
    }
    
    open func createViews() {
        
    }
}
