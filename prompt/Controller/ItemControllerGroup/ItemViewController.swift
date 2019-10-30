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
    
    @IBOutlet weak var AddToCartButton: UIButton!
    
    var offsetDenominator:CGFloat!
    var navAlpha = CGFloat()
    var radioButtonIndexPath = [Int:IndexPath]() //for radiobutton
    var checkboxIndexPath = [IndexPath]() //for checkbox
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var ItemView: ItemView!
    let basePrice = CGFloat()
    var totalPrice: CGFloat?
    var sections = [ItemSection]()
    
    @IBOutlet weak var ItemCartButton: UIButton!
    let newView = UIImageView()
    let customView = Bundle.main.loadNibNamed("\(CustomTableHeaderView.self)", owner: nil, options: nil)!.first as! CustomTableHeaderView
    
    let Selections2 =
        
        [["Choice of Toppings": ["type": "many", "num_choices": 2, "selection": ["1": ["title": "Margarita"], "2": ["title" : "BBQ Chicken"], "3":["title": "Pepperoni"]]]],
        
         ["Flavour" :["type": "single","selection": ["1": ["title": "Margarita"], "2": ["title" : "BBQ Chicken"], "3":["title":"Pepperoni"]]]],
        
        ["Flavour" :["type": "single", "selection": ["1": ["title": "Margarita"], "2": ["title" : "BBQ Chicken"], "3":["title":"Pepperoni"]]]]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupItemViewController()
        self.sections = ItemSections(data: Selections2)?.sections ?? []
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
    
    func RadioButtonLogic(RadioCell: ItemTableViewCell, indexPath: IndexPath, itemName: String) -> ItemTableViewCell {
        let SelectedCircle = UIImage(named: "RadioNotEmpty")
        let DeSelectedCircle = UIImage(named: "RadioEmpty")
        
        RadioCell.itemLabel.text = itemName
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
    func CheckBoxLogic(BoxCell: ManyItemTableViewCell, itemName: String, indexPath: IndexPath) -> ManyItemTableViewCell {
        let selectedSquare = UIImage(named: "Select")
        let DeSelectedSquare = UIImage(named: "Deselect")
        BoxCell.itemLabel.text = itemName
        if checkboxIndexPath.contains(indexPath) {
            BoxCell.radioButton.setImage(selectedSquare, for: .normal)
        }else{
            BoxCell.radioButton.setImage(DeSelectedSquare, for: .normal)
        }
        return BoxCell
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
        
        switch sections[indexPath.section].type {
        case let val where val == "many":
            return self.CheckBoxLogic(BoxCell: BoxCell, itemName: sections[indexPath.section].selections?[indexPath.row].title ?? "no title" , indexPath: indexPath)
        case let val where val == "single":
            return self.RadioButtonLogic(RadioCell: RadioCell, indexPath: indexPath, itemName: sections[indexPath.section].selections?[indexPath.row].title ?? "no title")
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
        } else if sections[indexPath.section].type == "single"  {
            radioButtonIndexPath[indexPath.section] = indexPath
        }
        self.tableView.reloadData()
    }
}
