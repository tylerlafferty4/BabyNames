//
//  ImageTableViewCell.swift
//  BabyNames
//
//  Created by Tyler Lafferty on 7/26/18.
//  Copyright © 2018 Tyler Lafferty. All rights reserved.
//

import Foundation
import UIKit

class ImageTableViewCell: UITableViewCell {
    
    // -- Outlets --
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var titleLbl: UILabel!
    
    override func awakeFromNib() {
        
    }
    
    func setupCell(imgName: String, title: String) {
        imgView.image = UIImage(named: imgName)?.withRenderingMode(.alwaysTemplate)
        if let gender = UserDefaults.standard.object(forKey: GENDER) as? String {
            if gender == Gender.male.rawValue {
                imgView.tintColor = BOY_COLOR
            } else if gender == Gender.female.rawValue {
                imgView.tintColor = GIRL_COLOR
            } else if gender == Gender.either.rawValue {
                imgView.tintColor = NEUTRAL_COLOR
            }
        }
        titleLbl.text = title
    }
}
