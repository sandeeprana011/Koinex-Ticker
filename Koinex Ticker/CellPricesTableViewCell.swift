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
    @IBOutlet weak var lPrice: UILabel!;

    func updateCellData(_ key: String, _ value: String) {
        self.lName.text = key;
        self.lPrice.text = value;
    }
}
