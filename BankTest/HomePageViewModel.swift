//
//  HomePageViewModel.swift
//  BankTest
//
//  Created by Yu-Chih Shen on 2024/5/25.
//

import UIKit
import Combine

class HomePageViewModel: NSObject {
    static let sharedInstance = HomePageViewModel()
    
    
    @Published var isLoadingBalance = true
    @Published var shouldHideBalance = false
    @Published var usdBalanceString = "0"
    @Published var khrBalanceString = "0"
    @Published var notificationList: [Message] = []
    @Published var favoriteList: [FavoriteInfo] = []
    @Published var bannerList: [BannerInfo] = []
    var usdBalanceInfoList: [BalanceInfo] = []
    var khrBalanceInfoList: [BalanceInfo] = []
    let amountCalculateQueue = DispatchQueue(label: "amount")
    
    func getFirstOpenData() {
        self.usdBalanceInfoList.removeAll()
        self.khrBalanceInfoList.removeAll()
        
        APIController().getData(urlEnum: .firstGetNotificationList) { data, response, err in
            guard let data = data else {
                print("err from \(APIController.URLString.firstGetNotificationList.rawValue): \(err?.localizedDescription ?? "")")
                return
            }
            
            if let notificationList = try? JSONDecoder().decode(Response.self, from: data).result.messages {
                self.notificationList  = notificationList
            } else {
                self.notificationList.removeAll()
            }
        }
        
        APIController().getData(urlEnum: .firstGetFavoriteList) { data, response, err in
            guard let data = data else {
                print("err from \(APIController.URLString.firstGetFavoriteList.rawValue): \(err?.localizedDescription ?? "")")
                return
            }
            
            if let favoriteList = try? JSONDecoder().decode(Response.self, from: data).result.favoriteList {
                self.favoriteList  = favoriteList
            } else {
                self.favoriteList.removeAll()
            }
        }
        
        APIController().getData(urlEnum: .getADs) { data, response, err in
            guard let data = data else {
                print("err from \(APIController.URLString.getADs.rawValue): \(err?.localizedDescription ?? "")")
                return
            }
            
            if let ADs = try? JSONDecoder().decode(Response.self, from: data).result.bannerList {
                self.bannerList = ADs
            } else {
                self.bannerList.removeAll()
            }
        }
        
        let amountGroup = DispatchGroup()
        
        amountGroup.enter()
        APIController().getData(urlEnum: .firstGetUSDSaving) { data, response, err in
            guard let data = data else {
                print("err from \(APIController.URLString.firstGetUSDSaving.rawValue): \(err?.localizedDescription ?? "")")
                return
            }
            
            if let savingsList = try? JSONDecoder().decode(Response.self, from: data).result.savingsList {
                self.addBalanceInfoList(list: savingsList, DispatchGroup: amountGroup)
            } else {
                amountGroup.leave()
            }
        }
        
        amountGroup.enter()
        APIController().getData(urlEnum: .firstGetUSDFixedDeposited) { data, response, err in
            guard let data = data else {
                print("err from \(APIController.URLString.firstGetUSDFixedDeposited.rawValue): \(err?.localizedDescription ?? "")")
                return
            }
            
            if let fixedDepositList = try? JSONDecoder().decode(Response.self, from: data).result.fixedDepositList {
                self.addBalanceInfoList(list: fixedDepositList, DispatchGroup: amountGroup)
            } else {
                amountGroup.leave()
            }
        }
        
        amountGroup.enter()
        APIController().getData(urlEnum: .firstGetUSDDigital) { data, response, err in
            guard let data = data else {
                print("err from \(APIController.URLString.firstGetUSDDigital.rawValue): \(err?.localizedDescription ?? "")")
                return
            }
            
            if let digitalList = try? JSONDecoder().decode(Response.self, from: data).result.digitalList {
                self.addBalanceInfoList(list: digitalList, DispatchGroup: amountGroup)
            } else {
                amountGroup.leave()
            }
        }
        
        amountGroup.enter()
        APIController().getData(urlEnum: .firstGetKHRSaving) { data, response, err in
            guard let data = data else {
                print("err from \(APIController.URLString.firstGetKHRSaving.rawValue): \(err?.localizedDescription ?? "")")
                return
            }
            
            if let savingsList = try? JSONDecoder().decode(Response.self, from: data).result.savingsList {
                self.addBalanceInfoList(list: savingsList, DispatchGroup: amountGroup)
            } else {
                amountGroup.leave()
            }
        }
        
        amountGroup.enter()
        APIController().getData(urlEnum: .firstGetKHRFixedDeposited) { data, response, err in
            guard let data = data else {
                print("err from \(APIController.URLString.firstGetKHRFixedDeposited.rawValue): \(err?.localizedDescription ?? "")")
                return
            }
            
            if let fixedDepositList = try? JSONDecoder().decode(Response.self, from: data).result.fixedDepositList {
                self.addBalanceInfoList(list: fixedDepositList, DispatchGroup: amountGroup)
            } else {
                amountGroup.leave()
            }
        }
        
        amountGroup.enter()
        APIController().getData(urlEnum: .firstGetKHRDigital) { data, response, err in
            guard let data = data else {
                print("err from \(APIController.URLString.firstGetKHRDigital.rawValue): \(err?.localizedDescription ?? "")")
                return
            }
            
            if let digitalList = try? JSONDecoder().decode(Response.self, from: data).result.digitalList {
                self.addBalanceInfoList(list: digitalList, DispatchGroup: amountGroup)
            } else {
                amountGroup.leave()
            }
        }
        
        amountGroup.notify(queue: .main) {
            let numberFormate = NumberFormatter()
            numberFormate.numberStyle = .currency
            numberFormate.maximumFractionDigits = 2
            let usdAmount = self.usdBalanceInfoList.reduce(0) { sum, balanceInfo in
                return sum + balanceInfo.balance
            }
            self.usdBalanceString = numberFormate.string(from: NSNumber(value: usdAmount)) ?? "0"
            
            let khrAmount = self.khrBalanceInfoList.reduce(0) { sum, balanceInfo in
                return sum + balanceInfo.balance
            }
            self.khrBalanceString = numberFormate.string(from: NSNumber(value: khrAmount)) ?? "0"
            
            self.isLoadingBalance = false
        }
        
    }
    
    func pullRefreshData() {
        self.isLoadingBalance = true
        self.usdBalanceInfoList.removeAll()
        self.khrBalanceInfoList.removeAll()
        
        APIController().getData(urlEnum: .pullRefreshGetNotificationList) { data, response, err in
            guard let data = data else {
                print("err from \(APIController.URLString.pullRefreshGetNotificationList.rawValue): \(err?.localizedDescription ?? "")")
                return
            }
            
            if let notificationList = try? JSONDecoder().decode(Response.self, from: data).result.messages {
                self.notificationList  = notificationList
            } else {
                self.notificationList.removeAll()
            }
        }
        
        APIController().getData(urlEnum: .pullRefreshGetFavoriteList) { data, response, err in
            guard let data = data else {
                print("err from \(APIController.URLString.pullRefreshGetFavoriteList.rawValue): \(err?.localizedDescription ?? "")")
                return
            }
            
            if let favoriteList = try? JSONDecoder().decode(Response.self, from: data).result.favoriteList {
                self.favoriteList  = favoriteList
            } else {
                self.favoriteList.removeAll()
            }
        }
        
        APIController().getData(urlEnum: .getADs) { data, response, err in
            guard let data = data else {
                print("err from \(APIController.URLString.getADs.rawValue): \(err?.localizedDescription ?? "")")
                return
            }
            
            if let ADs = try? JSONDecoder().decode(Response.self, from: data).result.bannerList {
                self.bannerList = ADs
            } else {
                self.bannerList.removeAll()
            }
        }
        
        let amountGroup = DispatchGroup()
        amountGroup.enter()
        APIController().getData(urlEnum: .pullRefreshGetUSDSaving) { data, response, err in
            guard let data = data else {
                print("err from \(APIController.URLString.pullRefreshGetUSDSaving.rawValue): \(err?.localizedDescription ?? "")")
                return
            }
            
            if let savingsList = try? JSONDecoder().decode(Response.self, from: data).result.savingsList {
                self.addBalanceInfoList(list: savingsList, DispatchGroup: amountGroup)
            } else {
                amountGroup.leave()
            }
        }
        
        amountGroup.enter()
        APIController().getData(urlEnum: .pullRefreshGetUSDFixedDeposited) { data, response, err in
            guard let data = data else {
                print("err from \(APIController.URLString.pullRefreshGetUSDFixedDeposited.rawValue): \(err?.localizedDescription ?? "")")
                return
            }
            
            if let fixedDepositList = try? JSONDecoder().decode(Response.self, from: data).result.fixedDepositList {
                self.addBalanceInfoList(list: fixedDepositList, DispatchGroup: amountGroup)
            } else {
                amountGroup.leave()
            }
        }
        
        amountGroup.enter()
        APIController().getData(urlEnum: .pullRefreshGetUSDDigital) { data, response, err in
            guard let data = data else {
                print("err from \(APIController.URLString.pullRefreshGetUSDDigital.rawValue): \(err?.localizedDescription ?? "")")
                return
            }
            
            if let digitalList = try? JSONDecoder().decode(Response.self, from: data).result.digitalList {
                self.addBalanceInfoList(list: digitalList, DispatchGroup: amountGroup)
            } else {
                amountGroup.leave()
            }
        }
        
        amountGroup.enter()
        APIController().getData(urlEnum: .pullRefreshGetKHRSaving) { data, response, err in
            guard let data = data else {
                print("err from \(APIController.URLString.pullRefreshGetKHRSaving.rawValue): \(err?.localizedDescription ?? "")")
                return
            }
            
            if let savingsList = try? JSONDecoder().decode(Response.self, from: data).result.savingsList {
                self.addBalanceInfoList(list: savingsList, DispatchGroup: amountGroup)
            } else {
                amountGroup.leave()
            }
        }
        
        amountGroup.enter()
        APIController().getData(urlEnum: .pullRefreshGetKHRFixedDeposited) { data, response, err in
            guard let data = data else {
                print("err from \(APIController.URLString.pullRefreshGetKHRFixedDeposited.rawValue): \(err?.localizedDescription ?? "")")
                return
            }
            
            if let fixedDepositList = try? JSONDecoder().decode(Response.self, from: data).result.fixedDepositList {
                self.addBalanceInfoList(list: fixedDepositList, DispatchGroup: amountGroup)
            } else {
                amountGroup.leave()
            }
        }
        
        amountGroup.enter()
        APIController().getData(urlEnum: .pullRefreshGetKHRDigital) { data, response, err in
            guard let data = data else {
                print("err from \(APIController.URLString.pullRefreshGetKHRDigital.rawValue): \(err?.localizedDescription ?? "")")
                return
            }
            
            if let digitalList = try? JSONDecoder().decode(Response.self, from: data).result.digitalList {
                self.addBalanceInfoList(list: digitalList, DispatchGroup: amountGroup)
            } else {
                amountGroup.leave()
            }
        }
        
        amountGroup.notify(queue: .main) {
            let numberFormate = NumberFormatter()
            numberFormate.numberStyle = .currency
            numberFormate.maximumFractionDigits = 2
            let usdAmount = self.usdBalanceInfoList.reduce(0) { sum, balanceInfo in
                return sum + balanceInfo.balance
            }
            self.usdBalanceString = numberFormate.string(from: NSNumber(value: usdAmount)) ?? "0"
            
            let khrAmount = self.khrBalanceInfoList.reduce(0) { sum, balanceInfo in
                return sum + balanceInfo.balance
            }
            self.khrBalanceString = numberFormate.string(from: NSNumber(value: khrAmount)) ?? "0"
            
            self.isLoadingBalance = false
        }
    }
    
    func addBalanceInfoList(list: [BalanceInfo], DispatchGroup: DispatchGroup) {
        amountCalculateQueue.async(flags: .barrier) {
            for balanceInfo in list {
                if balanceInfo.curr == "USD" {
                    self.usdBalanceInfoList.append(balanceInfo)
                }
                else if balanceInfo.curr == "KHR" {
                    self.khrBalanceInfoList.append(balanceInfo)
                }
            }
            DispatchGroup.leave()
        }
    }
    
    
    
}
