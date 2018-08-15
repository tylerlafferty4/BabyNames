//
//  BNShared.swift
//  BabyNames
//
//  Created by Tyler Lafferty on 7/25/18.
//  Copyright © 2018 Tyler Lafferty. All rights reserved.
//

import Foundation
import UIKit

var FAVORITE_NAMES = "favoriteNames"
var DISLIKED_NAMES = "dislikedNames"
var GENDER_CHANGED = "genderChanged"
var GENDER = "gender"
var BOY_COLOR = UIColor(red: 52.0/255.0, green: 125.0/255.0, blue: 193.0/255.0, alpha: 1)
var GIRL_COLOR = UIColor(red: 204.0/255.0, green: 101.0/255.0, blue: 148.0/255.0, alpha: 1)
var NEUTRAL_COLOR = UIColor(red: 3.0/255.0, green: 192.0/255.0, blue: 60.0/255.0, alpha: 1)

class BNShared {
    
    static var sharedInstance = BNShared()
    
    class func favorite(name: Name) {
        var favorites = BNShared.getFavorites()
        favorites.append(name)
        let encoded: Data = NSKeyedArchiver.archivedData(withRootObject: favorites)
        UserDefaults.standard.set(encoded, forKey: FAVORITE_NAMES)
        UserDefaults.standard.synchronize()
    }
    
    class func removeFavorite(name: Name) {
        var favorites = BNShared.getFavorites()
        favorites = favorites.filter( {$0.name != name.name} )
        let encoded: Data = NSKeyedArchiver.archivedData(withRootObject: favorites)
        UserDefaults.standard.set(encoded, forKey: FAVORITE_NAMES)
        UserDefaults.standard.synchronize()
    }
    
    class func dislike(name: Name) {
        var dislikes = BNShared.getDisliked()
        dislikes.append(name)
        let encoded: Data = NSKeyedArchiver.archivedData(withRootObject: dislikes)
        UserDefaults.standard.set(encoded, forKey: DISLIKED_NAMES)
        UserDefaults.standard.synchronize()
    }
    
    class func getFavorites() -> [Name] {
        if let _ = UserDefaults.standard.object(forKey: FAVORITE_NAMES) {
            let decoded = UserDefaults.standard.object(forKey: FAVORITE_NAMES) as! Data
            return NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [Name]
        } else {
            return []
        }
    }
    
    class func getDisliked() -> [Name] {
        if let _ = UserDefaults.standard.object(forKey: DISLIKED_NAMES) {
            let decoded = UserDefaults.standard.object(forKey: DISLIKED_NAMES) as! Data
            return NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [Name]
        } else {
            return []
        }
    }
    
    class func checkAlreadyFavorite(name: Name) -> Bool {
        let favorites = BNShared.getFavorites()
        for favorite in favorites {
            if favorite.name == name.name {
                return true
            }
        }
        return false
    }
    
    class func checkAlreadyDisliked(name: Name) -> Bool {
        let dislikes = BNShared.getDisliked()
        for dislike in dislikes {
            if dislike.name == name.name {
                return true
            }
        }
        return false
    }
    
    class func getNamesArray() -> [Name] {
        let gender = UserDefaults.standard.object(forKey: GENDER) as! String
        if gender == Gender.male.rawValue {
            return MALE_NAMES
        } else if gender == Gender.female.rawValue {
            return FEMALE_NAMES
        }
        return []
    }
    
    class func resetApp() {
        UserDefaults.standard.removeObject(forKey: FAVORITE_NAMES)
        UserDefaults.standard.removeObject(forKey: DISLIKED_NAMES)
        UserDefaults.standard.synchronize()
    }
}

// MARK: - UIView Extension
extension UIView {
    
    func removeStatusView() {
        for subview in self.subviews {
            if subview.tag == 999 {
                subview.removeFromSuperview()
                break
            }
        }
    }
    
    func addStatusView() {
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        statusBarView.tag = 999
        if let gender = UserDefaults.standard.object(forKey: GENDER) as? String {
            if gender == Gender.male.rawValue {
                statusBarView.backgroundColor = BOY_COLOR
            } else if gender == Gender.female.rawValue {
                statusBarView.backgroundColor = GIRL_COLOR
            } else {
                statusBarView.backgroundColor = NEUTRAL_COLOR
            }
            self.removeStatusView()
            self.addSubview(statusBarView)
        } else {
            statusBarView.backgroundColor = NEUTRAL_COLOR
            self.removeStatusView()
            self.addSubview(statusBarView)
        }
    }
}







