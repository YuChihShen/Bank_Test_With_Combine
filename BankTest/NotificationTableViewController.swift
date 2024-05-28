//
//  NotificationTableViewController.swift
//  BankTest
//
//  Created by Yu-Chih Shen on 2024/5/26.
//

import UIKit
import Combine

class NotificationTableViewController: UITableViewController {
    
    private var cancellables: [AnyCancellable] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Notification"
        let backBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow_back"), style: .done, target: self, action: #selector(back))
        backBarButtonItem.tintColor = #colorLiteral(red: 0.265615046, green: 0.2592996955, blue: 0.2641559541, alpha: 1)
        self.navigationItem.leftBarButtonItem = backBarButtonItem
        
        
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.register(UINib(nibName: "\(NotificationCell.self)", bundle: nil), forCellReuseIdentifier: "\(NotificationCell.self)")
        
        cancellables.append(HomePageViewModel.sharedInstance.$notificationList
            .sink { notificationList in
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HomePageViewModel.sharedInstance.notificationList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationCell.reuseID, for: indexPath) as! NotificationCell
        let notification = HomePageViewModel.sharedInstance.notificationList[indexPath.row]
        cell.configure(notification: notification)
        return cell
    }

}
