//
//  HomeViewController.swift
//  ECE1778Project
//
//  Created by Yue Cai on 2020-01-25.
//  Copyright © 2020 ECE1778. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    
    @IBOutlet weak var menu: UIButton!
    @IBOutlet weak var recordIncidentsView: UIImageView!
    @IBOutlet weak var analysisImageView: UIImageView!
    @IBOutlet weak var testImageView: UIImageView!
    @IBOutlet weak var helpImageView: UIImageView!
    
    let transiton = SlideInTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButtons()
    }

    func setUpButtons() {
        let singleTap1 = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.analysisTapDetected))
        singleTap1.numberOfTapsRequired = 1
        analysisImageView.isUserInteractionEnabled = true
        analysisImageView.addGestureRecognizer(singleTap1)
        
        let singleTap2 = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.testTapDetected))
        singleTap2.numberOfTapsRequired = 1
        testImageView.isUserInteractionEnabled = true
        testImageView.addGestureRecognizer(singleTap2)
        
        let singleTap3 = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.helpTapDetected))
        singleTap3.numberOfTapsRequired = 1
        helpImageView.isUserInteractionEnabled = true
        helpImageView.addGestureRecognizer(singleTap3)
        
        let singleTap4 = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.recordIncidentsTapDetected))
        singleTap4.numberOfTapsRequired = 1
        recordIncidentsView.isUserInteractionEnabled = true
        recordIncidentsView.addGestureRecognizer(singleTap4)
    }
    
    @IBAction func menuTapDetected(_ sender: Any) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }
    
    @objc func analysisTapDetected() {
        let vc = self.storyboard?.instantiateViewController(identifier: "analysisVC")
        self.view.window?.rootViewController = vc
        self.view.window?.makeKeyAndVisible()
    }

    @objc func testTapDetected() {
        let vc = self.storyboard?.instantiateViewController(identifier: "testVC")
        self.view.window?.rootViewController = vc
        self.view.window?.makeKeyAndVisible()
    }
    
    @objc func helpTapDetected() {
        let vc = self.storyboard?.instantiateViewController(identifier: "helpVC")
        self.view.window?.rootViewController = vc
        self.view.window?.makeKeyAndVisible()
    }
    
    @objc func recordIncidentsTapDetected() {
        let vc = self.storyboard?.instantiateViewController(identifier: "recordIncidentsVC")
        self.view.window?.rootViewController = vc
        self.view.window?.makeKeyAndVisible()
    }
    
    @IBAction func backTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        transitionToLogin()
    }
    
    func transitionToLogin() {
        let vc = storyboard?.instantiateViewController(identifier: "loginVC")
        view.window?.rootViewController = vc
        view.window?.makeKeyAndVisible()
    }
    
    
}

extension HomeViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}
