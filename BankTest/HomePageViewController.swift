//
//  ViewController.swift
//  BankTest
//
//  Created by Yu-Chih Shen on 2024/5/25.
//

import UIKit
import Foundation

class HomePageViewController: UITableViewController{
    
    enum sectionType: Int {
        case HeadAndNotification
        case AccountBalanceTitle
        case USDBalance
        case KHRBalance
        case FunctionButtons
        case FavoriteButtonsTitle
        case FavoriteButtons
        case ADs
        case SpaceForFloatingTabBar
        case End
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.backgroundView?.backgroundColor = .clear
        self.tableView.register(UINib(nibName: "\(HeadAndNotificationCell.self)", bundle: nil), forCellReuseIdentifier: "\(HeadAndNotificationCell.self)")
        self.tableView.register(UINib(nibName: "\(AccountBalanceTitleCell.self)", bundle: nil), forCellReuseIdentifier: "\(AccountBalanceTitleCell.self)")
        self.tableView.register(UINib(nibName: "\(BalanceCell.self)", bundle: nil), forCellReuseIdentifier: "\(BalanceCell.self)")
        self.tableView.register(UINib(nibName: "\(FunctionButtonsCell.self)", bundle: nil), forCellReuseIdentifier: "\(FunctionButtonsCell.self)")
        self.tableView.register(UINib(nibName: "\(FavoriteButtonsTitleCell.self)", bundle: nil), forCellReuseIdentifier: "\(FavoriteButtonsTitleCell.self)")
        self.tableView.register(UINib(nibName: "\(FavoriteButtonsCell.self)", bundle: nil), forCellReuseIdentifier: "\(FavoriteButtonsCell.self)")
        self.tableView.register(UINib(nibName: "\(ADsCell.self)", bundle: nil), forCellReuseIdentifier: "\(ADsCell.self)")
        
        HomePageViewModel.sharedInstance.getFirstEnterData()
    }
    
    // MARK: - UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionType.End.rawValue;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sectionType(rawValue: section) {
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (sectionType(rawValue: indexPath.section) == .SpaceForFloatingTabBar) {
            return 100
        }
        else {
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch sectionType(rawValue: indexPath.section) {
        case .HeadAndNotification:
            cell = tableView.dequeueReusableCell(withIdentifier: HeadAndNotificationCell.reuseID, for: indexPath) as! HeadAndNotificationCell
            break
            
        case .AccountBalanceTitle:
            cell = tableView.dequeueReusableCell(withIdentifier: AccountBalanceTitleCell.reuseID, for: indexPath) as! AccountBalanceTitleCell
            break
            
        case .USDBalance:
            cell = tableView.dequeueReusableCell(withIdentifier: BalanceCell.reuseID, for: indexPath) as! BalanceCell
            if let cell = cell as? BalanceCell {
                cell.amountType = .USD
            }
            break
            
        case .KHRBalance:
            cell = tableView.dequeueReusableCell(withIdentifier: BalanceCell.reuseID, for: indexPath) as! BalanceCell
            if let cell = cell as? BalanceCell {
                cell.amountType = .KHR
            }
            break
            
        case .FunctionButtons:
            cell = tableView.dequeueReusableCell(withIdentifier: FunctionButtonsCell.reuseID, for: indexPath) as! FunctionButtonsCell
            break
            
        case .FavoriteButtonsTitle:
            cell = tableView.dequeueReusableCell(withIdentifier: FavoriteButtonsTitleCell.reuseID, for: indexPath) as! FavoriteButtonsTitleCell
            break
            
        case .FavoriteButtons:
            cell = tableView.dequeueReusableCell(withIdentifier: FavoriteButtonsCell.reuseID, for: indexPath) as! FavoriteButtonsCell
            break
            
        case .ADs:
            cell = tableView.dequeueReusableCell(withIdentifier: ADsCell.reuseID, for: indexPath) as! ADsCell
            break
            
        default:
            ()
        }
        
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        return cell
    }
}

