//
//  ViewController.swift
//  Koinex Ticker
//
//  Created by Sandeep Rana on 07/12/18.
//  Copyright © 2018 Sandeep Rana. All rights reserved.
//

import UIKit


enum Keys: String {
    case prices, stats, inr

}

class PricesVC: UIViewController, DelegateDataRefreshed, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!;

    private var pricesContent: [String: Any]?;

    var currentlySelectedPriceAssetCat: String = "";


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let currency = pricesContent?[currentlySelectedPriceAssetCat] {
            return (currency as? [String: String])?.count ?? 0;
        }
        return 0;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellPricesTableViewCell.className()) as! CellPricesTableViewCell;
        if let tempPricesContent = pricesContent?[currentlySelectedPriceAssetCat] as? [String: Any],
           let key = Array(tempPricesContent.keys)[indexPath.row] as? String,
           let value = tempPricesContent[key] as? String{
			cell.updateCellData(key ,value );
        }
        return cell;
    }

    func getTagName() -> String {
        return "\(self)";
        // For more advance usage classify delegates on the basis of tags
    }

    func onDataRefresh(withTicker: Any) {

        DispatchQueue.main.async {
            if let pricesContentTemp = withTicker as? [String: Any] {
                self.pricesContent = pricesContentTemp[Keys.prices.rawValue] as? [String: Any];
                if self.currentlySelectedPriceAssetCat.isEmpty, let content = self.pricesContent, let allKeysInPrices = self.pricesContent?.keys {
                    self.currentlySelectedPriceAssetCat = Array(allKeysInPrices).first ?? "";
                }
            }

            self.tableView.reloadData();
        }
    }

    func onRefreshError(withError: Error?) {

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
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
