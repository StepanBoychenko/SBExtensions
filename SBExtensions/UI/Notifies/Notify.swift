//
//  KDNotify.swift
//  utair
//
//  Created by KODE_H6 on 15.12.16.
//  Copyright © 2016 KODE. All rights reserved.
//

import Foundation
import UIKit

public typealias NotifyWithOwner = (notify: SBNotifyView, owner: String) // нотифай, назначенный контроллеру

public class SBNotifiesQueue {
    var notifiesQueue: [NotifyWithOwner] = [] // очередь нотифаев
    var isAnyNotifyInProgress: Bool = false // нотифай в процессе показа
    
    static let sharedInstance = SBNotifiesQueue()
    
    private init() { }
}

public enum SBNotificationPosition {
    case top
    case bottom
}

public enum SBNotifyStyle: Equatable {
    case success
    case error
    case information

    var color: UIColor {
        get {
            switch self {
            case .success:
                return UIColor.success()
            case .error:
                return UIColor.error()
            default:
                return UIColor.main()
            }
        }
    }
}

open class SBNotify: Equatable {
    var message: String?
    var imageName: String?
    var tapAction: (() -> Void)?
    
    public init() { }
    
    var config: SBNotifyConfig = SBNotifyConfig()

    var delegate: Notifiable?
    
    public func config(_ config: SBNotifyConfig) -> Self {
        self.config = config
        return self
    }

    public func message(_ message: String) -> Self {
        self.message = message
        return self
    }

    public func tapAction(_ action: @escaping (() -> Void)) -> Self {
        self.tapAction = action
        return self
    }

    public func imageName(_ imageName: String?) -> Self {
        self.imageName = imageName
        return self
    }
    
    public func create() -> SBNotifyView? {
        if message == nil {
            return nil
        }
        let view = SBNotifyView(notifyData: self)
        return view
    }
}

public func == (lhs: SBNotify, rhs: SBNotify) -> Bool {
    if lhs.message != rhs.message {
        return false
    } else {
        if lhs.imageName != rhs.imageName {
            return false
        } else {
            return lhs.config == rhs.config
        }
    }
}
