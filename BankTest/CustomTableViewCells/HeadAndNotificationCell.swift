//
//  HeadAndNotificationCell.swift
//  BankTest
//
//  Created by Yu-Chih Shen on 2024/5/25.
//

import UIKit
import Combine

class HeadAndNotificationCell: UITableViewCell {
    static let reuseID = "\(HeadAndNotificationCell.self)"

    @IBOutlet weak var bellImageView: UIImageView!
    @IBOutlet weak var bellButton: UIButton!
    
    private var cancellables: [AnyCancellable] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cancellables.append(HomePageViewModel.sharedInstance.$notificationList
            .sink { notificationList in
                DispatchQueue.main.async {
                    self.bellImageView.image = (notificationList.count > 0) ? UIImage(named: "NotificationBell_RedDot") : UIImage(named: "NotificationBell")
                }
            })
    }
    
    
}
