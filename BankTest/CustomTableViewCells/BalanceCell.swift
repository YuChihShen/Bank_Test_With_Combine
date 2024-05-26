//
//  BalanceCell.swift
//  BankTest
//
//  Created by Yu-Chih Shen on 2024/5/25.
//

import UIKit
import Combine

class BalanceCell: UITableViewCell {
    enum AmountType: String {
        case USD = "USD"
        case KHR = "KHR"
    }
    
    static let reuseID = "\(BalanceCell.self)"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var loadingMaskView: UIView!
    
    private var cancellables: [AnyCancellable] = []
    var amountType: AmountType = .USD {
        didSet {
            self.titleLabel.text = amountType.rawValue
            
            switch amountType {
            case .USD:
                cancellables.append(HomePageViewModel.sharedInstance.$usdBalanceString
                    .sink { balanceString in
                        guard !HomePageViewModel.sharedInstance.shouldHideBalance else { return }
                        self.balanceLabel.text = balanceString
                    })
                break
                
            case .KHR:
                cancellables.append(HomePageViewModel.sharedInstance.$khrBalanceString
                    .sink { balanceString in
                        guard !HomePageViewModel.sharedInstance.shouldHideBalance else { return }
                        self.balanceLabel.text = balanceString
                    })
                break
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cancellables.append(HomePageViewModel.sharedInstance.$isLoadingBalance
            .sink { isLoadingBalance in
                self.loadingMaskView.isHidden = !isLoadingBalance
            })
        
        cancellables.append(HomePageViewModel.sharedInstance.$shouldHideBalance
            .sink { shouldHideBalance in
                self.balanceLabel.text = shouldHideBalance ? "********" : self.getBalance()
            })
        
    }
    
    func getBalance() -> String {
        switch self.amountType {
        case .USD:
            return HomePageViewModel.sharedInstance.usdBalanceString
            
        case .KHR:
            return HomePageViewModel.sharedInstance.khrBalanceString
        }
    }
    
}
