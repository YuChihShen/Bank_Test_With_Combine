//
//  HomePageViewModel.swift
//  BankTest
//
//  Created by Yu-Chih Shen on 2024/5/25.
//

import UIKit

class HomePageViewModel: NSObject {
    static let sharedInstance = HomePageViewModel()
    
    var shouldHideBalance = false
    var isLoadingBalance = true

}
