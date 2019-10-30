//
//  MenuModel.swift
//  prompt
//
//  Created by Jad Slim on 2019-10-29.
//  Copyright © 2019 Jad Slim. All rights reserved.
//

import Foundation
import UIKit

protocol MenuModelDelegate: class {
    func didReceiveMenu(data: [MenuItem])
}

class MenuModel {
    weak var delegate: MenuModelDelegate?

    let items = [
    [
      "title": "Cake",
      "headers": [
      "Spicy Latte",
      "Spicy Latte",
      "Spicy Latte",
      "Spicy Latte",
      ],

      "images": [
        UIImage(named: "green-1")!,
        UIImage(named: "green-2")!,
        UIImage(named: "green-3")!,
        UIImage(named: "green-4")!,
      ]
      ],
    [
      "title": "Sweets",
      "headers": [
      "Spicy Latte",
      "Spicy Latte",
      "Spicy Latte",
      "Spicy Latte",
      ],

      "images": [
        UIImage(named: "green-1")!,
        UIImage(named: "green-2")!,
        UIImage(named: "green-3")!,
        UIImage(named: "green-4")!,
      ]],
[
    "title": "Dessert",
      "headers": [
      "Spicy Latte",
      "Spicy Latte",
      "Spicy Latte",
      "Spicy Latte",
      ],

      "images": [
        UIImage(named: "green-1")!,
        UIImage(named: "green-1")!,
        UIImage(named: "green-1")!,
        UIImage(named: "green-1")!,
      ]],
    ]
    
    func setDataWithResponse() {
        var MenuItem_ = [MenuItem]()
        for item in items {
            if let menuItem = MenuItem(title: item["title"] as? String, headers: item["headers"] as? [String], images: item["images"] as? [UIImage]) {
                MenuItem_.append(menuItem)
            }
        }
        delegate?.didReceiveMenu(data: MenuItem_)
    }
}



//
//  MenuModel.swift
//  prompt
//
//  Created by Jad Slim on 2019-10-29.
//  Copyright © 2019 Jad Slim. All rights reserved.
//

//import Foundation
//import UIKit

//protocol DRHTableViewDataModelDelegate: class {
//    func didRecieveDataUpdate(data: [DRHTableViewDataModelItem])
//    func didFailDataUpdateWithError(error: Error)
//}

//struct MenuModel {

//    weak var delegate: DRHTableViewDataModelDelegate?
//
//    func requestData() {
//
//        //  this two variables will be returned from either an API call or local JSON file. For tutorial purposes, I create them here and initialise with nil.
//        let data: [AnyObject]? = nil
//        let error: Error? = nil
//
//        if let error = error {
//            delegate?.didFailDataUpdateWithError(error: error)
//        } else if let data = data {
//            setDataWithResponse(response: data)
//        }
//    }
    
//    private func handleError(error: Error) {
//
//    }
    
//    private func setDataWithResponse(response: [AnyObject]) {
//        var data = [DRHTableViewDataModelItem]()
//        for item in response {
//            if let drhTableViewDataModelItem = DRHTableViewDataModelItem(data: item as? [String: String]) {
//                data.append(drhTableViewDataModelItem)
//            }
//        }
//        delegate?.didRecieveDataUpdate(data: data)
//    }
    
//}
