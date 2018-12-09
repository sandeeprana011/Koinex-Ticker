//
// Created by Sandeep Rana on 2018-12-09.
// Copyright (c) 2018 Sandeep Rana. All rights reserved.
//

import Foundation

protocol DelegateDataRefreshed {
    func getTagName() -> String;
    func onDataRefresh(withTicker: TickerResponse);
    func onRefreshError(withError: Error?);
}
