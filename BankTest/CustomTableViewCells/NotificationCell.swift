//
//  NotificationCell.swift
//  BankTest
//
//  Created by Yu-Chih Shen on 2024/5/26.
//

import UIKit

class NotificationCell: UITableViewCell {
    static let reuseID = "\(NotificationCell.self)"

    @IBOutlet weak var dotView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        title.text = nil
        dateLabel.text = nil
        contentLabel.text = nil
    }
    
    func configure(notification: Message) {
        dotView.isHidden = notification.status
        title.text = notification.title
        dateLabel.text = notification.updateDateTime
        contentLabel.text = notification.message
        
    }
    
}
