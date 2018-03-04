//
//  UITableView.swift
//  SBExtensions
//
//  Created by Admin on 04.03.18.
//  Copyright © 2018 Stepan Boichenko. All rights reserved.
//

import Foundation
import UIKit

public protocol ProvidesIdentifier: class {
    static var identifier: String { get }
}

extension UITableView {
    
    public func register<T: UITableViewCell>(_: T.Type) where T: ProvidesIdentifier {
        self.register(T.self, forCellReuseIdentifier: T.identifier)
    }
}

extension UICollectionView {
    
    public func register<T: UICollectionViewCell>(_: T.Type) where T: ProvidesIdentifier {
        self.register(T.self, forCellWithReuseIdentifier: T.identifier)
    }
    
}
