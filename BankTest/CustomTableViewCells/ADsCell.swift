//
//  ADsCell.swift
//  BankTest
//
//  Created by Yu-Chih Shen on 2024/5/26.
//

import UIKit

class ADsCell: UITableViewCell {
    static let reuseID = "\(ADsCell.self)"
    
    @IBOutlet weak var ADView: UIView!
    @IBOutlet weak var PageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.ADView.clipsToBounds = true
        self.ADView.layer.cornerRadius = 12
//        self.addPageViewController()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func addPageViewController() {
        let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        self.addSubview(pageVC.view)
        pageVC.view.translatesAutoresizingMaskIntoConstraints = false
        pageVC.view.topAnchor.constraint(equalTo: self.ADView.topAnchor).isActive = true
        pageVC.view.bottomAnchor.constraint(equalTo: self.ADView.bottomAnchor).isActive = true
        pageVC.view.leadingAnchor.constraint(equalTo: self.ADView.leadingAnchor).isActive = true
        pageVC.view.trailingAnchor.constraint(equalTo: self.ADView.trailingAnchor).isActive = true
        pageVC.view.backgroundColor = .orange
    }
    
    func addADs() {
        
    }
    
}
