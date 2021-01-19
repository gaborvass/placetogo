//
//  LoadingViewController.swift
//
//  Created by Gábor Vass on 18/01/2021.
//

import Foundation
import UIKit

class LoadingViewController: UIViewController {

    fileprivate var loadingIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.loadingIndicator.startAnimating()
        super.viewDidAppear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        self.loadingIndicator.stopAnimating()
        super.viewDidDisappear(animated)
    }
    
    private func setup() {
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = .gray
        self.view.alpha = 0.4
        setupLoadingIndicator()
    }

    fileprivate func setupLoadingIndicator() {
        self.loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
		self.loadingIndicator.style = UIActivityIndicatorView.Style.large
        self.view.addSubview(self.loadingIndicator)
        NSLayoutConstraint.activate([
            self.loadingIndicator.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.loadingIndicator.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
}
