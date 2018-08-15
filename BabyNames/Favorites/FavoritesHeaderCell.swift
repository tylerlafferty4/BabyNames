//
//  FavoritesHeaderCell.swift
//  BabyNames
//
//  Created by Tyler Lafferty on 8/2/18.
//  Copyright © 2018 Tyler Lafferty. All rights reserved.
//

import UIKit

class FavoritesHeaderCell: UITableViewCell {

    // -- Outlets --
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var toggleLbl: UILabel!
    
    // -- Vars --
    var section: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(headerTxt: String, section: Int, maleExpanded: Bool, femaleExpanded: Bool) {
        self.section = section
        titleLbl.text = headerTxt
        if section == 0 {
            contentView.backgroundColor = BOY_COLOR
            if maleExpanded {
                toggleLbl.text = "Collapse"
            } else {
                toggleLbl.text = "Expand"
            }
        } else if section == 1 {
            contentView.backgroundColor = GIRL_COLOR
            if femaleExpanded {
                toggleLbl.text = "Collapse"
            } else {
                toggleLbl.text = "Expand"
            }
        }
    }
}











