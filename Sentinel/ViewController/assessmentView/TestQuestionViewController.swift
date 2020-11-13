//
//  TestQuestionViewController.swift
//  ECE1778Project
//
//  Created by Yue Cai on 2020-02-05.
//  Copyright © 2020 ECE1778. All rights reserved.
//

import UIKit
import Firebase

class TestQuestionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var progressInfo: UILabel!
    @IBOutlet weak var questionCommon: UILabel!
    @IBOutlet weak var questionContent: UITextView!
    @IBOutlet weak var answerCollection: UICollectionView!

    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    let transiton = SlideInTransition()

    var testIndex = -1
    var questionIndex = 0
    var currentTotalScore = 0
    var prevAnswerLocation : CGPoint? = nil
    var currentAnswerLocation : CGPoint? = nil
    var answerSelected = -1
    var userAnswerSet : [Int] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        questionContent.centerVertically()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToNextQuestion" {
            let testQuestionVC = segue.destination as! TestQuestionViewController
            let next = sender as! UIButton
            testQuestionVC.testIndex = next.questionPointer![0]
            testQuestionVC.questionIndex = next.questionPointer![1]
            testQuestionVC.currentTotalScore = next.questionPointer![2]
            testQuestionVC.userAnswerSet = next.answerTrack!
        }
        
        if segue.identifier == "goToTestResult" {
            let testResultVC = segue.destination as! TestResultViewController
            let result = sender as! UIButton
            testResultVC.testIndex = result.questionPointer![0]
            testResultVC.score = result.questionPointer![2]
        }
    }
    
    @IBAction func nextBtnTapped(_ sender: Any) {
        if (questionIndex < Constants.testList[testIndex].question.count - 1){
            
            userAnswerSet.append(answerSelected)
            currentTotalScore = currentTotalScore + Constants.testList[testIndex].scores[self.answerSelected]
            
            questionIndex = questionIndex + 1;
            nextBtn.questionPointer = [testIndex, questionIndex, currentTotalScore]
            nextBtn.answerTrack = userAnswerSet

            self.performSegue(withIdentifier: "goToNextQuestion", sender: nextBtn)
        }
        
    }
    
    @IBAction func submitBtnTapped(_ sender: Any) {
        //TODO store self.currentTotalScore and self.userAnswerSet to DB? use to track history?????
        currentTotalScore = currentTotalScore + Constants.testList[testIndex].scores[self.answerSelected]
        submitBtn.questionPointer = [testIndex, questionIndex, currentTotalScore]
        startIndicator()
        let db = Firestore.firestore()
        let time = Int(NSDate().timeIntervalSince1970)
        db.collection("tests").addDocument(data: ["uid": Auth.auth().currentUser!.uid, "index": testIndex, "score": currentTotalScore, "timestamp": time])  {error in
            if error != nil {
                print(error?.localizedDescription ?? "Error when storing test result")
            }
            else {
                self.stopIndicator()
                self.performSegue(withIdentifier: "goToTestResult", sender: self.submitBtn)
            }
        }
    }
    
    func startIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.large
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
    }
    
    func stopIndicator() {
        activityIndicator.stopAnimating()
        self.view.isUserInteractionEnabled = true
    }
    
    func setUpElements() {
        nextBtn.isEnabled = false
        submitBtn.isHidden = true
        progressInfo.text = "Question " + String(questionIndex + 1) + " of " + String(Constants.testList[testIndex].question.count)
        questionCommon.text = Constants.testList[testIndex].questionCommon
        if (questionIndex >= Constants.testList[testIndex].question.count - 1){
            nextBtn.isHidden = true
            submitBtn.isHidden = false
            submitBtn.isEnabled = false
        }
        answerCollection.collectionViewLayout = HistoryCollectionLayout()
//        navigationItem.title = Constants.testList[testIndex].name
        questionContent.text = Constants.testList[testIndex].question[questionIndex]
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Constants.testList[testIndex].answers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "answerCell", for: indexPath) as! TestCell
        cell.answerLabel.text = Constants.testList[testIndex].answers[indexPath.item]
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        return cell
    }
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        if (questionIndex >= Constants.testList[testIndex].question.count - 1){
            submitBtn.isEnabled = true
        } else {
            nextBtn.isEnabled = true
        }
        
        let location = sender.location(in: self.answerCollection)
        
        self.prevAnswerLocation = self.currentAnswerLocation
        self.currentAnswerLocation = location
        
        if (prevAnswerLocation != nil && self.prevAnswerLocation != self.currentAnswerLocation){
            let prevIndexPath = self.answerCollection.indexPathForItem(at: self.prevAnswerLocation!)
            let oldCell = self.answerCollection!.cellForItem(at: prevIndexPath!) as! TestCell
            oldCell.answerLabel.backgroundColor = UIColor(displayP3Red: 0.0581496, green: 0.111957, blue: 0.248311, alpha: 1)
            
            if let oldindex = prevIndexPath {
               print("Got old index: \(oldindex)!")
            }
        }
        
        let curIndexPath = self.answerCollection.indexPathForItem(at: self.currentAnswerLocation!)
        answerSelected = curIndexPath![1]
        let curCell = self.answerCollection!.cellForItem(at: curIndexPath!) as! TestCell
    
        curCell.answerLabel.backgroundColor = UIColor.black

       if let index = curIndexPath {
          print("Got clicked on index: \(index)!")
       }
    }
    
}

extension TestQuestionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return CGSize(width: collectionView.frame.size.width/1.5, height: (collectionView.frame.size.height - 40)/5)
        return CGSize(width: collectionView.frame.size.width/1.5, height: 45)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension UIButton {
    private struct AssociatedKeys {
        static var questionPointer = "questionPointer" // index 0: testIndex, index 1: questionIndex, index 2: current total score
        static var answerTrack = "answerTrack"
    }

    @IBInspectable var questionPointer: [Int]? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.questionPointer) as? [Int]
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &AssociatedKeys.questionPointer,
                    newValue as [Int]?,
                    objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }
    
    @IBInspectable var answerTrack: [Int]? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.answerTrack) as? [Int]
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &AssociatedKeys.answerTrack,
                    newValue as [Int]?,
                    objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }
}

extension UITextView {

    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }

}

extension TestQuestionViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}
