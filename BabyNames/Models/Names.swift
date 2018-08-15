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
    case either = "either"
}

enum Origin: String {
    case english = "English"
    case italian = "Italian"
    case french = "French"
}

class Name: NSObject, NSCoding {
    var name: String
    var meaning: String
    var origin: Origin
    var gender: Gender
    
    init(name: String, meaning: String, origin: Origin, gender: Gender) {
        self.name = name
        self.meaning = meaning
        self.origin = origin
        self.gender = gender
    }
    
    required convenience init(coder aDecoder : NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let meaning = aDecoder.decodeObject(forKey: "meaning") as! String
        let origin = Origin(rawValue: aDecoder.decodeObject(forKey: "origin") as! String)
        let gender = Gender(rawValue: aDecoder.decodeObject(forKey: "gender") as! String)
        self.init(name: name, meaning: meaning, origin: origin!, gender: gender!)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(meaning, forKey: "meaning")
        aCoder.encode(origin.rawValue, forKey: "origin")
        aCoder.encode(gender.rawValue, forKey: "gender")
    }
}

var FEMALE_NAMES: [Name] = [
    Name(name: "Abbey", meaning: "Varient of Abigail", origin: .english, gender: .female),
    Name(name: "Abbie", meaning: "Varient of Abigail", origin: .english, gender: .female),
    Name(name: "Abigail", meaning: "Biblical name meaning 'father of exaltation", origin: .english, gender: .female),
    Name(name: "Ada", meaning: "Pet forms of the girl’s names Adele or Adelaide", origin: .english, gender: .female),
    Name(name: "Adelaide", meaning: "English form of the French name Adélaïde", origin: .english, gender: .female),
    Name(name: "Adele", meaning: "English form of the French name Adéle", origin: .english, gender: .female),
    Name(name: "Adrienne", meaning: "Feminine of the name Adrian", origin: .english, gender: .female),
    Name(name: "Agatha", meaning: "Good or honourable from agathos", origin: .english, gender: .female),
    Name(name: "Agnes", meaning: "Pure, or holy from the word hagnos", origin: .english, gender: .female),
    Name(name: "Aileen", meaning: "Variant of the girl’s name Eileen", origin: .english, gender: .female),
    Name(name: "Alana", meaning: "Feminine form of Alan", origin: .english, gender: .female),
    Name(name: "Alex", meaning: "Variant of the name Alexandra or Alexis", origin: .english, gender: .female),
    Name(name: "Alexandra", meaning: "From the words ‘Defender of Mankind’ and Warrior", origin: .english, gender: .female),
    Name(name: "Alice", meaning: "Based on the girl’s name Adelaide", origin: .english, gender: .female),
    Name(name: "Alina", meaning: "From the names Alina and Linda", origin: .english, gender: .female),
    Name(name: "Alison", meaning: "Norman diminutive of Alice", origin: .english, gender: .female),
    Name(name: "Alma", meaning: "River in the Crimea", origin: .english, gender: .female),
    Name(name: "Amanda", meaning: "Means loveable", origin: .english, gender: .female),
    Name(name: "Amber", meaning: "From the gemstone amber", origin: .english, gender: .female),
    Name(name: "Amelia", meaning: "A mix between the names Emilia and Amalia", origin: .english, gender: .female),
    Name(name: "Amy", meaning: "Anglicized from Amee (old French)", origin: .english, gender: .female),
    Name(name: "Andrea", meaning: "Feminine form of the name Andrew", origin: .english, gender: .female),
    Name(name: "Angela", meaning: "This name means Angelic", origin: .english, gender: .female),
    Name(name: "Ann", meaning: "English spelling of Anne", origin: .english, gender: .female),
    Name(name: "Annabelle", meaning: "Likely from Amabel", origin: .english, gender: .female),
    Name(name: "Anne", meaning: "From the Hebrew girl’s name Hanna", origin: .english, gender: .female),
    Name(name: "Anthea", meaning: "From the Greek name Antheia", origin: .english, gender: .female),
    Name(name: "April", meaning: "English form of aprilis. Also a month.", origin: .english, gender: .female),
    Name(name: "Arlene", meaning: "Probably based on Marlene or Charlene", origin: .english, gender: .female),
    Name(name: "Ashley", meaning: "Derived from old English Ash and Wood", origin: .english, gender: .female),
    Name(name: "Audrey", meaning: "From an old English name which means noble strength", origin: .english, gender: .female),
    Name(name: "Ava", meaning: "Was a 9th-century saint St Ava or Avis", origin: .english, gender: .female),
    Name(name: "Avril", meaning: "Taken from April", origin: .english, gender: .female),
    Name(name: "Babs", meaning: "Pet form of the girl’s name Barbara", origin: .english, gender: .female),
//    Name(name: "Bailey", meaning: "This is a meaning", origin: .english, gender: .female),
    Name(name: "Barbara", meaning: "Means foreign woman", origin: .english, gender: .female),
    Name(name: "Bea", meaning: "Short form of Beatrix or Beatrice", origin: .english, gender: .female),
    Name(name: "Beatrix", meaning: "Voyager/Blessed", origin: .english, gender: .female),
    Name(name: "Becky", meaning: "From the girl’s name Rebecca", origin: .english, gender: .female),
    Name(name: "Belinda", meaning: "Uncertain origin", origin: .english, gender: .female),
    Name(name: "Bella", meaning: "Short form of Isabella", origin: .english, gender: .female),
    Name(name: "Bernice", meaning: "From Berenice", origin: .english, gender: .female),
    Name(name: "Berry", meaning: "From the fruit", origin: .english, gender: .female),
    Name(name: "Bertha", meaning: "Bright or famous", origin: .english, gender: .female),
    Name(name: "Beryl", meaning: "A gemstone", origin: .english, gender: .female),
    Name(name: "Bess", meaning: "From the English name Elizabeth", origin: .english, gender: .female),
    Name(name: "Bet", meaning: "From the English name Elizabeth", origin: .english, gender: .female),
    Name(name: "Beth", meaning: "From Elizabeth", origin: .english, gender: .female),
    Name(name: "Bethany", meaning: "Village outside Jerusalem", origin: .english, gender: .female),
    Name(name: "Betsy", meaning: "Pet form of Elizabeth", origin: .english, gender: .female),
    Name(name: "Betty", meaning: "From the English girl’s name Elizabeth", origin: .english, gender: .female),
    Name(name: "Beverly", meaning: "From a Beaver Stream/Meadow", origin: .english, gender: .female),
    Name(name: "Blanche", meaning: "Blonde, white or fair", origin: .english, gender: .female),
    Name(name: "Bobbie", meaning: "Variant of the name Roberta", origin: .english, gender: .female),
    Name(name: "Bonnie", meaning: "This English girl’s name mean fine, attractive, lovely", origin: .english, gender: .female),
    Name(name: "Brenda", meaning: "Flaming sword", origin: .english, gender: .female),
    Name(name: "Brianne", meaning: "The feminine of Brian", origin: .english, gender: .female),
    Name(name: "Bridget", meaning: "Anglicized from Brighid", origin: .english, gender: .female),
    Name(name: "Britney", meaning: "From Britain", origin: .english, gender: .female),
    Name(name: "Brittany", meaning: "From Britain", origin: .english, gender: .female),
    Name(name: "Brooke", meaning: "From the Brook", origin: .english, gender: .female),
    Name(name: "Camilla", meaning: "From the old Roman name Camillus", origin: .english, gender: .female),
    Name(name: "Candice", meaning: "From Candace", origin: .english, gender: .female),
    Name(name: "Cara", meaning: "To beloved", origin: .english, gender: .female),
    Name(name: "Carissa", meaning: "Tender Touch", origin: .english, gender: .female),
    Name(name: "Carla", meaning: "Feminine of Charles", origin: .english, gender: .female),
    Name(name: "Carly", meaning: "Pet form of Carla", origin: .english, gender: .female),
    Name(name: "Carmel", meaning: "Christian origins", origin: .english, gender: .female),
    Name(name: "Carol", meaning: "Anglicised form of Carolus", origin: .english, gender: .female),
    Name(name: "Caroline", meaning: "Anglicised form of Carolus", origin: .english, gender: .female),
    Name(name: "Carrie", meaning: "Form of Caroline", origin: .english, gender: .female),
    Name(name: "Cass", meaning: "Short for the girl’s name Cassandra", origin: .english, gender: .female),
    Name(name: "Catherine", meaning: "A variant of the name Katherine", origin: .english, gender: .female),
    Name(name: "Cathy", meaning: "A short form of Catherine", origin: .english, gender: .female),
    Name(name: "Charis", meaning: "From the Greek name haris to grace", origin: .english, gender: .female),
    Name(name: "Charity", meaning: "Affection/’Love for fellow man’", origin: .english, gender: .female),
    Name(name: "Charlene", meaning: "Originates from the name Charles", origin: .english, gender: .female),
    Name(name: "Charlie", meaning: "Pet name for Charles", origin: .english, gender: .female),
    Name(name: "Charlotte", meaning: "From the name Charles", origin: .english, gender: .female),
    Name(name: "Chelsea", meaning: "Means Harbour, and place in London", origin: .english, gender: .female),
    Name(name: "Cherida", meaning: "A mix between Cheryl and Phillida", origin: .english, gender: .female),
    Name(name: "Cherish", meaning: "To treasure", origin: .english, gender: .female),
    Name(name: "Cheryl", meaning: "Origins unknown, possibly from Cherry and Beryl", origin: .english, gender: .female),
    Name(name: "Chloe", meaning: "This name originated from the Greek name khlóē", origin: .english, gender: .female),
    Name(name: "Christina", meaning: "Feminine form of Christian", origin: .english, gender: .female),
    Name(name: "Christine", meaning: "Form of the girl’s name Christina", origin: .english, gender: .female),
    Name(name: "Clara", meaning: "Feminine form of Clarus", origin: .english, gender: .female),
    Name(name: "Clare", meaning: "A form of Clara", origin: .english, gender: .female),
    Name(name: "Clarissa", meaning: "A version of the name Clarice", origin: .english, gender: .female),
    Name(name: "Claudia", meaning: "Originates from the name Claudius", origin: .english, gender: .female),
    Name(name: "Connie", meaning: "Pet form of Constance", origin: .english, gender: .female),
    Name(name: "Courtney", meaning: "Popular in America from the place Courtnay in France", origin: .english, gender: .female),
    Name(name: "Cynthia", meaning: "From the girl’s name Kynthia", origin: .english, gender: .female),
    
    Name(name: "Roberta", meaning: "This is a meaning for Roberta", origin: .english, gender: .female)
]

var MALE_NAMES: [Name] = [
    Name(name: "Tyler", meaning: "This is a meaning for Tyler", origin: .english, gender: .male)
]




















