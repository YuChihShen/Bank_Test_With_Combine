//
//  ADViewController.swift
//  BankTest
//
//  Created by Yu-Chih Shen on 2024/5/26.
//

import UIKit

class ADViewController: UIViewController {
    
    let imageView = UIImageView()
    var banner: BannerInfo?
    {
        didSet {
            DispatchQueue.global().async {
                if let imageURL = self.banner?.linkURL,
                   let image = APIController().getImage(with: imageURL) {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaultView = UIView()
        self.view.addSubview(defaultView)
        defaultView.translatesAutoresizingMaskIntoConstraints = false
        defaultView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
        defaultView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24).isActive = true
        defaultView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        defaultView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        defaultView.clipsToBounds = true
        defaultView.layer.cornerRadius = 5
        defaultView.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1)
        
        let adLabelBackGroung = UIView()
        defaultView.addSubview(adLabelBackGroung)
        adLabelBackGroung.translatesAutoresizingMaskIntoConstraints = false
        adLabelBackGroung.heightAnchor.constraint(equalToConstant: 24).isActive = true
        adLabelBackGroung.widthAnchor.constraint(equalToConstant: 48).isActive = true
        adLabelBackGroung.centerXAnchor.constraint(equalTo: defaultView.centerXAnchor).isActive = true
        adLabelBackGroung.topAnchor.constraint(equalTo: defaultView.topAnchor, constant: 31).isActive = true
        
        adLabelBackGroung.clipsToBounds = true
        adLabelBackGroung.layer.cornerRadius = 6
        
        let adLabel = UILabel()
        adLabelBackGroung.addSubview(adLabel)
        adLabel.translatesAutoresizingMaskIntoConstraints = false
        adLabel.leadingAnchor.constraint(equalTo: adLabelBackGroung.leadingAnchor).isActive = true
        adLabel.trailingAnchor.constraint(equalTo: adLabelBackGroung.trailingAnchor).isActive = true
        adLabel.topAnchor.constraint(equalTo: adLabelBackGroung.topAnchor).isActive = true
        adLabel.bottomAnchor.constraint(equalTo: adLabelBackGroung.bottomAnchor).isActive = true
        
        adLabel.text = "AD"
        adLabel.textAlignment = .center
        adLabel.textColor = .white
        adLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        
        self.view.addSubview(self.imageView)
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.leadingAnchor.constraint(equalTo: defaultView.leadingAnchor).isActive = true
        self.imageView.trailingAnchor.constraint(equalTo: defaultView.trailingAnchor).isActive = true
        self.imageView.topAnchor.constraint(equalTo: defaultView.topAnchor).isActive = true
        self.imageView.bottomAnchor.constraint(equalTo: defaultView.bottomAnchor).isActive = true
    }

}
