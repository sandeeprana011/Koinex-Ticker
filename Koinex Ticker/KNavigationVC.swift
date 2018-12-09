//
//  KNavigationVC.swift
//  Koinex Ticker
//
//  Created by Sandeep Rana on 09/12/18.
//  Copyright © 2018 Sandeep Rana. All rights reserved.
//

import UIKit

class KNavigationVC: UINavigationController {
    var task: URLSessionDataTask?;

    lazy private var arrOfRefreshDelegates: Array<DelegateDataRefreshed> = Array<DelegateDataRefreshed>();

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.prefersLargeTitles = true;
        startPollingFor60Seconds();
        DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
            self.task?.cancel();
        }
    }

    func startPollingFor60Seconds() {
        self.task = KoinexNetworking.ticker(completionHandle: { tickerResponseModel in
            print(tickerResponseModel);
            self.startPollingFor60Seconds();
            self.notifyRefreshSubscribedDelegates(with: tickerResponseModel);
        }, errorHandler: { error in
            print(error?.localizedDescription ?? "");
            self.notifyErrorOnRefreshSubscribedDelegates(withError: error);
        })
    }

    func unsubscribeFromRefresh(withDelegate: DelegateDataRefreshed) {
        self.arrOfRefreshDelegates = self.arrOfRefreshDelegates.filter({ $0.getTagName() != withDelegate.getTagName() });
    }

    @IBAction func restartPollingFor60Secs(_ sender: UIBarButtonItem) {
        startPollingFor60Seconds();
        DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
            self.task?.cancel();
        }
    }

    private func notifyErrorOnRefreshSubscribedDelegates(withError: Error?) {
        self.arrOfRefreshDelegates.forEach({ ($0 as DelegateDataRefreshed).onRefreshError(withError: withError) })
    }

    private func notifyRefreshSubscribedDelegates(with tickerResponse: Any) {
        self.arrOfRefreshDelegates.forEach({ ($0 as DelegateDataRefreshed).onDataRefresh(withTicker: tickerResponse) })
    }

    deinit {
        self.task?.cancel();
    }

    func subscribeToRefresh(withDelegate: DelegateDataRefreshed) {
        self.arrOfRefreshDelegates.append(withDelegate);
    }
}
