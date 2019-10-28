//
//  HeaderView.swift
//  prompt
//
//  Created by Jad Slim on 2019-10-26.
//  Copyright © 2019 Jad Slim. All rights reserved.
//

//ProfileView.swift
import UIKit


class HeaderView: UIView {
    let newView = UIImageView()
    let coverView = UIView()
    let titlerestaurant = UILabel()
    let NavView = UIView()
    let BackButton = UIButton()
    let NavRestaurantTitle = UILabel()

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
        createHeader()
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
        NavView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        addBackButton()
        addTitle()
    }
    
    func addTitle() {
        NavView.addSubview(NavRestaurantTitle)
        NavRestaurantTitle.translatesAutoresizingMaskIntoConstraints = false
        NavRestaurantTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        NavRestaurantTitle.bottomAnchor.constraint(equalTo: NavView.bottomAnchor, constant: -10).isActive = true
        NavRestaurantTitle.font = UIFont(name: "Avenir Next", size: 18)
        NavRestaurantTitle.textColor = .white
    }
    
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
    func createHeader() {
        addSubview(newView)
        addSubview(coverView)
        addSubview(titlerestaurant)
        newView.translatesAutoresizingMaskIntoConstraints = false
        newView.contentMode = .scaleAspectFill
        coverView.translatesAutoresizingMaskIntoConstraints = false
        titlerestaurant.translatesAutoresizingMaskIntoConstraints = false
        
        titlerestaurant.font = UIFont(name: "Avenir Next-Demi Bold", size: 20)
        coverView.backgroundColor = .black
        coverView.alpha = 0.7
        
        NSLayoutConstraint(item: newView, attribute: NSLayoutConstraint.Attribute.top,
        relatedBy:NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: newView, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: newView, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: 0).isActive = true

        NSLayoutConstraint(item: newView, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 0).isActive = true

        NSLayoutConstraint(item: newView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0).isActive = true

        NSLayoutConstraint(item: coverView, attribute: NSLayoutConstraint.Attribute.top,
        relatedBy:NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: coverView, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: coverView, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: coverView, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: coverView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0).isActive = true

        NSLayoutConstraint(item: titlerestaurant, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: titlerestaurant, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0).isActive = true
    }
}

import UIKit

extension UITableView {
    
    /// Set table header view & add Auto layout.
    func setTableHeaderView(headerView: UIView) {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        // Set first.
        self.tableHeaderView = headerView
        // Then setup AutoLayout.
        headerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        headerView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    
    /// Update header view's frame.
    func updateHeaderViewFrame() {
        guard let headerView = self.tableHeaderView else { return }
        // Update the size of the header based on its internal content.
        headerView.layoutIfNeeded()
        // ***Trigger table view to know that header should be updated.
        let header = self.tableHeaderView
        self.tableHeaderView = header
    }
}
