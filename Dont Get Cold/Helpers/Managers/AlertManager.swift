//
//  AlertManager.swift
//  Emshi
//
//  Created by Hovig Kousherian on 2/21/17.
//  Copyright © 2017 Hovig Kousherian. All rights reserved.
//

import UIKit

class AlertManager {
    
    func alertCancel(with title: String, message: String, target: UIViewController, handler: ((UIAlertAction) -> Void)? = nil) {
        alert(with: title, message: message, target: target, actions: [cancelAction(handler)])
    }
    
    func alert(with title: String, message: String, target: UIViewController, action: String, handler: ((UIAlertAction) -> Void)?, cancelHandler: ((UIAlertAction) -> Void)? = nil) {
        alert(with: title, message: message, target: target, actions: [cancelAction(cancelHandler), customAction(title: action, handler: handler)])
    }
    
    //MARK: Private
    private func cancelAction(_ handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        return UIAlertAction(title: "Cancel", style: .cancel, handler: handler)
    }
    
    private func customAction(title: String, handler: ((UIAlertAction) -> Void)?) -> UIAlertAction {
        return UIAlertAction(title: title, style: .default, handler: handler)
    }
    
    private func alert(with title: String, message: String, target: UIViewController, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addActions(actions)
        target.present(alert, animated: true, completion: nil)
    }
}
