//
//  CellStatsTableViewcell.swift
//  Koinex Ticker
//
//  Created by Sandeep Rana on 09/12/18.
//  Copyright © 2018 Sandeep Rana. All rights reserved.
//

import UIKit

class CellStatsTableViewCell: UITableViewCell {

    @IBOutlet weak var highest_bid: UILabel!;
    @IBOutlet weak var lowest_ask: UILabel!;
    @IBOutlet weak var last_traded_price: UILabel!;
    @IBOutlet weak var min_24hrs: UILabel!;
    @IBOutlet weak var max_24hrs: UILabel!;
    @IBOutlet weak var vol_24hrs: UILabel!;
    @IBOutlet weak var currency_full_form: UILabel!;
    @IBOutlet weak var currency_short_form: UILabel!;
    @IBOutlet weak var per_change: UILabel!;
    @IBOutlet weak var trade_volume: UILabel!;


    func updateCellData(_ key: String, _ currentValue: StatsValue, previousValue: StatsValue?) {
        self.backgroundColor = UIColor.black;

        self.highest_bid.setColoredValues(currentValue.highest_bid, previousValue?.highest_bid ?? currentValue.highest_bid);

        self.highest_bid.text = currentValue.highest_bid;
        self.lowest_ask.text = currentValue.lowest_ask;
        self.last_traded_price.text = currentValue.last_traded_price;
        self.min_24hrs.text = currentValue.min_24hrs;
        self.max_24hrs.text = currentValue.max_24hrs;
        self.vol_24hrs.text = currentValue.vol_24hrs;
        self.currency_full_form.text = currentValue.currency_full_form;
        self.currency_short_form.text = currentValue.currency_short_form;
        self.per_change.text = currentValue.per_change;
        self.trade_volume.text = currentValue.trade_volume;


        self.highest_bid.setColoredValues(currentValue.highest_bid, previousValue?.highest_bid)
        self.lowest_ask.setColoredValues(currentValue.lowest_ask, previousValue?.lowest_ask)
        self.last_traded_price.setColoredValues(currentValue.last_traded_price, previousValue?.last_traded_price)
        self.min_24hrs.setColoredValues(currentValue.min_24hrs, previousValue?.min_24hrs)
        self.max_24hrs.setColoredValues(currentValue.max_24hrs, previousValue?.max_24hrs)
        self.vol_24hrs.setColoredValues(currentValue.vol_24hrs, previousValue?.vol_24hrs)
        self.currency_full_form.setColoredValues(currentValue.currency_full_form, previousValue?.currency_full_form)
        self.currency_short_form.setColoredValues(currentValue.currency_short_form, previousValue?.currency_short_form)
        self.per_change.setColoredValues(currentValue.per_change, previousValue?.per_change)
        self.trade_volume.setColoredValues(currentValue.trade_volume, previousValue?.trade_volume)


//        self.lName.text = key;
//        self.lPrice.text = currentValue;
//        if let preValueString: String = previousValue, let prValue = Double(preValueString), let curValue = Double(currentValue) {
//            if (curValue > prValue) {
//                self.lPrice.textColor = UIColor.green;
//            } else if (curValue < prValue) {
//                self.lPrice.textColor = UIColor.red;
//            } else {
//                self.lPrice.textColor = UIColor.white;
//            }
//        }
//        self.lFirstLetter.text = key.first?.description ?? "-";
    }
}
