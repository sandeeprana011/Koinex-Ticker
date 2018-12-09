//
//  KoinexResponseModels.swift
//  Koinex Ticker
//
//  Created by Sandeep Rana on 07/12/18.
//  Copyright © 2018 Sandeep Rana. All rights reserved.
//

import Foundation


class TickerResponse: Codable {
    var prices: Prices?
    var stats: Stats?
}

class Prices: Codable {
    var inr: Inr?
    var bitcoin: PricesBitcoin?
    var ether: Ether?
    var ripple: Ripple?
}

class PricesBitcoin: Codable {
    var TUSD, LTC, NCASH, XRP: String?
    var OMG, EOS, REQ, ETH: String?
    var ZCO, TRX, BCHABC: String?
}

class Ether: Codable {
    var XRP, TRX, TUSD, LTC: String?
    var OMG, EOS, ZCO, BCHABC: String?
}

class Inr: Codable {
    var ETH, BTC, LTC, XRP: String?
    var OMG, REQ, ZRX, GNT: String?
    var BAT, AE, TRX, XLM: String?
    var NEO, GAS, XRB, NCASH: String?
    var EOS, CMT, ONT, ZIL: String?
    var IOST, ACT, ZCO, SNT: String?
    var POLY, ELF, REP, QKC: String?
    var XZC, BCHABC, TUSD, BCHSV: String?
}

class Ripple: Codable {
    var CMT, LTC, NCASH, AE: String?
    var EOS, GNT, REQ, OMG: String?
    var ONT, ZIL, IOST, ACT: String?
    var ZCO, SNT, POLY, ELF: String?
    var TRX, REP, QKC, XZC: String?
    var TUSD: String?
}

class InrStats: Codable {
    var ETH, BTC, LTC, XRP: StatsValue?
    var OMG, REQ, ZRX, GNT: StatsValue?
    var BAT, AE, TRX, XLM: StatsValue?
    var NEO, GAS, XRB, NCASH: StatsValue?
    var EOS, CMT, ONT, ZIL: StatsValue?
    var IOST, ACT, ZCO, SNT: StatsValue?
    var POLY, ELF, REP, QKC: StatsValue?
    var XZC, BCHABC, TUSD, BCHSV: StatsValue?
}

class BitcoinStats: Codable {
    var TUSD, LTC, NCASH, XRP: StatsValue?
    var OMG, EOS, REQ, ETH: StatsValue?
    var ZCO, TRX, BCHABC: StatsValue?
}

class EtherStats: Codable {
    var XRP, TRX, TUSD, LTC: StatsValue?
    var OMG, EOS, ZCO, BCHABC: StatsValue?
}

class RippleStats: Codable {
    var CMT, LTC, NCASH, AE: StatsValue?
    var EOS, GNT, REQ, OMG: StatsValue?
    var ONT, ZIL, IOST, ACT: StatsValue?
    var ZCO, SNT, POLY, ELF: StatsValue?
    var TRX, REP, QKC, XZC: StatsValue?
    var TUSD: StatsValue?
}

class Stats: Codable {
    var inr: InrStats?, bitcoin: BitcoinStats?, ether: EtherStats?, ripple: RippleStats?;
}

class StatsValue: Codable {
    static func getStatsValue(dictionary: Any) -> StatsValue? {
        if let dict = dictionary as? [String: String] {
            do {
                let data = try JSONSerialization.data(withJSONObject: dictionary)
				return try JSONDecoder().decode(StatsValue.self, from: data);
            } catch {
                return nil;
            }
        }
		return nil;
    }

    var highest_bid, lowest_ask, last_traded_price, min_24hrs: String?
    var max_24hrs, vol_24hrs, currency_full_form, currency_short_form: String?
    var per_change, trade_volume: String?
}
