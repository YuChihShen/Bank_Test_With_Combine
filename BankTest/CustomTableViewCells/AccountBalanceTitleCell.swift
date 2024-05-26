//
//  AccountBalanceTitleCell.swift
//  BankTest
//
//  Created by Yu-Chih Shen on 2024/5/25.
//

import UIKit

class AccountBalanceTitleCell: UITableViewCell {
    static let reuseID = "\(AccountBalanceTitleCell.self)"

    @IBOutlet weak var hideBalanceIcon: UIImageView!
    @IBOutlet weak var hideBalanceButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.hideBalanceButton.setTitle(nil, for: .normal)
        self.hideBalanceButton.addTarget(self, action: #selector(didClickHideBalanceButton), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func didClickHideBalanceButton() {
        HomePageViewModel.sharedInstance.shouldHideBalance.toggle()
    }
    
}
