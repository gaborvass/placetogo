//
//  UIDesign.swift
//
//  Created by Gábor Vass on 18/01/2021.
//

import Foundation
import UIKit

enum UIDesign {
    enum Colors {
        
        // label color
        static let label: UIColor = {
			return UIColor.label
        }()
        
        // view background color
        static let viewBackground: UIColor = {
			return UIColor.systemBackground
        }()

		static let semiTransparentViewBackground: UIColor = {
			return UIColor.systemBackground.withAlphaComponent(0.7)
		}()

        // loading indicator color
        static let loadingIndicator: UIColor = {
			return UIColor.systemGray
        }()
    }

    enum Fonts {
        
        // style for label
        static let label: UIFont = {
            UIFont.boldSystemFont(ofSize: 16)
        }()
    }
}
