//
//  ViewController.swift
//  Koinex Ticker
//
//  Created by Sandeep Rana on 07/12/18.
//  Copyright © 2018 Sandeep Rana. All rights reserved.
//

import UIKit

class PricesVC: UIViewController, DelegateDataRefreshed {
    func getTagName() -> String {
        return "\(self)";
        // For more advance usage classify delegates on the basis of tags
    }

    func onDataRefresh(withTicker: TickerResponse) {
        
    }

    func onRefreshError(withError: Error?) {

    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        (self.navigationController as? KNavigationVC)?.subscribeToRefresh(withDelegate: self);
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        (self.navigationController as? KNavigationVC)?.unsubscribeFromRefresh(withDelegate: self);
    }
}
