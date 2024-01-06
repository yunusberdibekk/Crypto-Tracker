//
//  CoinModel.swift
//  CryptoTracker
//
//  Created by Yunus Emre Berdibek on 23.12.2023.
//

import Foundation

/*
 CoinGecko API info

 URL: https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h&locale=en

 */

// MARK: - CoinModel

struct CoinModel: Identifiable, Codable {
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation: Double?
    let totalVolume, high24H, low24H: Double?
    let priceChange24H: Double?
    let priceChangePercentage24H: Double?
    let marketCapChange24H: Double?
    let marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currentHoldings: Double?

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case currentHoldings
    }

    func updateHoldings(amount: Double) -> CoinModel {
        return CoinModel(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: atlDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency, currentHoldings: amount)
    }

    var currentHoldingsValue: Double {
        return (currentHoldings ?? 0) * currentPrice
    }

    var rank: Int {
        return Int(marketCapRank ?? 0)
    }

    static let coin: CoinModel = .init(
        id: "bitcoin",
        symbol: "btc",
        name: "Bitcoin",
        image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
        currentPrice: 43604,
        marketCap: 854156996999,
        marketCapRank: 1,
        fullyDilutedValuation: 916174975183,
        totalVolume: 14443558257,
        high24H: 44031,
        low24H: 43375,
        priceChange24H: -131.24692816560128,
        priceChangePercentage24H: -0.3001,
        marketCapChange24H: -1803857515.1236572,
        marketCapChangePercentage24H: -0.21074,
        circulatingSupply: 19578462,
        totalSupply: 21000000,
        maxSupply: 21000000,
        ath: 69045,
        athChangePercentage: -36.81618,
        athDate: "2021-11-10T14:24:11.849Z",
        atl: 67.81,
        atlChangePercentage: 64235.30107,
        atlDate: "2013-07-06T00:00:00.000Z",
        lastUpdated: "2023-12-23T10:43:12.483Z",
        sparklineIn7D: SparklineIn7D(price: [
            42217.64971299361,
            42178.5895500895,
            42201.54127714593,
            42150.7272070367,
            42217.169007236684,
            42213.66968847811,
            42290.04331379662,
            42364.065126544025,
            42369.15453638646,
            42328.58495622493,
            42455.90382816067,
            42538.61144249387,
            42523.65828775507,
            42430.85433343593,
            42327.72720339319,
            42301.03314934935,
            42262.61083778796,
            42280.784343161606,
            42247.06788172229,
            42168.232372076774,
            41964.70011838841,
            41895.91774791801,
            41896.79500044721,
            42008.21808088685,
            41836.5143907031,
            41846.17371588738,
            41832.58772096187,
            41856.595616305305,
            41880.318950690795,
            41951.23687802432,
            41912.421881823444,
            41897.35997205789,
            41780.984899072915,
            41618.83091158944,
            41796.88915488057,
            41936.18667039124,
            42019.197118232034,
            42108.513073472575,
            42067.25282235073,
            42093.60762392116,
            41897.02825234679,
            41690.75643956573,
            41410.819634575855,
            41362.91171945094,
            41104.51177162253,
            40934.408011580774,
            41078.59754461657,
            41192.25956971891,
            41032.246303288826,
            41162.79899656337,
            41119.617439077134,
            41121.155921359175,
            41026.87126514223,
            40766.453374015015,
            41085.176761082585,
            40893.047377700066,
            41356.749461472216,
            41558.74335611622,
            41285.318831431345,
            41458.55703059481,
            41376.881449683184,
            41600.834979258776,
            41689.453003751856,
            41976.518427616094,
            42610.07493525567,
            42502.290720873556,
            42608.74325242312,
            42690.53560062734,
            43327.20011389037,
            43145.60858243573,
            43041.171683882894,
            42930.425054175445,
            42937.54099290938,
            42918.66365395693,
            43021.40368928746,
            43079.936989509406,
            43047.449970738744,
            43171.61872889507,
            43020.08362356485,
            42948.59379311542,
            42896.207969536226,
            42375.1092559365,
            42476.9312225605,
            42311.57761372282,
            41837.17688502292,
            42158.71099511711,
            42259.909478399364,
            42176.97678250017,
            42475.28481432681,
            42314.93680541031,
            42250.206182797505,
            42394.7768948831,
            42286.829841898674,
            42407.29812467276,
            42408.6880555506,
            42866.22481670327,
            42698.518267332925,
            42879.9728189421,
            42917.66388272859,
            42789.05200905918,
            42763.73868945773,
            42852.79143895241,
            42939.475360201635,
            42959.11910055881,
            43653.9516599986,
            43944.96537914374,
            43999.75911150206,
            43943.58111851915,
            43944.856618704056,
            44155.79358985402,
            43805.203292317594,
            43578.280909586276,
            43410.58981739116,
            43643.640466175966,
            43659.922052764814,
            43581.03088178895,
            43458.7962164356,
            43375.5247963934,
            43681.62284345721,
            43621.020221001796,
            43516.73645475241,
            43639.1687226119,
            43746.865979213224,
            43708.644978523495,
            43746.74902190026,
            43943.7693811245,
            43911.16063486386,
            44066.90826527822,
            44214.73571182699,
            43761.68734719556,
            43731.36851417257,
            43604.01618648034,
            43419.05476833372,
            43554.46581423208,
            43572.11458571324,
            43752.60579719405,
            43986.287396668056,
            43967.899951599684,
            43849.69959939619,
            43856.947570644625,
            44116.485990175956,
            43969.37519536018,
            43989.61868583403,
            44143.267563751586,
            44217.040731185,
            43991.85841799646,
            43620.14482896564,
            43642.012995723744,
            43765.67985499456,
            43716.14622472332,
            43741.14969702127,
            43557.48903844105,
            43729.15012326257,
            43673.11953346734,
            43686.17545492739,
            43555.75099388794,
            43704.62801544885,
            43974.09121730847,
            43671.65389539266,
            43761.91643068718,
            43753.27692028811,
            43791.51220456886,
            44003.6960216438,
            43876.58480390429,
            43754.309121459766,
            43602.34190765028,
            43576.73526804481,
            43539.32179830861
        ]),
        priceChangePercentage24HInCurrency: -0.300096635222597,
        currentHoldings: 1.5)
}

// MARK: - SparklineIn7D

struct SparklineIn7D: Codable {
    let price: [Double]?
}
