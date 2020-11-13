//
//  CustomLayout.swift
//  ECE1778Project
//
//  Created by Yue Cai on 2020-01-25.
//  Copyright © 2020 ECE1778. All rights reserved.
//

import Foundation
import UIKit

class CustomLayout {
        
    // round shadowed button
    static func styleRoundButton(_ button: UIButton) {
        // corner radius
        button.layer.cornerRadius = 30
        // drop shadow
        button.layer.masksToBounds = false
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowRadius = 1
        button.layer.shadowOpacity = 0.5
    }
    
    // round collection
    static func styleCollectionView(_ collection: UICollectionView) {
        collection.layer.cornerRadius = 20
    }
    
}
