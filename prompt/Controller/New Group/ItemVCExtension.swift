//
//  ItemVCExtension.swift
//  prompt
//
//  Created by Jad Slim on 2019-10-29.
//  Copyright © 2019 Jad Slim. All rights reserved.
//

import Foundation
import UIKit



extension ItemViewController {
    func addHeaderView () {
        // 1. Set table header view programmatically
        self.tableView.setTableHeaderView(headerView: customView)
        self.offsetDenominator = self.customView.frame.size.height - (self.ItemView.NavView.frame.height)

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
    
    func setupItemViewController() {
        AddToCartButton.backgroundColor = UIColor(rgb: 0x365E7A)
                ItemView.BackButton.addTarget(self, action: #selector(ItemBackbuttonAction), for: .touchUpInside)
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
    
}

