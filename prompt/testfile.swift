//
//  File.swift
//  prompt
//
//  Created by Jad Slim on 2019-10-27.
//  Copyright © 2019 Jad Slim. All rights reserved.
//

import SwiftyJSON
import Foundation





class Dog {
    func bark() {
        let section2 = JSON([["Choice of Toppings": ["type": "many"]], ["Flavour" :["type": "single"]]])

        if let userName = section2[0].string {
            print(userName)
          //Now you got your value
        }    }
}


