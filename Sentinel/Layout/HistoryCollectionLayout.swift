//
//  TestCollectionFlowLayout.swift
//  ECE1778Project
//
//  Created by Yue Cai on 2020-01-26.
//  Copyright © 2020 ECE1778. All rights reserved.
//

import UIKit

class HistoryCollectionLayout: UICollectionViewFlowLayout {

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
            let itemHeight = CGFloat(45.0)
            return CGSize(width: itemWidth, height: itemHeight)
        }
    }
    
    func setupLayout() {
        minimumLineSpacing = 10
        scrollDirection = .vertical
    }
}
