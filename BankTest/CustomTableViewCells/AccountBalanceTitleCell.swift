//
//  AccountBalanceTitleCell.swift
//  BankTest
//
//  Created by Yu-Chih Shen on 2024/5/25.
//

import UIKit
import Combine

class AccountBalanceTitleCell: UITableViewCell {
    static let reuseID = "\(AccountBalanceTitleCell.self)"

    @IBOutlet weak var hideBalanceIcon: UIImageView!
    @IBOutlet weak var hideBalanceButton: UIButton!
    
    private var cancellables: [AnyCancellable] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.hideBalanceButton.addTarget(self, action: #selector(didClickHideBalanceButton), for: .touchUpInside)
        
        cancellables.append(HomePageViewModel.sharedInstance.$shouldHideBalance
            .sink { shouldHideBalance in
                self.hideBalanceIcon.image = shouldHideBalance ? UIImage(named: "eye_off") : UIImage(named: "eye_on")
            })
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func didClickHideBalanceButton() {
        HomePageViewModel.sharedInstance.shouldHideBalance.toggle()
    }
    
}
