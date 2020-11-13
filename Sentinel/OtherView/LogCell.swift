//
//  LogCell.swift
//  Sentinel
//
//  Created by Ran Yang on 2020-03-12.
//  Copyright © 2020 ECE1778. All rights reserved.
//

import UIKit

class LogCell: UICollectionViewCell {
    
    @IBOutlet weak var logLabel: UILabel!
    var title : [String]? {
        didSet {
            logLabel.text = "  " + title![0] + "  " + title![1]
        }
    }
    
}
