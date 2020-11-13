//
//  TestInstructionViewController.swift
//  ECE1778Project
//
//  Created by Yue Cai on 2020-01-26.
//  Copyright © 2020 ECE1778. All rights reserved.
//

import UIKit

class TestInstructionViewController: UIViewController {

    var testIndex: Int = -1
    @IBOutlet weak var testName: UILabel!
    @IBOutlet weak var testInstruction: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    func setUpElements() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        testInstruction.textContainerInset = UIEdgeInsets(top: 10, left: 8, bottom: 15, right: 8)
        testName.text = Constants.testList[testIndex].name
        testInstruction.text = Constants.testList[testIndex].instruction
        showAnimation()
    }
    
    func showAnimation() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.5;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.view.alpha = 1.0;
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToTestDetail" {
            let testDetailVC = segue.destination as! TestQuestionViewController
            let testIndex = sender as! Int
            testDetailVC.testIndex = testIndex
        }
    }
    
    
    @IBAction func closeTapped(_ sender: Any) {

        self.performSegue(withIdentifier: "goToTestDetail", sender: testIndex)
    }
}
