//
//  HelpViewController.swift
//  ECE1778Project
//
//  Created by Yue Cai on 2020-02-05.
//  Copyright © 2020 ECE1778. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {
    
    @IBOutlet weak var resourceButton: UIButton!
    @IBOutlet weak var reportButton: UIButton!
    
    let transiton = SlideInTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resourceButton.layer.cornerRadius = 10
        reportButton.layer.cornerRadius = 10
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }
    
}

extension HelpViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}
