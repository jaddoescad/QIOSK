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
