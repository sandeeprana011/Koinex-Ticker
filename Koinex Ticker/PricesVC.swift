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

    var refreshControl: UIRefreshControl = UIRefreshControl();

    @IBOutlet weak var tableView: UITableView!;
    @IBOutlet weak var stackViewTabsTop: UIStackView!;

    private var pricesContent: [String: Any]?;
    private var previousPricesContent: [String: String] = [String: String](); // For historical effects

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
           let value = tempPricesContent[key] as? String {
            cell.updateCellData(key, value, previousValue: previousPricesContent[key]);
            previousPricesContent[key] = value;
        }
        return cell;
    }

    func getTagName() -> String {
        return "\(self)";
        // For more advance usage classify delegates on the basis of tags
    }

    func onDataRefresh(withTicker: Any) {
        self.refreshControl.endRefreshing();
        DispatchQueue.main.async {
            if let pricesContentTemp = withTicker as? [String: Any] {
                self.pricesContent = pricesContentTemp[Keys.prices.rawValue] as? [String: Any];
                if self.currentlySelectedPriceAssetCat.isEmpty, let content = self.pricesContent, let allKeysInPrices = self.pricesContent?.keys {
                    self.currentlySelectedPriceAssetCat = Array(allKeysInPrices).first ?? "";
                    self.title = "Prices(\(self.currentlySelectedPriceAssetCat.uppercased()))";
                    self.addButtonsInTopTabForPriceCurrencies(tabTitles: Array(allKeysInPrices))
                }
            }

            let contentOffset = self.tableView.contentOffset
            self.tableView.reloadData()
			
            self.tableView.setContentOffset(contentOffset, animated: false)
        }
    }

    private func addButtonsInTopTabForPriceCurrencies(tabTitles: [String]) {
        self.stackViewTabsTop.subviews.forEach({ $0.removeFromSuperview() });

        for title in tabTitles {
            let button = UIButton(type: .custom);
            button.layer.cornerRadius = 15;
            button.addConstraint(NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100));
            button.backgroundColor = UIColor.black;
            button.setSameTitleForAllStates(title: title.uppercased());
            button.addTarget(self, action: #selector(self.selectMe(_:)), for: .touchUpInside);
            button.updateForSelection();
            self.stackViewTabsTop.addArrangedSubview(button);
        }
        (self.stackViewTabsTop.subviews.first as? UIButton)?.isSelected = true;
        (self.stackViewTabsTop.subviews.first as? UIButton)?.updateForSelection();

    }

    func onRefreshError(withError: Error?) {
        self.refreshControl.endRefreshing();
    }

    @IBAction func selectMe(_ sender: UIButton) {
        self.previousPricesContent.removeAll();
        self.stackViewTabsTop.unselectAllButtonsInsideMe();
        let title = sender.title(for: .normal);
        sender.isSelected = true;
        sender.updateForSelection();
        self.currentlySelectedPriceAssetCat = title?.lowercased() ?? "";
        self.title = "Prices(\(self.currentlySelectedPriceAssetCat.uppercased()))";
        self.tableView.reloadData();
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
		self.refreshControl.tintColor = UIColor.white;
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh");
        self.refreshControl.addTarget(self, action: #selector(self.restartPollingFor60Secs(_:)), for: .valueChanged);
        self.tableView.addSubview(self.refreshControl);
    }

    @objc func restartPollingFor60Secs(_ sender: Any) {
        (self.navigationController as? KNavigationVC)?.startPollingFor60Seconds()
        DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
            (self.navigationController as? KNavigationVC)?.task?.cancel();
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        (self.navigationController as? KNavigationVC)?.subscribeToRefresh(withDelegate: self);
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        (self.navigationController as? KNavigationVC)?.unsubscribeFromRefresh(withDelegate: self);
    }

    @IBAction func onClickStats(_ sender: UIBarButtonItem) {
        let vcStats = StatsVC.instantiate(fromAppStoryboard: .Main);
        if let statsContentTemp = (self.navigationController as? KNavigationVC)?.tickerResponseModel as? [String: Any] {
            vcStats.statsContent = statsContentTemp[Keys.stats.rawValue] as? [String: Any];
        }

        self.navigationController?.pushViewController(vcStats, animated: true);
    }
}
