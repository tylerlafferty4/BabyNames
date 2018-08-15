//
//  FirstViewController.swift
//  BabyNames
//
//  Created by Tyler Lafferty on 7/25/18.
//  Copyright © 2018 Tyler Lafferty. All rights reserved.
//

import UIKit
import Koloda

class NamePickerViewController: UIViewController {

    // -- Outlets --
    @IBOutlet weak var nameCard: KolodaView!
    @IBOutlet var backgroundImg: UIImageView!
    @IBOutlet weak var likeTutImg: UIImageView!
    @IBOutlet weak var likeTutLbl: UILabel!
    @IBOutlet weak var dislikeTutImg: UIImageView!
    @IBOutlet weak var dislikeTutLbl: UILabel!
    @IBOutlet weak var undoImg: UIImageView!
    @IBOutlet weak var undoLbl: UILabel!
    
    // -- Vars --
    var currentName: Name!
    var usedNames: [Name]! = []
    var previousNumber: Int!
    var usedNumbers: [Int]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        BNShared.resetApp()
        if UserDefaults.standard.object(forKey: GENDER) == nil {
            UserDefaults.standard.set(Gender.either.rawValue, forKey: GENDER)
            UserDefaults.standard.synchronize()
        }
        
        nameCard.layer.cornerRadius = 5
        nameCard.delegate = self
        nameCard.dataSource = self

        dislikeTutImg.transform = dislikeTutImg.transform.rotated(by: CGFloat(Double.pi))
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(NamePickerViewController.undoNameAction))
        undoImg.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        determineColors()
        if let _ = UserDefaults.standard.object(forKey: GENDER_CHANGED) {
            UserDefaults.standard.removeObject(forKey: GENDER_CHANGED)
            UserDefaults.standard.synchronize()
            nameCard.reloadData()
        }
    }
}

// MARK: - Koloda Delegate Datasource
extension NamePickerViewController: KolodaViewDelegate, KolodaViewDataSource {
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let name = getRandomName()
        usedNames.append(name)
        let nameView = NameCardView()
        nameView.contentView.layer.cornerRadius = 5
        nameView.nameLbl.adjustsFontSizeToFitWidth = true
        nameView.nameLbl.text = name.name
        nameView.meaningLbl.text = name.meaning
        nameView.originLbl.text = name.origin.rawValue
        return nameView
    }
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        koloda.reloadData()
    }
    
    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return BNShared.getNamesArray().count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .fast
    }
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        let name = usedNames[index]
        if direction == .right {
            likeName(name: name)
        } else if direction == .left {
            dislikeName(name: name)
        }
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)?[0] as? OverlayView
    }
}

// MARK: - Name Helpers
extension NamePickerViewController {
    
    /// Determines a random name making sure the name hasn't been liked or disliked already
    func getRandomName() -> Name {
        var foundName = false
        let gender = UserDefaults.standard.object(forKey: GENDER) as! String
        
        while foundName == false {
            if usedNumbers.count == BNShared.getNamesArray().count {
                foundName = true
            }
            let name = BNShared.getNamesArray()[getRandomNumber()]
            if !BNShared.checkAlreadyFavorite(name: name) &&
                !BNShared.checkAlreadyDisliked(name: name) &&
                (name.gender.rawValue == gender || gender == Gender.either.rawValue) {
                return name
            }
        }
        return Name(name: "", meaning: "", origin: .english, gender: .either)
    }
    
    /// Determines a random number without having it repeat
    func getRandomNumber() -> Int {
        var randomNumber = arc4random_uniform(UInt32(BNShared.getNamesArray().count))
        if previousNumber != nil {
            while previousNumber == randomNumber {
                randomNumber = arc4random_uniform(UInt32(BNShared.getNamesArray().count))
            }
        }
        previousNumber = Int(randomNumber)
        usedNumbers.append(previousNumber)
        return Int(randomNumber)
    }
}

// MARK: - Gestures
extension NamePickerViewController {
    
    /// Dislike the name
    func dislikeName(name: Name) {
        BNShared.dislike(name: name)
    }
    
    /// Add the name to the favorites list
    func likeName(name: Name) {
        BNShared.favorite(name: name)
    }
}

// MARK: - Helpers
extension NamePickerViewController {
    
    /// Sets up the status view color and determines the background image
    func determineColors() {
        view.addStatusView()
        if let gender = UserDefaults.standard.object(forKey: GENDER) as? String {
            if gender == Gender.male.rawValue {
                backgroundImg.image = UIImage(named: "boyBackground")
            } else if gender == Gender.female.rawValue {
                backgroundImg.image = UIImage(named: "girlBackground")
            } else {
                backgroundImg.image = UIImage(named: "neutralBackground")
            }
        } else {
            backgroundImg.image = nil
        }
    }
    
    @objc func undoNameAction() {
        nameCard.revertAction()
    }
}











