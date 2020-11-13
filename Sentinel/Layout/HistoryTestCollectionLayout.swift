//
//  HistoryTestCollectionLayout.swift
//  ECE1778Project
//
//  Created by Yue Cai on 2020-02-04.
//  Copyright © 2020 ECE1778. All rights reserved.
//

import UIKit

class HistoryTestCollectionLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    override var itemSize: CGSize {
        set {}
        get {
            let itemWidth = self.collectionView!.frame.width
            let itemHeight = CGFloat(250.0)
            return CGSize(width: itemWidth, height: itemHeight)
        }
    }
    
    func setupLayout() {
        minimumLineSpacing = 10
        scrollDirection = .vertical
    }
}
