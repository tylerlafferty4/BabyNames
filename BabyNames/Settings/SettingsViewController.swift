//
//  SettingsViewController.swift
//  BabyNames
//
//  Created by Tyler Lafferty on 7/26/18.
//  Copyright © 2018 Tyler Lafferty. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    // -- Outlets --
    @IBOutlet var tableView: UITableView!
    
    // -- Vars --
    var currentGender: String!
    var genderChanged: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.addStatusView()
        
        currentGender = UserDefaults.standard.object(forKey: GENDER) as! String
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Check if the gender has been changed
        if genderChanged {
            if let gender = UserDefaults.standard.object(forKey: GENDER) as? String {
                if gender != currentGender {
                    print("Gender changed")
                    UserDefaults.standard.set(true, forKey: GENDER_CHANGED)
                    UserDefaults.standard.synchronize()
                }
            }
        }
    }
}

// MARK: - UITableView Delegate, Datasource
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 90
        }
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "genderCell", for: indexPath) as! GenderTableViewCell
            cell.setSegmentColor()
            cell.delegate = self
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ImageTableViewCell
            cell.setupCell(imgName: "reset", title: "Reset App?")
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            showResetAlert()
        }
    }
}

// MARK: - GenderCell Delegate
extension SettingsViewController: GenderCellDelegate {
    
    func didChangeSegment() {
        genderChanged = true
        tableView.reloadData()
        view.addStatusView()
        if let gender = UserDefaults.standard.object(forKey: GENDER) as? String {
            if gender == Gender.male.rawValue {
                UITabBar.appearance().tintColor = BOY_COLOR
            } else if gender == Gender.female.rawValue {
                UITabBar.appearance().tintColor = GIRL_COLOR
            } else if gender == Gender.either.rawValue {
                UITabBar.appearance().tintColor = NEUTRAL_COLOR
            }
            guard let currentView = (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController?.view,
                let superview = currentView.superview else { return }
            
            currentView.removeFromSuperview()
            superview.addSubview(currentView)
        }
    }
}

// MARK: - Helpers
extension SettingsViewController {
    
    func showResetAlert() {
        let alert = UIAlertController(title: "Baby Names", message: "Are you sure you wish to reset liked and disliked names?", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "Yes", style: .default) { (action) in
            BNShared.resetApp()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(confirm)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}




