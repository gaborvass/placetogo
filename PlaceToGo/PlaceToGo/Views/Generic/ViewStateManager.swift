//
//  ViewStateManager.swift
//
//  Created by Gábor Vass on 06/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation
import UIKit

class ViewStateManager {
    
    enum State {
        case initial
        case showLoading
        case hideLoading
        case showError(_ error: Error)
    }

    var state: State = .initial {
        didSet {
            self.applyState()
        }
    }

    fileprivate unowned let parentViewController: UIViewController

    fileprivate lazy var loadingView: UIViewController = {
        return LoadingViewController()
    }()

    init(parent: UIViewController) {
        self.parentViewController = parent
    }

    fileprivate func applyState() {
        switch state {
        case .initial:
            break
        case .showLoading:
            showContent(self.loadingView)
        case .hideLoading:
            hideContent(self.loadingView)
        case .showError(let error):
            hideContent(self.loadingView)
            showError(error)
        }
    }

    fileprivate func showError(_ error: Error) {
        UIAlertController.show(title: "Error", message: error.localizedDescription)
    }

    fileprivate func hideContent(_ viewController: UIViewController) {
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
        viewController.didMove(toParent: nil)
    }

    fileprivate func showContent(_ viewController: UIViewController) {
        self.parentViewController.install(viewController)
    }

}
