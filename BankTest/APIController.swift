//
//  APIController.swift
//  BankTest
//
//  Created by Yu-Chih Shen on 2024/5/26.
//

import Foundation
import UIKit

class APIController: NSObject {
    
    enum URLString:String {
        case firstGetNotificationList               = "https://willywu0201.github.io/data/emptyNotificationList.json"
        case firstGetUSDSaving                      = "https://willywu0201.github.io/data/usdSavings1.json"
        case firstGetUSDFixedDeposited              = "https://willywu0201.github.io/data/usdFixed1.json"
        case firstGetUSDDigital                     = "https://willywu0201.github.io/data/usdDigital1.json"
        case firstGetKHRSaving                      = "https://willywu0201.github.io/data/khrSavings1.json"
        case firstGetKHRFixedDeposited              = "https://willywu0201.github.io/data/khrFixed1.json"
        case firstGetKHRDigital                     = "https://willywu0201.github.io/data/khrDigital1.json"
        case firstGetFavoriteList                   = "https://willywu0201.github.io/data/emptyFavoriteList.json"
        case getADs                                 = "https://willywu0201.github.io/data/banner.json"
        
        case pullRefreshGetNotificationList         = "https://willywu0201.github.io/data/notificationList.json"
        case pullRefreshGetUSDSaving                = "https://willywu0201.github.io/data/usdSavings2.json"
        case pullRefreshGetUSDFixedDeposited        = "https://willywu0201.github.io/data/usdFixed2.json"
        case pullRefreshGetUSDDigital               = "https://willywu0201.github.io/data/usdDigital2.json"
        case pullRefreshGetKHRSaving                = "https://willywu0201.github.io/data/khrSavings2.json"
        case pullRefreshGetKHRFixedDeposited        = "https://willywu0201.github.io/data/khrFixed2.json"
        case pullRefreshGetKHRDigital               = "https://willywu0201.github.io/data/khrDigital2.json"
        case pullRefreshGetFavoriteList             = "https://willywu0201.github.io/data/favoriteList.json"
    }
    
    func getData(urlEnum:URLString ,completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) {
        let request = URLRequest(url: URL(string: urlEnum.rawValue)!)
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            completionHandler(data, response, err)
        }
        task.resume()
    }
    
    func getImage(with url:String) -> UIImage? {
        var adImage: UIImage?
        let request = URLRequest(url: URL(string: url)!)
        let dispatchGroup = DispatchGroup()
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            if let data = data,
               let image = UIImage(data: data) {
                adImage = image
            }
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        task.resume()
        dispatchGroup.wait()
        return adImage
    }
    
    
}
