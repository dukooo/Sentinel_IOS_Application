//
//  StartTestViewController.swift
//  ECE1778Project
//
//  Created by Ran Yang on 2020-02-26.
//  Copyright © 2020 ECE1778. All rights reserved.
//

import UIKit

class StartTestViewController: UIViewController {
        
    @IBOutlet weak var policeStressIcon: UIImageView!
    @IBOutlet weak var socialSupportIcon: UIImageView!
    @IBOutlet weak var PTSDIcon: UIImageView!
    @IBOutlet weak var depressionIcon: UIImageView!
    @IBOutlet weak var anxietyIcon: UIImageView!
    
    let transiton = SlideInTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButtons()
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }
    
    func setUpButtons() {
        let PTSDBtn = UITapGestureRecognizer(target: self, action: #selector(StartTestViewController.PTSDBtnTapDetected))
        PTSDBtn.numberOfTapsRequired = 1
        PTSDIcon.isUserInteractionEnabled = true
        PTSDIcon.addGestureRecognizer(PTSDBtn)
        
        let policeStressBtn = UITapGestureRecognizer(target: self, action: #selector(StartTestViewController.policeStressBtnTapDetected))
        policeStressBtn.numberOfTapsRequired = 1
        policeStressIcon.isUserInteractionEnabled = true
        policeStressIcon.addGestureRecognizer(policeStressBtn)
        
        let socialSupportBtn = UITapGestureRecognizer(target: self, action: #selector(StartTestViewController.socialSupportBtnTapDetected))
        socialSupportBtn.numberOfTapsRequired = 1
        socialSupportIcon.isUserInteractionEnabled = true
        socialSupportIcon.addGestureRecognizer(socialSupportBtn)
        
        let depressionBtn = UITapGestureRecognizer(target: self, action: #selector(StartTestViewController.depressionBtnTapDetected))
        depressionBtn.numberOfTapsRequired = 1
        depressionIcon.isUserInteractionEnabled = true
        depressionIcon.addGestureRecognizer(depressionBtn)
        
        let anxietyBtn = UITapGestureRecognizer(target: self, action: #selector(StartTestViewController.anxietyBtnTapDetected))
        anxietyBtn.numberOfTapsRequired = 1
        anxietyIcon.isUserInteractionEnabled = true
        anxietyIcon.addGestureRecognizer(anxietyBtn)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToATest" {
            let testVC = segue.destination as! TestViewController
            let testIndex = sender as! Int
            testVC.testIndex = testIndex
            
        }
    }
    
    @objc func PTSDBtnTapDetected() {
        self.performSegue(withIdentifier: "goToATest", sender: 0)
    }
    
    @objc func policeStressBtnTapDetected() {
        self.performSegue(withIdentifier: "goToATest", sender: 1)
    }
    
    @objc func socialSupportBtnTapDetected() {
        self.performSegue(withIdentifier: "goToATest", sender: 2)
    }
    
    @objc func depressionBtnTapDetected() {
        self.performSegue(withIdentifier: "goToATest", sender: 3)
    }
    
    @objc func anxietyBtnTapDetected() {
        self.performSegue(withIdentifier: "goToATest", sender: 4)
    }
}

extension StartTestViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}
