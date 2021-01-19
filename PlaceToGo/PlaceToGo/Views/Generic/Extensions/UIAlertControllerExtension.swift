//
//  UIAlertControllerExtension.swift
//
//  Created by Gábor Vass on 18/01/2021.
//

import Foundation
import UIKit

extension UIAlertController {
    
    class func show(title: String?, message: String?) {
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction.init(title: "OK", style: .default, handler: { _ in
            alertController.dismiss(animated: false, completion: nil)
        })
        alertController.addAction(closeAction)
        alertController.view.accessibilityViewIsModal = true
		var presentedViewController = UIApplication.shared.windows.first?.rootViewController
        if presentedViewController?.presentedViewController != nil {
            presentedViewController = presentedViewController?.presentedViewController
        }
        presentedViewController?.present(alertController, animated: false, completion: nil)
    }
}
