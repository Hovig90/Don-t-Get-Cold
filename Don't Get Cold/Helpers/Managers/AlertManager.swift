//
//  AlertManager.swift
//  Emshi
//
//  Created by Hovig Kousherian on 2/21/17.
//  Copyright © 2017 Hovig Kousherian. All rights reserved.
//

import UIKit

class AlertManager {
    
    func alertCancel(with title: String, message: String, target: UIViewController) {
        alert(with: title, message: message, target: target, actions: [cancelAction()])
    }
    
    func alert(with title: String, message: String, target: UIViewController, action: String, handler: ((UIAlertAction) -> Void)?) {
        alert(with: title, message: message, target: target, actions: [cancelAction(), customAction(title: action, handler: handler)])
    }
    
    //    func alert(with title: String, message: String, target: UIViewController, actions: [String], handlers: [((UIAlertAction) -> Void)?]) {
    //        var actionsArray = Array<UIAlertAction>()
    //        actionsArray.append(cancelAction())
    //        for let (action, handler) in (actions, handlers) {
    //            actionsArray.append(contentsOf: customAction(title: action, handler: handler))
    //        }
    //        alert(with: title, message: message, target: target, actions: actionsArray)
    //    }
    
    //MARK: Private
    private func cancelAction() -> UIAlertAction {
        return UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
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
