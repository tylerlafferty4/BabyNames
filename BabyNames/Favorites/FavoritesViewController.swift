//
//  SecondViewController.swift
//  BabyNames
//
//  Created by Tyler Lafferty on 7/25/18.
//  Copyright © 2018 Tyler Lafferty. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var favoriteNames: [Name] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteNames = BNShared.getFavorites()
    }
}

