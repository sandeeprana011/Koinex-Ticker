//
//  Extensions.swift
//  Koinex Ticker
//
//  Created by Sandeep Rana on 09/12/18.
//  Copyright © 2018 Sandeep Rana. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    class var storyboardID: String {
        return "\(self)"
    }

    class func instantiate(fromAppStoryboard: AppStoryboard) -> Self {
        return fromAppStoryboard.viewController(viewControllerClass: self);
    }

}

extension NSObject {
    class func className() -> String {
        return String(describing: self);
    }
}


extension UIButton {
    func setSameTitleForAllStates(title: String) {
        self.setTitle(title, for: .normal);
        self.setTitle(title, for: .selected);
        self.setTitle(title, for: .disabled);
    }

    func updateForSelection() {
        if self.isSelected {
            self.backgroundColor = #colorLiteral(red: 0.1098385486, green: 0.8038348668, blue: 0, alpha: 1);
        } else {
            self.backgroundColor = #colorLiteral(red: 0.192270013, green: 0.3385479015, blue: 0.1135728634, alpha: 1);
        }

    }

}

extension UIStackView {
    func unselectAllButtonsInsideMe() {
        self.subviews.forEach({
            ($0 as? UIButton)?.isSelected = false;
            ($0 as? UIButton)?.updateForSelection()
        });
    }
}

extension UILabel {
    func setColoredValues(_ valueCurrent: String?, _ valuePrevious: String?) {
		if valueCurrent == nil {
			self.text = "-"
			return;
		}
		
        if (Double(valueCurrent!) ?? 0) > (Double(valuePrevious ?? valueCurrent!) ?? 0) {
            self.textColor = UIColor.green;
        } else if (Double(valueCurrent!) ?? 0) < (Double(valuePrevious ?? valueCurrent!) ?? 0) {
            self.textColor = UIColor.red;
        } else {
            self.textColor = UIColor.white;
        }
    }
}
