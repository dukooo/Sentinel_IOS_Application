//
//  HistoryCell.swift
//  Sentinel
//
//  Created by Ran Yang on 2020-03-01.
//  Copyright © 2020 ECE1778. All rights reserved.
//

import UIKit

class HistoryCell: UICollectionViewCell {
    
    @IBOutlet weak var historyLabel: UILabel!
    
    var result : [Int]? {
        didSet {
            updateView()
        }
    }
    
    func updateView(){
        let date = Date(timeIntervalSince1970: TimeInterval(self.result![0]))
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        formatter.locale = Locale.current
        historyLabel.text = "      " + formatter.string(from: date) + " (" + String(self.result![1]) + ")"
    }

    

    
}
