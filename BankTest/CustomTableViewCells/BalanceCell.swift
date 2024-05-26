//
//  BalanceCell.swift
//  BankTest
//
//  Created by Yu-Chih Shen on 2024/5/25.
//

import UIKit

class BalanceCell: UITableViewCell {
    static let reuseID = "\(BalanceCell.self)"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var loadingMaskView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(title:String, balance:Float, isLoading:Bool) {
        self.titleLabel.text = title
        self.balanceLabel.text = "\(balance)"
    }
    
}
