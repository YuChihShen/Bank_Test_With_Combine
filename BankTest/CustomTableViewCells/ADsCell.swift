//
//  ADsCell.swift
//  BankTest
//
//  Created by Yu-Chih Shen on 2024/5/26.
//

import UIKit
import Combine

class ADsCell: UITableViewCell, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    static let reuseID = "\(ADsCell.self)"
    
    @IBOutlet weak var DefaultADView: UIView!
    @IBOutlet weak var PageControl: UIPageControl!
    
    private let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    private var cancellables: [AnyCancellable] = []
    private var bannerVCs: [UIViewController] = []
    private var turnPageTimer : Timer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.DefaultADView.clipsToBounds = true
        self.DefaultADView.layer.cornerRadius = 12
        self.setPageViewController()
        self.PageControl.isUserInteractionEnabled = false
        
        cancellables.append(HomePageViewModel.sharedInstance.$bannerList
            .sink { bannerList in
                if (bannerList.count > 0) {
                    self.addADs(bannerList: bannerList)
                    DispatchQueue.main.async {
                        self.DefaultADView.isHidden = true
                    }
                }
            })
    }
    
    deinit {
        self.clearTimer()
    }
    
    func clearTimer() {
        self.turnPageTimer?.invalidate()
        self.turnPageTimer = nil
    }
    
    func resetTurnPageTimer() {
        self.clearTimer()
        if self.bannerVCs.count > 1 {
            self.turnPageTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(turnPage), userInfo: nil, repeats: true)
        }
    }
    
    @objc func turnPage() {
        if let nextVC = self.viewControllerAtPage(page: self.PageControl.currentPage + 1) {
            self.pageVC.setViewControllers([nextVC], direction: .forward, animated: true)
            self.setCurrentPage()
        }
    }
    
    func setPageViewController() {
        self.addSubview(self.pageVC.view)
        self.pageVC.view.translatesAutoresizingMaskIntoConstraints = false
        self.pageVC.view.topAnchor.constraint(equalTo: self.DefaultADView.topAnchor).isActive = true
        self.pageVC.view.bottomAnchor.constraint(equalTo: self.DefaultADView.bottomAnchor).isActive = true
        self.pageVC.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.pageVC.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.pageVC.view.isHidden = true
        
        self.pageVC.delegate = self
        self.pageVC.dataSource = self
    }
    
    func addADs(bannerList: [BannerInfo]) {
        DispatchQueue.main.async {
            self.bannerVCs.removeAll()
            self.PageControl.numberOfPages = 0
            for banner in bannerList {
                let adVC = ADViewController()
                adVC.banner = banner
                self.bannerVCs.append(adVC)
            }
            
            if (self.bannerVCs.count > 0) {
                self.PageControl.numberOfPages = self.bannerVCs.count
                self.pageVC.view.isHidden = false
                self.turnToMainPage()
                self.resetTurnPageTimer()
            }
        }
    }
    
    func turnToMainPage() {
        guard self.bannerVCs.count > 0 else {return}
        self.PageControl.currentPage = 0
        self.pageVC.setViewControllers([self.bannerVCs.first!], direction: .forward, animated: false)
    }
    
    func setCurrentPage() {
        if let vc = self.pageVC.viewControllers?.first {
            self.PageControl.currentPage = self.bannerVCs.firstIndex(of: vc)!
        }
    }
    
    func viewControllerAtPage(page: Int) -> UIViewController? {
        if page >= self.bannerVCs.count {
            return self.bannerVCs.first
        } else if page < 0 {
            return self.bannerVCs.last
        } else {
            return self.bannerVCs[page]
        }
    }
    
    // MARK: - UIPageViewControllerDelegate
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        self.setCurrentPage()
        self.resetTurnPageTimer()
    }
    
    // MARK: - UIPageViewControllerDataSource
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return self.viewControllerAtPage(page: self.PageControl.currentPage - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return self.viewControllerAtPage(page: self.PageControl.currentPage + 1)
    }
}
