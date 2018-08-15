//
//  GenderTableViewCell.swift
//  BabyNames
//
//  Created by Tyler Lafferty on 7/27/18.
//  Copyright © 2018 Tyler Lafferty. All rights reserved.
//

import Foundation
import UIKit

protocol GenderCellDelegate {
    func didChangeSegment()
}

class GenderTableViewCell: UITableViewCell {
    
    // -- Outlets --
    @IBOutlet var segmentControl: UISegmentedControl!
    @IBOutlet var titleLbl: UILabel!
    
    // -- Vars --
    var delegate: GenderCellDelegate!
    
    override func awakeFromNib() {
        if let gender = UserDefaults.standard.object(forKey: GENDER) as? String {
            if gender == Gender.male.rawValue {
                segmentControl.selectedSegmentIndex = 0
            } else if gender == Gender.female.rawValue {
                segmentControl.selectedSegmentIndex = 2
            } else if gender == Gender.either.rawValue {
                segmentControl.selectedSegmentIndex = 1
            }
        } else {
            segmentControl.selectedSegmentIndex = 1
        }
    }
    
    func setSegmentColor() {
        if let gender = UserDefaults.standard.object(forKey: GENDER) as? String {
            if gender == Gender.male.rawValue {
                segmentControl.tintColor = BOY_COLOR
            } else if gender == Gender.female.rawValue {
                segmentControl.tintColor = GIRL_COLOR
            } else if gender == Gender.either.rawValue {
                segmentControl.tintColor = NEUTRAL_COLOR
            }
        } else {
            segmentControl.tintColor = NEUTRAL_COLOR
        }
    }
    
    @IBAction func segControlTapped(_ sender: Any) {
        if segmentControl.selectedSegmentIndex == 0 {
            UserDefaults.standard.set(Gender.male.rawValue, forKey: GENDER)
        } else if segmentControl.selectedSegmentIndex == 2 {
            UserDefaults.standard.set(Gender.female.rawValue, forKey: GENDER)
        } else if segmentControl.selectedSegmentIndex == 1 {
            UserDefaults.standard.set(Gender.either.rawValue, forKey: GENDER)
        }
        UserDefaults.standard.synchronize()
        delegate.didChangeSegment()
    }
}
