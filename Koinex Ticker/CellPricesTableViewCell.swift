//
//  CellPricesTableViewCell.swift
//  Koinex Ticker
//
//  Created by Sandeep Rana on 09/12/18.
//  Copyright © 2018 Sandeep Rana. All rights reserved.
//

import UIKit

class CellPricesTableViewCell: UITableViewCell {

    @IBOutlet weak var lName: UILabel!;
    @IBOutlet weak var lFirstLetter: UILabel!;
    @IBOutlet weak var lPrice: UILabel!;

    func updateCellData(_ key: String, _ currentValue: String, previousValue: String?) {
        self.lName.text = key;
        self.lPrice.text = currentValue;
        if let preValueString: String = previousValue, let prValue = Double(preValueString), let curValue = Double(currentValue) {
            if (curValue > prValue) {
                self.lPrice.textColor = UIColor.green;
            } else if (curValue < prValue) {
                self.lPrice.textColor = UIColor.red;
            } else {
                self.lPrice.textColor = UIColor.white;
            }
        }
        self.lFirstLetter.text = key.first?.description ?? "-";
    }
}
