//
//  MenuView.swift
//  prompt
//
//  Created by Jad Slim on 2019-10-30.
//  Copyright © 2019 Jad Slim. All rights reserved.
//

import Foundation
import UIKit
import Parchment

class CustomPagingView: PagingView {

    let NavView = UIView()
    let BackButton = UIButton()
    let NavRestaurantTitle = UILabel()
    
  override func setupConstraints() {
    
    pageView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.translatesAutoresizingMaskIntoConstraints = false

    createNavBar()
    NSLayoutConstraint.activate([
      collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      collectionView.heightAnchor.constraint(equalToConstant: options.menuHeight),
      collectionView.topAnchor.constraint(equalTo: NavView.bottomAnchor),


      pageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      pageView.trailingAnchor.constraint(equalTo: trailingAnchor),
      pageView.bottomAnchor.constraint(equalTo: bottomAnchor),
      pageView.topAnchor.constraint(equalTo: NavView.bottomAnchor)
    ])
  }
    func createNavBar() {
         addSubview(NavView)
         NavView.backgroundColor = UIColor(rgb: 0x365E7A)
         NavView.translatesAutoresizingMaskIntoConstraints = false
         NavView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
         NavView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
         NavView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive  = true
         NavView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive  = true
         NavView.heightAnchor.constraint(equalToConstant: 64).isActive = true
     }
}

class NavView: UIView {
    let newView = UIImageView()
    let coverView = UIView()
    let titlerestaurant = UILabel()
    let NavView = UIView()
    let BackButton = UIButton()
    let NavRestaurantTitle = UILabel()
    var Cartbutton = UIButton()


    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createSubviews()
    }

    func createSubviews() {
        // all the layout code from above
        createNavBar()
    }
    
    func createNavBar() {
            addSubview(NavView)
            NavView.backgroundColor = UIColor(rgb: 0x365E7A)
            NavView.translatesAutoresizingMaskIntoConstraints = false
            NavView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            NavView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            NavView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive  = true
            NavView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive  = true
//            NavView.heightAnchor.constraint(equalToConstant: 64).isActive = true
            NavView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

            addBackButton()
            addTitle()
        }
        func addTitle() {
            NavView.addSubview(NavRestaurantTitle)
            NavRestaurantTitle.translatesAutoresizingMaskIntoConstraints = false
            NavRestaurantTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            NavRestaurantTitle.bottomAnchor.constraint(equalTo: NavView.bottomAnchor, constant: -10).isActive = true
            NavRestaurantTitle.font = UIFont(name: "AvenirNext-Medium", size: 17)
            NavRestaurantTitle.textColor = .white
        }
        
        func addBackButton() {
             NavView.addSubview(BackButton)
             BackButton.imageView?.contentMode = .scaleAspectFit
             BackButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: -40, bottom: 10, right: 20)
             BackButton.setImage(UIImage(named: "Back"), for: .normal)
             BackButton.translatesAutoresizingMaskIntoConstraints = false
             BackButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
             BackButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
             BackButton.bottomAnchor.constraint(equalTo: NavView.bottomAnchor, constant: 0).isActive = true
             BackButton.leftAnchor.constraint(equalTo: NavView.leftAnchor).isActive  = true
             BackButton.semanticContentAttribute = .forceLeftToRight

        }
    
    @objc func GoBack() {
        
    }
}
