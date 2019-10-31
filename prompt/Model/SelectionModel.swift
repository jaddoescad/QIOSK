//
//  SelectionModel.swift
//  prompt
//
//  Created by Jad Slim on 2019-10-30.
//  Copyright © 2019 Jad Slim. All rights reserved.
//

import Foundation
import UIKit

class ItemSections {
    let sections: [ItemSection]?
    
    init?(data: Any) {
        self.sections = ItemSections.setupSection(data: data)
    }
    
    class func setupSection(data: Any) -> [ItemSection]? {
        var itemSections = [ItemSection]()
        
        guard let selectionList = data as? [[String : [String : Any]]] else {
            return nil
        }
        
        //loop thru section
        for i in 0..<selectionList.count {
            itemSections.append(ItemSections.createItemSection(itemSection: selectionList[i], setionIndex: i))
        }
        return itemSections
    }
    
    class func createItemSection(itemSection: [String: Any], setionIndex: Int) -> ItemSection {
        let title = Array(itemSection.keys)[0]
        let values = Array(itemSection.values)[0] as? [String: Any]
        let type = values?["type"] as? String ?? "many"
        let max = values?["max"] as? Int
        let required = values?["required"] as? Bool ?? false
        let setionIndex = setionIndex
        let selectionArray = values?["selection"] as? [String: Any] ?? [:]
        let itemSelections = createItemSelection(selectionArray: selectionArray, sectionIndex: setionIndex)
        let Section = ItemSection(title: title, type: type, max: max, required: required, sectionIndex: setionIndex, selections: itemSelections)
        
        return Section 
    }
    
    
        
    class func createItemSelection(selectionArray: [String: Any], sectionIndex: Int) -> [ItemSelection] {
        
        var ItemSelections = [ItemSelection]()

        let sortedSelectionArray = selectionArray.sorted { $0.0 < $1.0 }
        
        for i in 0..<sortedSelectionArray.count {
        let selection = (sortedSelectionArray[i].value as? [String:Any])
        let title = selection?["title"] as? String
        let price = selection?["price"]
            
            
            let itemSelection_ = ItemSelection(index: i, section: sectionIndex, price: Float(truncating: price as? NSNumber ?? 0.0) , title: title ?? "Item")
        ItemSelections.append(itemSelection_)
        }
        
        
        return ItemSelections
    }
}


class ItemSection {
  let sectionIndex: Int
  let title: String?
  let type: String?
  let max: Int?
  let required: Bool?
  let selections: [ItemSelection]?

    init(title: String?, type: String?, max: Int?, required: Bool?, sectionIndex: Int, selections: [ItemSelection]?) {
        self.title = title
        self.type = type
        self.max = max
        self.required = required
        self.sectionIndex = sectionIndex
        self.selections = selections
    }
}



class ItemSelection  {
  let index: Int
  let price: Float?
  let title: String?
  let section: Int?

    init(index: Int, section: Int?,price: Float?, title: String?) {
        self.index = index
        self.price = price
        self.title = title
        self.section = section
    }
}
