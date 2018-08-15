//
//  Names.swift
//  BabyNames
//
//  Created by Tyler Lafferty on 7/25/18.
//  Copyright © 2018 Tyler Lafferty. All rights reserved.
//

import UIKit
import Foundation

enum Gender: String {
    case male = "male"
    case female = "female"
    case neutral = "neutral"
}

class Name: NSObject, NSCoding {
    var name: String
    var meaning: String
    var origin: String
    var gender: Gender
    
    init(name: String, meaning: String, origin: String, gender: Gender) {
        self.name = name
        self.meaning = meaning
        self.origin = origin
        self.gender = gender
    }
    
    required convenience init(coder aDecoder : NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let meaning = aDecoder.decodeObject(forKey: "meaning") as! String
        let origin = aDecoder.decodeObject(forKey: "origin") as! String
        let gender = Gender(rawValue: aDecoder.decodeObject(forKey: "gender") as! String)
        self.init(name: name, meaning: meaning, origin: origin, gender: gender!)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(meaning, forKey: "meaning")
        aCoder.encode(origin, forKey: "origin")
        aCoder.encode(gender.rawValue, forKey: "gender")
    }
}

var MASTER_NAMES: [Name] = [
    Name(name: "Bailey", meaning: "This is a meaning", origin: "This is the origin", gender: .female),
    Name(name: "Roberta", meaning: "This is a meaning for Roberta", origin: "This is the origin for Roberta", gender: .female),
    Name(name: "Tyler", meaning: "This is a meaning for Tyler", origin: "This is the origin for Tyler", gender: .male)
]
