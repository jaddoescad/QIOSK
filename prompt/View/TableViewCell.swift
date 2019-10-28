//
//  TableViewCell.swift
//  HeaderExample
//
//  Created by Jad Slim on 2019-10-17.
//  Copyright © 2019 Martin Rechsteiner. All rights reserved.
//
import UIKit

class CustomTableViewCell: UITableViewCell {

    var profileImageView: UIImageView = {
           let img = UIImageView()
           img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
           img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
           img.clipsToBounds = true
           img.layer.cornerRadius = 10

          return img
    }()
    
    var nameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor(rgb:0x365E7A)
    label.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
    } ()
    
    let TitleDetailedLabel:UITextView = {
      let label = UITextView()
          label.textColor = UIColor(rgb:0x365E7A)
      label.font = UIFont(name: "AvenirNext", size: 14)
        label.textContainer.lineFragmentPadding = 0
        label.textContainerInset = .zero
        label.backgroundColor = .white
        label.isEditable = false
//      label.layer.cornerRadius = 5
//      label.clipsToBounds = true
//        label.backgroundColor = .red
      label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    var price: UILabel = {
    let label = UILabel()
        label.textColor = UIColor(rgb:0x365E7A)
    label.font = UIFont(name: "AvenirNext-DemiBold", size: 15)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
    } ()
    let containerView:UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .white
    view.clipsToBounds = true // this will make sure its children do not go out of the boundary
    return view
    }()
    
    let countryImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // without this your image will shrink and looks ugly
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 13
        img.clipsToBounds = true
        return img
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(profileImageView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(TitleDetailedLabel)
        self.contentView.addSubview(containerView)
        self.contentView.addSubview(countryImageView)
        self.contentView.addSubview(price)

        profileImageView.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant:40).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo:self.contentView.centerXAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalTo:self.contentView.widthAnchor, constant:-40).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant:200).isActive = true
       

        nameLabel.topAnchor.constraint(equalTo:self.profileImageView.bottomAnchor, constant:20).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo:self.profileImageView.leadingAnchor).isActive = true

        TitleDetailedLabel.topAnchor.constraint(equalTo:self.nameLabel.bottomAnchor, constant: 8).isActive = true
        TitleDetailedLabel.leadingAnchor.constraint(equalTo:self.nameLabel.leadingAnchor).isActive = true
        TitleDetailedLabel.widthAnchor.constraint(equalTo:self.contentView.widthAnchor, constant:-20).isActive = true
        TitleDetailedLabel.sizeToFit()
        TitleDetailedLabel.isScrollEnabled = false
        
        price.topAnchor.constraint(equalTo:self.TitleDetailedLabel.bottomAnchor, constant:8).isActive = true
        price.leadingAnchor.constraint(equalTo:self.TitleDetailedLabel.leadingAnchor).isActive = true
        price.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor, constant: -15).isActive = true

     }
     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
}
