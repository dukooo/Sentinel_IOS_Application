//
//  TestViewController.swift
//  ECE1778Project
//
//  Created by Ran Yang on 2020-02-26.
//  Copyright © 2020 ECE1778. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet weak var aboutBtn: UIButton!
    @IBOutlet weak var startTestBtn: UIButton!
    @IBOutlet weak var historyBtn: UIButton!
    
    @IBOutlet weak var testTitle: UILabel!
    @IBOutlet weak var historyTestCollection: UICollectionView!
    let transiton = SlideInTransition()
    var testIndex = -1
    
    var historyTest = [["PSQ", "1579806708"]
                        , ["PCL5", "1579897366"]
                        , ["COPE", "1579897510"]
                        , ["DASS42", "1579897590"]
                        , ["ISEL12", "1579897670"]
                        , ["PTQ", "1579898270"]]
    
    override func viewDidLoad() {
        if testIndex == 0{ // PCL
            testTitle.text = "Posttraumatic Stress Disorder (PTSD)"
        }
        else if testIndex == 1 { // PSQ (broken into 2 scores, org stress, and occ stress)
            testTitle.text = "Police Stress"
        }
        else if testIndex == 2 { // ISEL
            testTitle.text = "Social Support"
        }
        else if testIndex == 3 { // DASS42 depression
            testTitle.text = "Depression"
        }
        else { // anxiety, DASS42 anxiety
            testTitle.text = "Anxiety"
        }
        super.viewDidLoad()
//        setUpElements()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToInstruction" {
            let testInstructionVC = segue.destination as! TestInstructionViewController
            let testIndex = sender as! Int
            testInstructionVC.testIndex = testIndex
            
        }
        if segue.identifier == "goToTestDetail" {
            let testDetailVC = segue.destination as! TestQuestionViewController
            let testIndex = sender as! Int
            testDetailVC.testIndex = testIndex
        }
        if segue.identifier == "goToTestHistory" {
            let historyVC = segue.destination as! TestHistoryViewController
            let testIndex = sender as! Int
            historyVC.testIndex = testIndex
        }
        if segue.identifier == "goToAbout" {
            let aboutVC = segue.destination as! TestAboutViewController
            let testIndex = sender as! Int
            aboutVC.testIndex = testIndex
        }
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }
    
    @IBAction func aboutBtnTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "goToAbout", sender: testIndex)
    }
    @IBAction func takeTestBtnTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "goToInstruction", sender: testIndex)
    }
    
    @IBAction func historyBtnTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "goToTestHistory", sender: testIndex)
    }

}

extension TestViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}
