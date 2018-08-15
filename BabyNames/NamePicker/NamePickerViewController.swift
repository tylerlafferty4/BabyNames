//
//  FirstViewController.swift
//  BabyNames
//
//  Created by Tyler Lafferty on 7/25/18.
//  Copyright © 2018 Tyler Lafferty. All rights reserved.
//

import UIKit

class NamePickerViewController: UIViewController {

    // - Outlets -
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var originLbl: UILabel!
    @IBOutlet var meaningLbl: UILabel!
    
    // - Vars -
    var currentName: Name!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupName()
        setupGestures()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func switchName(_ sender: Any) {
        setupName()
    }
}

// MARK: - Name Helpers
extension NamePickerViewController {
    
    func setupName() {
        currentName = getRandomName()
        nameLbl.text = currentName.name
        originLbl.text = currentName.origin
        meaningLbl.text = currentName.meaning
    }
    
    func getRandomName() -> Name {
        var foundName = false
        while foundName == false {
            let randomIndex = Int(arc4random_uniform(UInt32(MASTER_NAMES.count)))
            let randName = MASTER_NAMES[randomIndex]
            if !BNShared.checkAlreadyFavorite(name: randName) && !BNShared.checkAlreadyDisliked(name: randName) {
                foundName = true
                return randName
            }
        }
    }
}

// MARK: - Gestures
extension NamePickerViewController {
    
    func setupGestures() {
        // Like Swipe
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(NamePickerViewController.swipedRight))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        // Disike Swipe
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(NamePickerViewController.swipedLeft))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @objc func swipedLeft() {
        print("Disliked name")
        BNShared.dislike(name: currentName)
    }
    
    @objc func swipedRight() {
        print("Liked name")
        BNShared.favorite(name: currentName)
    }
}











