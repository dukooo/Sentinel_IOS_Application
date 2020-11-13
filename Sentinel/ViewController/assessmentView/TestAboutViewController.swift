//
//  TestAboutViewController.swift
//  Sentinel
//
//  Created by Yue Cai on 2020-03-01.
//  Copyright © 2020 ECE1778. All rights reserved.
//

import UIKit

class TestAboutViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextview: UITextView!
    
    let transiton = SlideInTransition()
    var testIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToTest" {
            let testVC = segue.destination as! TestViewController
            let testIndex = sender as! Int
            testVC.testIndex = testIndex
        }
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }
    
    func setUpElements() {
        print("kkkk")
        if (testIndex == 0) {
            nameLabel.text = "Posttraumatic Stress Disorder (PTSD)"
        }
        else if (testIndex == 1) {
            nameLabel.text = "Police Stress"
        }
        else if (testIndex == 2) {
            nameLabel.text = "Social Support"
        }
        else if (testIndex == 3) {
            nameLabel.text = "Depression"
        }
        else{
            nameLabel.text = "Anxiety"
        }
        descriptionTextview.text = Constants.testList[testIndex].about
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "backToTest", sender: testIndex)
    }
    
}

extension TestAboutViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}
