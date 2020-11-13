////
////  Progress.swift
////  Sentinel
////
////  Created by Ran Yang on 2020-02-28.
////  Copyright © 2020 ECE1778. All rights reserved.
////
//
//import UIKit
////import JGProgressHUD
//
//
//class ProgressViewController: UIViewController {
//    var hud = JGProgressHUD(style: .dark)
//
//    override func viewDidLoad() {
//        self.view.isUserInteractionEnabled = false
////        self.accessibilityRdespondsToUserInteraction = false
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//
//    func showSuccess(_ message: String){
//        UIView.animate(withDuration: 0.1, animations: {
//            self.hud.textLabel.text = message
//            self.hud.detailTextLabel.text = nil
//            self.hud.indicatorView = JGProgressHUDSuccessIndicatorView()
//        })
//
//        self.hud.dismiss(afterDelay: 2)
//    }
//
//    func showError(_ message: String){
//        UIView.animate(withDuration: 0.1, animations: {
//            self.hud.textLabel.text = message
//            self.hud.detailTextLabel.text = nil
//            self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
//        })
//
//        self.hud.dismiss(afterDelay: 2)
//    }
//
//    func showLoading(_ message: String){
//        hud.indicatorView = JGProgressHUDIndeterminateIndicatorView()
//        hud.vibrancyEnabled = true
//        hud.textLabel.text = message
//        hud.layoutMargins = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: 10.0, right: 0.0)
//
//        hud.show(in: self.view)
//        hud.dismiss(afterDelay: 20.0)
//    }
//
//}
//
