//
//  CustomTableHeaderView.swift
//  TableHeaderViewWithAutoLayout
//
//  Created by Wirawit Rueopas on 6/6/2560 BE.
//  Copyright © 2560 Wirawit Rueopas. All rights reserved.
//

import UIKit

class CustomTableHeaderView: UIView {

}

class ItemView: UIView {
        let NavView = UIView()
        let BackButton = UIButton()
    //    func setupWithSuperView(superView: UIView) {
    //        createNavBar(superView: superView)
    //     }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
        }
        
        func commonInit() {
            createNavBar()
        }
        
        func createNavBar() {
            self.addSubview(NavView)
            NavView.backgroundColor = UIColor(rgb: 0x365E7A)
            NavView.translatesAutoresizingMaskIntoConstraints = false
            NavView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            NavView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            NavView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive  = true
            NavView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive  = true
            NavView.heightAnchor.constraint(equalToConstant: 64).isActive = true
            
            addBackButton()
        }
    //    @IBOutlet weak var label: UILabel!
    //    @IBOutlet weak var imageView: UIImageView!
        func addBackButton() {
            NavView.addSubview(BackButton)
            BackButton.translatesAutoresizingMaskIntoConstraints = false

            BackButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
            BackButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
            BackButton.imageView?.contentMode = .scaleAspectFit

            BackButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: -40, bottom: 10, right: 20)

            BackButton.bottomAnchor.constraint(equalTo: NavView.bottomAnchor, constant: 0).isActive = true
            BackButton.leftAnchor.constraint(equalTo: NavView.leftAnchor).isActive  = true
            BackButton.setImage(UIImage(named: "Back"), for: .normal)
            BackButton.semanticContentAttribute = .forceLeftToRight


        }
}
