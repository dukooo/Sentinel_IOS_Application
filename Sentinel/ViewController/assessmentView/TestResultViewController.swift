//
//  TestResultViewController.swift
//  ECE1778Project
//
//  Created by Yue Cai on 2020-01-26.
//  Copyright © 2020 ECE1778. All rights reserved.
//

import UIKit

class TestResultViewController: UIViewController {

    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var resultHeader: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var resultDescription: UITextView!
    
    let transiton = SlideInTransition()
    var testIndex = -1
    var score: Int = -1
    var fromHistory = false
    //var progressViewController = ProgressViewController();

    
    override func viewDidLoad() {
        //self.view.addSubview(progressViewController.view)
        super.viewDidLoad()
        setUpElements()
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }
    
    func setUpElements() {
        resultHeader.text = Constants.testList[testIndex].resultHeader
        if testIndex == 0 {
            resultDescription.text = pcl5Result()
            scoreLabel.text = "\(score)" + "/80"
        }
        else if testIndex == 1 {
            resultDescription.text = psqResult()
            scoreLabel.text = "\(score)" + "/280"
        }
        else if testIndex == 2 {
            resultDescription.text = iselResult()
            scoreLabel.text = "\(score)"
        }
        else if testIndex == 3 {
            resultDescription.text = dass42dResult()
            scoreLabel.text = "\(score)" + "/42"
        }
        else {
            resultDescription.text = dass42aResult()
            scoreLabel.text = "\(score)" + "/42"
        }
    }
    
    func pcl5Result() -> String {
        if (score < 33) {
            return "Your score suggests a typical reaction to a traumatic experience, at least for the first few weeks or months following trauma. Keep tracking symptoms for potential change or maintenance"
        }
        else if (score < 39) {
            return "Your score suggests partial PTSD. While not displaying the severity of clinical levels of PTSD, you may be experiencing several symptoms that will impact your daily life and performance."
        }
        return "Your score suggests possible clinical levels of PTSD. You may be experiencing symptoms significantly impacting your daily life and performance. Follow up with a mental health professional may be used for official diagnoses."
    }
    
    func psqResult() -> String {
        if (score == 40) {
            return "You reported no operational stress from your work environment."
        }
        else if (score < 120) {
            return "You reported some operational stress from your work environment."
        }
        else if (score < 200) {
            return "You reported moderate operational stress from your work environment."
        }
        return "You reported no operational stress from your work environment."
    }
    
    func iselResult() -> String {
        return "This questionnaire measures your perceived availability of potential social supports and resources across 4 categories: tangible resources: availability material aid, appraisal resources: availability of someone to talk to about one’s problems, self-esteem: availability of a positive comparison when comparing one’s self to others, belonging: availability of people one can do things with"
    }
    
    func dass42dResult() -> String {
        if (score < 10) {
            return "You are currently experiencing a normal amount of depressive symptoms"
        }
        else if (score < 14) {
            return "You are currently experiencing a mild amount of depressive symptoms"
        }
        else if (score < 21) {
            return "You are currently experiencing a moderate amount of depressive symptoms"
        }
        else if (score < 28) {
            return "You are currently experiencing a severe amount of depressive symptoms"
        }
        return "You are currently experiencing an extremely severe amount of depressive symptoms"
    }
    
    func dass42aResult() -> String {
        if (score < 8) {
            return "You are currently experiencing a normal amount of depressive symptoms"
        }
        else if (score < 10) {
            return "You are currently experiencing a mild amount of depressive symptoms"
        }
        else if (score < 15) {
            return "You are currently experiencing a moderate amount of depressive symptoms"
        }
        else if (score < 20) {
            return "You are currently experiencing a severe amount of depressive symptoms"
        }
        return "You are currently experiencing an extremely severe amount of depressive symptoms"
    }

    @IBAction func returnBtnTapped(_ sender: Any) {
        if fromHistory == true {
            let vc = storyboard?.instantiateViewController(identifier: "testHistoryVC") as? TestHistoryViewController
            vc?.testIndex = testIndex
            view.window?.rootViewController = vc
            view.window?.makeKeyAndVisible()
        } else {
            let vc = storyboard?.instantiateViewController(identifier: "goToATest") as? TestViewController
            vc?.testIndex = testIndex
            view.window?.rootViewController = vc
            view.window?.makeKeyAndVisible()
        }
    }
}

extension TestResultViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}
