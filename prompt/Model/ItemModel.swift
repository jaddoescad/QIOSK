//
//  ItemModel.swift
//  prompt
//
//  Created by Jad Slim on 2019-10-29.
//  Copyright © 2019 Jad Slim. All rights reserved.
//

import Foundation
import Parchment




class MenuItem: PagingItem {
  let headers: [String]?
  let images: [UIImage]?
  let title: String?
    
    init?(title: String?, headers: [String]?, images: [UIImage]?) {
        self.title = title
        self.headers = headers
        self.images = images
    } 
}



//struct Menu {
//    var MenuSection: String?
//    var FoodItems: [FoodItem]
//}
//
//struct FoodItem {
//    let ItemTitle: String?
//    let ItemDescription: Float?
//    let ItemPrice: Float?
//    let ItemSections: [SelectionSection]
//}
//
//struct SelectionSection {
//    let SectionTitle: String?
//    let SectionCondition: String?
//    let SectionMax: Float?
//    let Required: Bool?
//    let Selections: [Selection]
//}
//
//struct Selection {
//    let SelectionTitle: String?
//    let SelectionPrice: Float?
//}
