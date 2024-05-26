//
//  MainViewController.swift
//  BankTest
//
//  Created by Yu-Chih Shen on 2024/5/26.
//

import UIKit

class MainViewController: UIViewController {
    var currentPage = 0
    var floatingTabBar: UIView?
    var floatingTabBarY: CGFloat = 0

    @IBOutlet var tabBarButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubViewControllers()
        addFloatingTabBarView()
    }
    
    func addSubViewControllers() {
        let containerView = UIView()
        self.view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        containerView.backgroundColor = #colorLiteral(red: 0.980392158, green: 0.980392158, blue: 0.980392158, alpha: 1)
        
        let homeVC = HomePageViewController()
        self.addChild(homeVC)
        
        let accountVC = UIViewController()
        accountVC.view.backgroundColor = .green
        self.addChild(accountVC)
        
        let locationVC = UIViewController()
        locationVC.view.backgroundColor = .yellow
        self.addChild(locationVC)
        
        let serviceVC = UIViewController()
        serviceVC.view.backgroundColor = .brown
        self.addChild(serviceVC)
        
        self.children.forEach { viewController in
            containerView.addSubview(viewController.view)
            viewController.view.translatesAutoresizingMaskIntoConstraints = false
            viewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
            viewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
            viewController.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
            viewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
            
            viewController.view.backgroundColor = .clear
            viewController.view.isHidden = true
        }
        
        homeVC.view.isHidden = false
    }
    
    func addFloatingTabBarView() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "FloatingTabBarView", bundle: bundle)
        let xibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        self.view.addSubview(xibView)
        xibView.translatesAutoresizingMaskIntoConstraints = false
        xibView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        xibView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
        xibView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24).isActive = true
        xibView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -22).isActive = true
        
        xibView.clipsToBounds = true
        xibView.layer.cornerRadius = 26
        xibView.backgroundColor = #colorLiteral(red: 0.9999999404, green: 1, blue: 1, alpha: 1)
    }

}
