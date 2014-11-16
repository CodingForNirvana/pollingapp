//
//  PollsCollectionViewCell.swift
//  pollingapp
//
//  Created by Amol Chaudhari on 11/16/14.
//  Copyright (c) 2014 MadBullTechnologies. All rights reserved.
//

import UIKit

class PollsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var optionImageA: UIImageView!

    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    override func awakeFromNib() {
        super.awakeFromNib();
    }
}
