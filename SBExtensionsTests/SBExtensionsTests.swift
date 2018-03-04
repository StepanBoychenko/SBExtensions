//
//  SBExtensionsTests.swift
//  SBExtensionsTests
//
//  Created by Admin on 04.03.18.
//  Copyright © 2018 Stepan Boichenko. All rights reserved.
//

import XCTest
@testable import SBExtensions

class SBExtensionsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSBTableViewCell() {
        let cell = SBTableViewCell.init(style: .default, reuseIdentifier: "")
        
        XCTAssert(SBTableViewCell.identifier == "SBTableViewCell")
        XCTAssert(cell.backgroundColor === UIColor.background())
        XCTAssert(cell.selectionStyle == .none)
    }
    
    func testCellsSeparators() {
        let cell = SBTableViewCell.init(style: .default, reuseIdentifier: "")
        
        let topSeparator = { return cell.getSeparator(isTop: true) }
        let bottomSeparator = { return cell.getSeparator(isTop: false) }
        
        cell.setTopSeparator(isEnabled: true)
        XCTAssert(topSeparator() != nil)
        XCTAssert(bottomSeparator() == nil)
        XCTAssert(topSeparator()?.frame.height == UITableViewCell.Separator.defaultConfig.height)
        XCTAssert(topSeparator()?.backgroundColor === UITableViewCell.Separator.defaultConfig.color)
        
        let config = UITableViewCell.Separator.SeparatorConfiguration(height: 5, color: UIColor.red.cgColor)
        cell.setBottomSeparator(isEnabled: true, withOptions: config)
        cell.setBottomSeparator(isEnabled: true)
        XCTAssert(topSeparator() != nil)
        XCTAssert(bottomSeparator() != nil)
        XCTAssert(bottomSeparator()?.frame.height == config.height)
        XCTAssert(bottomSeparator()?.backgroundColor === config.color)
        
        cell.setBottomSeparator(isEnabled: false)
        cell.setBottomSeparator(isEnabled: false)
        XCTAssert(topSeparator() != nil)
        XCTAssert(bottomSeparator() == nil)
        
        XCTAssert(topSeparator()?.frame.width == cell.bounds.width)
        cell.frame = CGRect(x: 5, y: 5, width: 100, height: 100)
        XCTAssert(topSeparator()?.frame.width == cell.bounds.width)
        cell.frame = CGRect(x: -15, y: -35, width: 20, height: 0)
        XCTAssert(topSeparator()?.frame.width == cell.bounds.width)
        
        cell.setTopSeparator(isEnabled: false)
        XCTAssert(topSeparator() == nil)
        XCTAssert(bottomSeparator() == nil)
    }
    
    func testProvidesIdentifier() {
        let tableView = SBTableView()
        tableView.register(SBTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: SBTableViewCell.identifier)
        XCTAssert(cell != nil)
    }
    
}
