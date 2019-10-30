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
    
    @IBOutlet weak var ItemCartButton: UIButton!
    let newView = UIImageView()
        let customView = Bundle.main.loadNibNamed("\(CustomTableHeaderView.self)", owner: nil, options: nil)!.first as! CustomTableHeaderView
    let ItemSection = [["Choice of Toppings": ["type": "many", "num_choices": 1]], ["Flavour" :["type": "single"]], ["Flavour" :["type": "single"]]]

     
    let items = [["Margarita", "BBQ Chicken", "Pepperoni"], ["sausage", "meat lovers", "veggie lovers", "sausage", "meat lovers", "veggie lovers", "sausage", "meat lovers", "veggie lovers"], ["sausage", "meat lovers", "veggie lovers", "sausage", "meat lovers", "veggie lovers", "sausage", "meat lovers", "veggie lovers"]]
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Array(self.ItemSection[section].keys)[0]
        
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.ItemSection.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].count
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if Array(ItemSection[indexPath.section].values)[0]["type"] as? String == "many" {
            let count = checkboxIndexPath.filter({ $0[0] == indexPath.section }).count
                      if checkboxIndexPath.contains(indexPath) {
                         if let checkboxIndex = checkboxIndexPath.firstIndex(of: indexPath) {
                         checkboxIndexPath.remove(at:checkboxIndex )
                         }
                      }else{
                        if let section_max = Array(ItemSection[indexPath.section].values)[0]["num_choices"] as? Int {
                            if !(count >= section_max) {
                             checkboxIndexPath.append(indexPath)
                            }
                            
                        }
                         }
        } else if Array(ItemSection[indexPath.section].values)[0]["type"] as? String == "single"  {

                       radioButtonIndexPath[indexPath.section] = indexPath
                   }
        self.tableView.reloadData() // reload your tableview here
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let RadioCell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell") as! ItemTableViewCell

        let BoxCell = tableView.dequeueReusableCell(withIdentifier: "ManyItemTableViewCell") as! ManyItemTableViewCell
        
        let item = items[indexPath.section][indexPath.row]
        
        
        switch Array(ItemSection[indexPath.section].values)[0]["type"]  {
        case let val where val as? String == "many":
            BoxCell.itemLabel.text = item
            let selectedSquare = UIImage(named: "Select")
            let DeSelectedSquare = UIImage(named: "Deselect")
            //get number of selections
            if checkboxIndexPath.contains(indexPath) {
                BoxCell.radioButton.setImage(selectedSquare, for: .normal)
            }else{
                BoxCell.radioButton.setImage(DeSelectedSquare, for: .normal)
            }
            return BoxCell
        case let val where val as? String == "single":
            let SelectedCircle = UIImage(named: "RadioNotEmpty")
            let DeSelectedCircle = UIImage(named: "RadioEmpty")

            RadioCell.itemLabel.text = item
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
        default:
            print("Invalid choose")
            return BoxCell
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupItemViewController()
    }



    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tableHeader = ItemTableHeaderView()
        tableHeader.sectionHeaderLabel.text = Array(self.ItemSection[section].keys)[0]
      return tableHeader
    }



    @objc func ItemBackbuttonAction(sender: UIButton!) {
               self.navigationController?.popViewController(animated: true)
       }
    

    @IBAction func AddToCart(_ sender: Any) {
self.navigationController?.popViewController(animated: true)
    }
    
}
