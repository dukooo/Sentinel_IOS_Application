//
//  TestNavigationViewController.swift
//  ECE1778Project
//
//  Created by Yue Cai on 2020-01-26.
//  Copyright © 2020 ECE1778. All rights reserved.
//

import UIKit

class TestNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    func setUpElements() {
        UINavigationBar.appearance().barTintColor = UIColor.darkGray
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationBar.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }
    

}
