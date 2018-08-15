//
//  NameCardView.swift
//  BabyNames
//
//  Created by Tyler Lafferty on 8/2/18.
//  Copyright © 2018 Tyler Lafferty. All rights reserved.
//

import UIKit

class NameCardView: UIView {
    
    // -- Outlets --
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var meaningHeader: UILabel!
    @IBOutlet weak var meaningLbl: UILabel!
    @IBOutlet weak var originHeader: UILabel!
    @IBOutlet weak var originLbl: UILabel!
    
    
    let nibName = "NameCardView"
    var view : UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetUp()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetUp()
    }
    
    func xibSetUp() {
        Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    }
    
    func loadViewFromNib() ->UIView {
        let bundle = Bundle.main
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
}
