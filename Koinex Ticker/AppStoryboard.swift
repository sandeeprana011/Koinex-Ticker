//
//  AppStoryboard.swift
//  InvestO2O
//
//  Created by Sandeep Rana on 09/12/18.
//  Copyright © 2018 O2O. All rights reserved.
//

import Foundation
import UIKit

enum AppStoryboard: String {


    case Main

    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }

    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T
    }


    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController();
    }
}

extension UIViewController {
    class var storyboardID: String {
        return "\(self)"
    }
}

extension NSObject {
    class func className() -> String {
        return String(describing: self);
    }
}


