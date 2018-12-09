//
//  StatsVC.swift
//  Koinex Ticker
//
//  Created by Sandeep Rana on 09/12/18.
//  Copyright © 2018 Sandeep Rana. All rights reserved.
//

import UIKit

class StatsVC: UIViewController, DelegateDataRefreshed, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!;
    @IBOutlet weak var tableViewSidebar: UITableView!;
    @IBOutlet weak var stackViewTabsTop: UIStackView!;

    private var statsContent: [String: Any]?;
    private var previousPricesContent: [String: StatsValue] = [String: StatsValue](); // For historical effects

    var currentlySelectedPriceAssetCat: String = "";

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let currency = statsContent?[currentlySelectedPriceAssetCat] {
            return (currency as? [String: Any])?.count ?? 0;
        }
        return 0;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let tempPricesContent = statsContent?[currentlySelectedPriceAssetCat] as? [String: Any],
           let key = Array(tempPricesContent.keys)[indexPath.row] as? String,
           let value = tempPricesContent[key] {
            if let statsValue = StatsValue.getStatsValue(dictionary: value) {
                if tableView == self.tableViewSidebar { // for sidebar tableview
                    let cellSidebar = tableView.dequeueReusableCell(withIdentifier: CellSidebarTableViewCell.className()) as! CellSidebarTableViewCell;
                    cellSidebar.updateCellData(key, statsValue, previousValue: previousPricesContent[key])
                    return cellSidebar;
                }

                let cell = tableView.dequeueReusableCell(withIdentifier: CellStatsTableViewCell.className()) as! CellStatsTableViewCell;

                cell.updateCellData(key, statsValue, previousValue: previousPricesContent[key]);
                previousPricesContent[key] = statsValue;
            }
        }
        return UITableViewCell(frame: self.stackViewTabsTop.frame);
    }

    func getTagName() -> String {
        return "\(self)";
        // For more advance usage classify delegates on the basis of tags
    }

    func onDataRefresh(withTicker: Any) {

        DispatchQueue.main.async {
            if let statsContentTemp = withTicker as? [String: Any] {
                self.statsContent = statsContentTemp[Keys.stats.rawValue] as? [String: Any];
                if self.currentlySelectedPriceAssetCat.isEmpty, let content = self.statsContent, let allKeysInPrices = self.statsContent?.keys {
                    self.currentlySelectedPriceAssetCat = Array(allKeysInPrices).first ?? "";
                    self.title = "Stats(\(self.currentlySelectedPriceAssetCat.uppercased()))";
                    self.addButtonsInTopTabForPriceCurrencies(tabTitles: Array(allKeysInPrices))
                }
            }

            let contentOffset = self.tableView.contentOffset
            self.tableView.reloadData()
            self.tableViewSidebar.reloadData();
            self.tableViewSidebar.setContentOffset(contentOffset, animated: false)
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
//            button.setTitleColor(UIColor.white, for: .normal);
//            button.setTitleColor(UIColor.black, for: .selected);

            button.updateForSelection();
            self.stackViewTabsTop.addArrangedSubview(button);
        }
    }

    func onRefreshError(withError: Error?) {

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
        self.tableViewSidebar.dataSource = self;
        self.tableViewSidebar.delegate = self;

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
        self.navigationController?.pushViewController(vcStats, animated: true);
    }
}
