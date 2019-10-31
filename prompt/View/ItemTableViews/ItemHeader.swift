//
//  ItemHeader.swift
//  prompt
//
//  Created by Jad Slim on 2019-10-29.
//  Copyright © 2019 Jad Slim. All rights reserved.
//

import Foundation
import UIKit


class ItemTableHeaderView: UIView {
    let sectionHeaderLabel = UILabel()
    let sectionConditionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSectionHeaderView()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

     func addSectionHeaderView() {
            self.backgroundColor = UIColor(rgb: 0xD5DDE3)

            sectionHeaderLabel.textColor = UIColor(rgb: 0x365E7A)
            sectionConditionLabel.textColor = UIColor(rgb: 0x365E7A).withAlphaComponent(0.6)
            sectionHeaderLabel.font = UIFont(name: "AvenirNext-Medium", size: 18)
            sectionConditionLabel.font = UIFont(name: "AvenirNext-Medium", size: 13)

    //           newlabel.adjustsFontSizeToFitWidth = true
    
            self.addSubview(sectionHeaderLabel)
            self.addSubview(sectionConditionLabel)

            sectionHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
            sectionConditionLabel.translatesAutoresizingMaskIntoConstraints = false

            sectionHeaderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
            sectionHeaderLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true

            sectionConditionLabel.topAnchor.constraint(equalTo: sectionHeaderLabel.bottomAnchor, constant: 0).isActive = true
            sectionConditionLabel.leftAnchor.constraint(equalTo: sectionHeaderLabel.leftAnchor, constant: 0).isActive = true
        
    }
    
}
