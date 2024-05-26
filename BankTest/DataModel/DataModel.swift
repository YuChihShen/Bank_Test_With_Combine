//
//  File.swift
//  BankTest
//
//  Created by Yu-Chih Shen on 2024/5/26.
//

import Foundation

// MARK: - Response
struct Response: Codable {
    let msgCode, msgContent: String
    let result: Result
}

// MARK: - Result
struct Result: Codable {
    let messages: [Message]?
    let favoriteList: [FavoriteInfo]?
    let bannerList: [BannerInfo]?
    let savingsList: [BalanceInfo]?
    let fixedDepositList: [BalanceInfo]?
    let digitalList: [BalanceInfo]?
}

// MARK: - Message
struct Message: Codable {
    let status: Bool
    let updateDateTime: String
    let title: String
    let message: String
}

// MARK: - FavoriteList
struct FavoriteInfo: Codable {
    let nickname, transType: String
}

// MARK: - BannerList
struct BannerInfo: Codable {
    let adSeqNo: Int
    let linkURL: String

    enum CodingKeys: String, CodingKey {
        case adSeqNo
        case linkURL = "linkUrl"
    }
}

// MARK: - DigitalList
struct BalanceInfo: Codable {
    let account, curr: String
    let balance: Double
}


