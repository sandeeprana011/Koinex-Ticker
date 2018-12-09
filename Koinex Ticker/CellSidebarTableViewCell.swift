//
//  CellSidebarTableViewCell.swift
//  Koinex Ticker
//
//  Created by Sandeep Rana on 09/12/18.
//  Copyright © 2018 Sandeep Rana. All rights reserved.
//

import UIKit

class CellSidebarTableViewCell: UITableViewCell {
    @IBOutlet weak var lNameKey: UILabel!;
    @IBOutlet weak var lKeyFirstLetter: UILabel!;

    func updateCellData(_ key: String, _ currentValue: StatsValue, previousValue: StatsValue?) {
        self.lNameKey.text = key;
        self.lKeyFirstLetter.text = key.first?.description ?? "";
    }
}
