//
//  Notifiable.swift
//  SBExtensions
//
//  Created by Admin on 04.03.18.
//  Copyright © 2018 Stepan Boichenko. All rights reserved.
//

import Foundation
import UIKit

public protocol ProvidesViewController: class {
    var viewController: UIViewController { get }
}

public protocol ProvidesNavigationController: class {
    var navController: UINavigationController? { get }
}

extension ProvidesViewController where Self: UIViewController {
    public var viewController: UIViewController { return self }
}

extension ProvidesNavigationController where Self: UIViewController {
    public var navController: UINavigationController? { return self.navigationController }
}

public protocol Notifiable: ProvidesViewController, ProvidesNavigationController {
    
}

extension Notifiable {
    
    public func showNotify(_ notify: SBNotify) {
        showNotify(notify, inController: self.navController?.viewControllers.last ?? self.viewController)
    }
    
    public func showNotify(_ notify: SBNotify, inController ctrl: UIViewController) {
        showNotify(notify, inControllerWithName: ctrl.className)
    }
    
    public func showNotify(_ notify: SBNotify, inControllerWithName: String) {
        guard let notifyView = notify.create() else {
            return
        }
        // поверяем, что такого же нотифая (совпадает текст, иконка и стиль) нет в очереди, иначе продлеваем таймер
        for notifyInQueue in getNotifiesQueueForCurrentController() {
            if notifyInQueue.notify.notifyData == notify {
                resetTimer()
                return
            }
        }
        
        // добавляем в очередь
        SBNotifiesQueue.sharedInstance.notifiesQueue.append((notifyView, inControllerWithName))
        
        if !SBNotifiesQueue.sharedInstance.isAnyNotifyInProgress {
            _ = checkQueue()
        }
    }
    
    public func getNotifiesQueueForCurrentController() -> [NotifyWithOwner] {
        if SBNotifiesQueue.sharedInstance.notifiesQueue.count == 0 {
            return []
        }
        return SBNotifiesQueue.sharedInstance.notifiesQueue.filter({ (_notifyWithOwner: (_: SBNotifyView, owner: String)) -> Bool in
            _notifyWithOwner.owner == viewController.className
        })
    }
    
    public func checkQueue() -> Bool {
        if !SBNotifiesQueue.sharedInstance.isAnyNotifyInProgress {
            self.navController?.view.window?.windowLevel = UIWindowLevelNormal
        }
        
        guard let notifyView = getNotifiesQueueForCurrentController().first?.notify else {
            return false
            
        }
        
        // если navigationController еще не создан, откладываем показ, checkQueue() будет вызван из didAppear-метода
        if let navVC = self.navController {
            if !SBNotifiesQueue.sharedInstance.isAnyNotifyInProgress {
                notifyView.delegate = self
                navVC.view.addSubview(notifyView)
                notifyView.leftAnchor.constraint(equalTo: viewController.view.leftAnchor)
                notifyView.topAnchor.constraint(equalTo: viewController.view.topAnchor)
                notifyView.animateShow()
            }
        }
        return true
    }
    
    // запускает/перезапускает таймер закрытия текущего нотифая, если включен автохайд
    public func resetTimer() {
        if let data = SBNotifiesQueue.sharedInstance.notifiesQueue.first?.notify.notifyData {
            if data.config.isAutoHideEnabled {
                let showDuration = data.config.autoHideDelay
                DispatchQueue.main.asyncAfter(deadline: .now() + showDuration, execute: { [weak self] in
                    self?.hideNotify()
                })
            }
        }
    }
    
    // начало анимации показа нотифая
    public func firstNotifyWillShow() {
        SBNotifiesQueue.sharedInstance.isAnyNotifyInProgress = true
        self.navController?.view.window?.windowLevel = UIWindowLevelStatusBar + 10 // показ поверх статусбара
        resetTimer()
    }
    
    //  конец анимации показа нотифая
    public func firstNotifyDidShow() {
    }
    
    public func hideNotify(removeBeforeHide: Bool = true) {
        SBNotifiesQueue.sharedInstance.notifiesQueue.first?.notify.animateHide(removeBeforeHide: removeBeforeHide)
    }
    
    public func hideNotifySp() { // специальный вызов для селектора
        hideNotify(removeBeforeHide: true)
    }
    
    // нажатие на нотифай (кликабельный)
    public func firstNotifyDidTap() {
        hideNotify(removeBeforeHide: true)
    }
    
    // начало анимации закрытия нотифая
    public func firstNotifyWillHide() {
        removeFirstForCurrentController()
    }
    
    // конец анимации закрытия нотифая
    public func firstNotifyDidHide() {
        SBNotifiesQueue.sharedInstance.isAnyNotifyInProgress = false
        let isLastNotify = !checkQueue()
        if isLastNotify {
            navController?.view.window?.windowLevel = UIWindowLevelNormal
        }
    }
    
    // удаляет из очереди первый нотифай для текущего контроллера
    public func removeFirstForCurrentController() {
        for (index, notifyData) in SBNotifiesQueue.sharedInstance.notifiesQueue.enumerated() {
            if notifyData.owner == viewController.className {
                SBNotifiesQueue.sharedInstance.notifiesQueue.remove(at: index)
                return
            }
        }
    }
    
    // отменить все нотифаи для текущего контроллера и закрыть текущий
    public func cancelAllNotifies() {
        if SBNotifiesQueue.sharedInstance.isAnyNotifyInProgress {
            hideNotify(removeBeforeHide: false)
            SBNotifiesQueue.sharedInstance.isAnyNotifyInProgress = false
        }
        removeAllNotifiesForCurrentController()
    }
    
    public func removeAllNotifiesForCurrentController() {
        var realIndex = 0
        for (index, notifyData) in SBNotifiesQueue.sharedInstance.notifiesQueue.enumerated() {
            if notifyData.owner == viewController.className {
                if index < SBNotifiesQueue.sharedInstance.notifiesQueue.count {
                    SBNotifiesQueue.sharedInstance.notifiesQueue.remove(at: realIndex)
                }
                else {
                    realIndex += 1
                }
                removeAllNotifiesForCurrentController()
                return
            }
        }
    }
}
