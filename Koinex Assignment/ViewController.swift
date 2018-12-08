//
//  ViewController.swift
//  Koinex Assignment
//
//  Created by Sandeep Rana on 07/12/18.
//  Copyright © 2018 Sandeep Rana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var task: URLSessionDataTask?;

    override func viewDidLoad() {
        super.viewDidLoad()
        startPollingFor60Seconds();
        DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
            self.task?.cancel();
        }
    }

    func startPollingFor60Seconds() {
        self.task = KoinexNetworking.ticker(completionHandle: { tickerResponseModel in
            print(tickerResponseModel);
            self.startPollingFor60Seconds();
        }, errorHandler: { error in
            print("Error");
        })
    }

    deinit {
        self.task?.cancel();
    }

}

