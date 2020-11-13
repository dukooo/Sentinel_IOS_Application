//
//  ResourceViewController.swift
//  Sentinel
//
//  Created by Yue Cai on 2020-03-29.
//  Copyright © 2020 ECE1778. All rights reserved.
//

import UIKit
import MessageUI

class ResourceViewController: UIViewController, MFMessageComposeViewControllerDelegate {

    @IBOutlet weak var call1: UIButton!
    @IBOutlet weak var call2: UIButton!
    @IBOutlet weak var text: UIButton!
    @IBOutlet weak var back: UIButton!
    
    let transiton = SlideInTransition()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        call1.layer.cornerRadius = 10
        call2.layer.cornerRadius = 10
        text.layer.cornerRadius = 10
        back.layer.cornerRadius = 10
        
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }
    
    @IBAction func call1Tapped(_ sender: Any) {
        let numberString = "18002675463"
        guard let url = URL(string:"telprompt://\(numberString)") else {
            return
        }
        UIApplication.shared.open(url)
    }
    
    @IBAction func call2Tapped(_ sender: Any) {
        let numberString = "18334564566"
        guard let url = URL(string:"telprompt://\(numberString)") else {
            return
        }
        UIApplication.shared.open(url)
    }
    
    @IBAction func textTapped(_ sender: Any) {
        let msgVC = MFMessageComposeViewController()
        msgVC.body = "Start"
        msgVC.recipients = ["45645"]
        msgVC.messageComposeDelegate = self
        self.present(msgVC, animated: true, completion: nil)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true)
    }
    
}


extension ResourceViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}

