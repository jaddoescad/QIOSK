//
//  ItemViewController.swift
//  prompt
//
//  Created by Jad Slim on 2019-10-21.
//  Copyright © 2019 Jad Slim. All rights reserved.
//

import UIKit
import MXParallaxHeader
import SwiftyJSON


class ItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    
    var offsetDenominator:CGFloat!
    var navAlpha = CGFloat()
    
    var radioButtonIndexPath = [Int:IndexPath]() //for radiobutton
    var checkboxIndexPath = [IndexPath]() //for checkbox

    @IBOutlet weak var totalSelectionPriceLabel: UILabel!
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var ItemView: ItemView!
    let basePrice = CGFloat()
    var totalPrice: CGFloat?
    var sections = [ItemSection]()
    @IBOutlet weak var AddToCartButton: UIButton!
    var order = [IndexPath]()
    
    let customView = Bundle.main.loadNibNamed("\(CustomTableHeaderView.self)", owner: nil, options: nil)!.first as! CustomTableHeaderView
    
    let Selections2 =
        
        [["Choice of Toppings": ["required":true, "type": "many", "num_choices": 2, "selection": ["1": ["title": "Margarita", "price": 3.75], "2": ["title" : "BBQ Chicken", "price": 2.76], "3":["title": "Pepperoni"]]]],
        
         ["Flavour" :["required":true, "type": "single","selection": ["1": ["title": "Margarita", "price": 1.76], "2": ["title" : "BBQ Chicken"], "3":["title":"Pepperoni", "price": 2.56]]]],
        
         ["Flavour" :["required":true, "type": "single", "selection": ["1": ["title": "Margarita"], "2": ["title" : "BBQ Chicken"], "3":["title":"Pepperoni", "price" : 3.24]]]]]
    

    func didselectRadioButtonLogic(indexPath: IndexPath) {
        radioButtonIndexPath[indexPath.section] = indexPath
    }


    
    func didselectCheckBoxLogic(indexPath: IndexPath) {
        let count = checkboxIndexPath.filter({ $0[0] == indexPath.section }).count
        if checkboxIndexPath.contains(indexPath) {
            if let checkboxIndex = checkboxIndexPath.firstIndex(of: indexPath) {
                checkboxIndexPath.remove(at:checkboxIndex )
            }
        }else{
            if let section_max = Array(Selections2[indexPath.section].values)[0]["num_choices"] as? Int {
                if !(count >= section_max) {
                    checkboxIndexPath.append(indexPath)
                }
                
            }
        }
    }

    func RadioButtonLogic(RadioCell: ItemTableViewCell, indexPath: IndexPath, itemName: String, price: Float) -> ItemTableViewCell {
        let SelectedCircle = UIImage(named: "RadioNotEmpty")
        let DeSelectedCircle = UIImage(named: "RadioEmpty")
        
        RadioCell.itemLabel.text = itemName
        updateRadioCellPrice(cell: RadioCell, cellPrice: price)
        
        if radioButtonIndexPath.keys.contains(indexPath.section) {
            if radioButtonIndexPath[indexPath.section] == indexPath {
                RadioCell.radioButton.setImage(SelectedCircle, for: .normal)
            }else{
                RadioCell.radioButton.setImage(DeSelectedCircle, for: .normal)
            }
        }else{
            RadioCell.radioButton.setImage(DeSelectedCircle, for: .normal)
        }
        return RadioCell
    }
    func CheckBoxLogic(BoxCell: ManyItemTableViewCell, itemName: String, indexPath: IndexPath, cellPrice: Float) -> ManyItemTableViewCell {
        let selectedSquare = UIImage(named: "Select")
        let DeSelectedSquare = UIImage(named: "Deselect")
        BoxCell.itemLabel.text = itemName
        updateBoxCellPrice(cell: BoxCell, cellPrice: cellPrice)
        if checkboxIndexPath.contains(indexPath) {
            BoxCell.radioButton.setImage(selectedSquare, for: .normal)
        }else{
            BoxCell.radioButton.setImage(DeSelectedSquare, for: .normal)
        }
        return BoxCell
    }
    
    func updateBoxCellPrice(cell: ManyItemTableViewCell, cellPrice: Float) {
        if cellPrice.isZero {
            cell.cellPrice.isHidden = true
        } else {
            cell.cellPrice.text = "+$\(cellPrice)"
            cell.cellPrice.isHidden = false
        }
    }
    
    func updateRadioCellPrice(cell: ItemTableViewCell, cellPrice: Float) {
        if cellPrice.isZero {
            cell.cellPrice.isHidden = true
        } else {
            cell.cellPrice.text = "+$\(cellPrice)"
        }
    }
}

extension ItemViewController {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tableHeader = ItemTableHeaderView()
        tableHeader.sectionHeaderLabel.text = Array(self.Selections2[section].keys)[0]
        return tableHeader
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let RadioCell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell") as! ItemTableViewCell
        let BoxCell = tableView.dequeueReusableCell(withIdentifier: "ManyItemTableViewCell") as! ManyItemTableViewCell
        
        let section = sections[indexPath.section]
        let cell = section.selections?[indexPath.row]
        
        
        switch section.type {
        case let val where val == "many":
            return self.CheckBoxLogic(BoxCell: BoxCell, itemName: cell?.title ?? "no title" , indexPath: indexPath, cellPrice: cell?.price ?? 0.0)
        case let val where val == "single":
            return self.RadioButtonLogic(RadioCell: RadioCell, indexPath: indexPath, itemName: cell?.title ?? "no title", price: cell?.price ?? 0.0)
        default:
            print("Invalid choose")
            return BoxCell
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.Selections2.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (Array(self.Selections2[section].values)[0]["selection"] as? [String: Any])?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if sections[indexPath.section].type == "many" {
            self.didselectCheckBoxLogic(indexPath: indexPath)
            self.tableView.reloadRows(at: [indexPath], with: .none)
            
        } else if sections[indexPath.section].type == "single"  {
            didselectRadioButtonLogic(indexPath: indexPath)
                self.tableView.reloadSections([indexPath.section], with: .none)
            
        }
        self.updateOrderArray()
        self.configureAddToCartButton()
    }
        func updateOrderArray() {
            self.order = checkboxIndexPath+Array(radioButtonIndexPath.values)
            print(self.order)
        }

    func configureAddToCartButton() {
        if checkboxIndexPath.isEmpty && radioButtonIndexPath.isEmpty {
            self.EnableAddtoCartButton(state: false)
            return
        }
        for i in 0..<sections.count {
            if sections[i].required == true {
                print("hello")
                //check type
                if !order.contains(where: { $0[0] == sections[i].sectionIndex }) {
                    self.EnableAddtoCartButton(state: false)
                    return
                }
                    
        }
        self.EnableAddtoCartButton(state: true)
    }
}

}
