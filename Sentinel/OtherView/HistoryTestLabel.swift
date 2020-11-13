//
//  historyTestLabel.swift
//  ECE1778Project
//
//  Created by Yue Cai on 2020-02-04.
//  Copyright © 2020 ECE1778. All rights reserved.
//

import UIKit

class HistoryTestLabel: UILabel {

    @IBInspectable var topInset: CGFloat = 12.0
    @IBInspectable var bottomInset: CGFloat = 0
    @IBInspectable var leftInset: CGFloat = 16.0
    @IBInspectable var rightInset: CGFloat = 16.0

    override func drawText(in rect: CGRect) {
       let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
       get {
          var contentSize = super.intrinsicContentSize
          contentSize.height += topInset + bottomInset
          contentSize.width += leftInset + rightInset
          return contentSize
       }
    }

}
