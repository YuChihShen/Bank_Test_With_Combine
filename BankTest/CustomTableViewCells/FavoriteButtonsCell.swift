//
//  FavoriteButtonsCell.swift
//  BankTest
//
//  Created by Yu-Chih Shen on 2024/5/26.
//

import UIKit
import Combine

class FavoriteButtonsCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    static let reuseID = "\(FavoriteButtonsCell.self)"
    let favoriteItemReuseID = "FavoriteItem"
    private var cancellables: [AnyCancellable] = []

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "\(FavoriteItemCell.self)", bundle: nil), forCellWithReuseIdentifier: self.favoriteItemReuseID)
        
        cancellables.append(HomePageViewModel.sharedInstance.$favoriteList
            .sink { favoriteList in
                DispatchQueue.main.async {
                    self.collectionView.isHidden = !(favoriteList.count > 0)
                    self.collectionView.reloadData()
                }
            })
        
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HomePageViewModel.sharedInstance.favoriteList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.favoriteItemReuseID, for: indexPath) as! FavoriteItemCell
        let item = HomePageViewModel.sharedInstance.favoriteList[indexPath.item]
        cell.imageView.image = item.transType.image
        cell.title.text = item.nickname
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
}
