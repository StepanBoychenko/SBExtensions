//
//  SBNotifyView.swift
//  SBExtensions
//
//  Created by Admin on 04.03.18.
//  Copyright © 2018 Stepan Boichenko. All rights reserved.
//

import Foundation
import UIKit

public protocol SBNotifyDelegate: class {
    associatedtype View: UIView
    
    func animateShow()
    func animateHide(removeBeforeHide: Bool)
}

open class SBNotifyView: SBView, SBNotifyDelegate {
    public typealias View = SBView
    
    weak var labelMessage: UILabel?
    weak var button: UIButton?
    weak var imageView: UIImageView?
    
    var notifyData: SBNotify!
    weak var delegate: Notifiable?
    
    var config: SBNotifyConfig { return self.notifyData.config }
    
    fileprivate var notifyViewHeight: CGFloat = 64
    
    init(notifyData: SBNotify) {
        super.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.notifyData = notifyData
        self.frame = self.shrinkedFrame()
        
        self.backgroundColor = config.color
        
        layoutMessage()
        layoutIcon()
        layoutButton()
        
        self.frame = button!.frame
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutMessage() {
        
        let x = config.imagePadding*2 + config.imageBoundSize
        let width = frame.width-(config.imagePadding*2 + config.imageBoundSize + config.messageRightPadding)
        
        let _labelMessage = UILabel(frame: CGRect(x: x,
                                                  y: 0,
                                                  width: width,
                                                  height: config.height))
        
        _labelMessage.lineBreakMode = .byWordWrapping
        _labelMessage.numberOfLines = 0
        _labelMessage.textAlignment = .left
        _labelMessage.textColor = notifyData.config.tintColor
        _labelMessage.text = notifyData.message
        
        if let font = notifyData.config.font {
            _labelMessage.font = font
        }
        
        self.addSubview(_labelMessage)
        self.labelMessage = _labelMessage
    }
    
    func layoutIcon() {
        
        let _imageView = UIImageView(frame: CGRect(x: notifyData.config.imagePadding,
                                                   y: (notifyData.config.height - notifyData.config.imageBoundSize) / 2,
                                                   width: notifyData.config.imageBoundSize,
                                                   height: notifyData.config.imageBoundSize))
        
        _imageView.image = UIImage(named: notifyData.imageName ?? config.defaultImageName)
        _imageView.tintColor = config.tintColor
        _imageView.contentMode = .scaleAspectFit
        
        if let _labelMessage = labelMessage {
            let estimatedMessageHeight = (notifyData.message?.sizeWithCustomFont(config.font ?? _labelMessage.font,
                                                                                 constrainedToWidth: _labelMessage.frame.width).height ?? 0) + 24
            if estimatedMessageHeight > notifyData.config.height {
                notifyViewHeight = estimatedMessageHeight
                labelMessage?.frame = CGRect(origin: _labelMessage.frame.origin,
                                             size: CGSize(width: _labelMessage.frame.width, height: estimatedMessageHeight))
            }
        }
        
        _imageView.frame.origin = CGPoint(x: config.imagePadding, y: config.imagePadding)
        
        self.addSubview(_imageView)
        self.imageView = _imageView
    }
    
    func layoutButton() {
        let _button = UIButton(frame: expandedFrame())
        _button.addTarget(self, action: #selector(notifyTap), for: .touchUpInside)
        _button.accessibilityLabel = notifyData.message
        _button.accessibilityTraits = UIAccessibilityTraitNone
        
        self.addSubview(_button)
        self.button = _button
    }
    
    @objc func notifyTap() {
        if config.hideOnTap {
            delegate?.firstNotifyDidTap()
        }
    }
    
    public func animateShow() {
        delegate?.firstNotifyWillShow()
        UIView.animate(withDuration: config.animationDuration,
                       animations: { [weak self] in
                        self?.frame = self?.expandedFrame() ?? CGRect.zero
                        
            },
                       completion: { [weak self] finished in
                        if finished {
                            self?.delegate?.firstNotifyDidShow()
                        }
        })
    }
    
    public func animateHide(removeBeforeHide: Bool) {
        if removeBeforeHide { // удалить из стека нотифаев
            delegate?.firstNotifyWillHide()
        }
        UIView.animate(withDuration: config.animationDuration,
                       animations: { [weak self] in
                        self?.frame = self?.shrinkedFrame() ?? CGRect.zero
                        
            },
                       completion: { [weak self] finished in
                        if finished {
                            self?.delegate?.firstNotifyDidHide()
                            self?.removeFromSuperview()
                        }
        })
    }
    
    fileprivate func expandedFrame() -> CGRect {
        return CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: notifyViewHeight)
    }
    
    fileprivate func shrinkedFrame() -> CGRect {
        return CGRect(x: 0, y: -notifyViewHeight, width: UIScreen.main.bounds.width, height: notifyViewHeight)
    }
}
