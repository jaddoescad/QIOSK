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
    let TARGER_COLOR = UIColor(rgb: 0x365e7a)
    var navAlpha = CGFloat()
    var radioButtonIndexPath = [Int:IndexPath]() //for radiobutton
    var checkboxIndexPath = [IndexPath]() //for checkbox
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var ItemView: ItemView!
    
    @IBOutlet weak var ItemCartButton: UIButton!
    let newView = UIImageView()
        let customView = Bundle.main.loadNibNamed("\(CustomTableHeaderView.self)", owner: nil, options: nil)!.first as! CustomTableHeaderView
    let ItemSection = [["Choice of Toppings": ["type": "many"]], ["Flavour" :["type": "single"]], ["Flavour" :["type": "single"]]]

     
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
    
    func getAllIndexPathsInSection(section : Int) -> [IndexPath] {
        let count = tableView.numberOfRows(inSection: section);
        return (0..<count).map { IndexPath(row: $0, section: section) }
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if Array(ItemSection[indexPath.section].values)[0]["type"] == "many" {

         if checkboxIndexPath.contains(indexPath) {
            if let checkboxIndex = checkboxIndexPath.firstIndex(of: indexPath) {
            checkboxIndexPath.remove(at:checkboxIndex )
            }
         }else{
                checkboxIndexPath.append(indexPath)
            }

        } else if Array(ItemSection[indexPath.section].values)[0]["type"] == "single" {

                       radioButtonIndexPath[indexPath.section] = indexPath
            //nice

                   }
        self.tableView.reloadData() // reload your tableview here
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let RadioCell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell") as! ItemTableViewCell

        let BoxCell = tableView.dequeueReusableCell(withIdentifier: "ManyItemTableViewCell") as! ManyItemTableViewCell
        
        let item = items[indexPath.section][indexPath.row]
        
        
        switch Array(ItemSection[indexPath.section].values)[0]["type"]  {
        case let val where val == "many":
            BoxCell.itemLabel.text = item
            let selectedSquare = UIImage(named: "Select")
            let DeSelectedSquare = UIImage(named: "Deselect")
            if checkboxIndexPath.contains(indexPath) {
                BoxCell.radioButton.setImage(selectedSquare, for: .normal)
            }else{
                BoxCell.radioButton.setImage(DeSelectedSquare, for: .normal)
            }
            return BoxCell
        case let val where val == "single":
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
        ItemView.BackButton.addTarget(self, action: #selector(ItemBackbuttonAction), for: .touchUpInside)

        ItemCartButton.backgroundColor = UIColor(rgb: 0x365E7A)
//        ViewNav.alpha = 0
        tableView.delegate = self
        tableView.dataSource = self
//        self.edgesForExtendedLayout = UIRectEdge.top

        // 1. Setup AutoLayout
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
        self.tableView.contentInset = insets
        addHeaderView()
        self.tableView.backgroundColor = .white
    }

    // View size is changed (e.g., device is rotated.)
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        // 3. Update header view's frmame
        DispatchQueue.main.async {
            self.tableView.updateHeaderViewFrame()
        }
    }
    func addHeaderView () {
        // 1. Set table header view programmatically
        self.tableView.setTableHeaderView(headerView: customView)
        self.offsetDenominator = self.customView.frame.size.height - (self.ItemView.NavView.frame.height)

    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var tableHeader = ItemTableHeaderView()

        tableHeader.sectionHeaderLabel.text = Array(self.ItemSection[section].keys)[0]
      return tableHeader
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let breakpoint = offsetDenominator

        if let breakpoint = breakpoint {
        let alpha = scrollView.contentOffset.y / breakpoint
            navAlpha = alpha
            
            
            self.ItemView.NavView.backgroundColor = UIColor(rgb: 0x365E7A).withAlphaComponent(navAlpha)
        }
    }
    @objc func ItemBackbuttonAction(sender: UIButton!) {
               self.navigationController?.popViewController(animated: true)
       }
    


}

class ItemTableHeaderView: UIView {
    let sectionHeaderLabel = UILabel()
    let sectionConditionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addHeaderView()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

     func addHeaderView() {
            self.backgroundColor = UIColor(rgb: 0xD5DDE3)

            sectionHeaderLabel.textColor = UIColor(rgb: 0x365E7A)
    sectionConditionLabel.textColor = UIColor(rgb: 0x365E7A).withAlphaComponent(0.6)
            sectionHeaderLabel.font = UIFont(name: "AvenirNext-Medium", size: 18)
            sectionConditionLabel.font = UIFont(name: "AvenirNext-Medium", size: 13)

    //           newlabel.adjustsFontSizeToFitWidth = true
            sectionConditionLabel.text = "Required"
    
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

