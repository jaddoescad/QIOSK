//
//  TestViewController.swift
//  prompt
//
//  Created by Jad Slim on 2019-10-27.
//  Copyright © 2019 Jad Slim. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    let section2 = [["Choice of Toppings": ["type": "many"]], ["Flavour" :["type": "single"]]]

    override func viewDidLoad() {
        super.viewDidLoad()
        // If json is .Dictionary
//        print((Array(section2[0].values)[0] as Dictionary)["type"])
        
        print(Array(section2[0].values)[0]["type"])
        
    }
        
//        print(Array(section2[0].keys)[0])
        // Do any additional setup after loading the view.
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
