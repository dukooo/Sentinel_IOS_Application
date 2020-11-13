//
//  ReportViewController.swift
//  Sentinel
//
//  Created by Yue Cai on 2020-03-29.
//  Copyright © 2020 ECE1778. All rights reserved.
//

import UIKit
import Firebase

class ReportViewController: UIViewController {

    @IBOutlet weak var ptsd: UILabel!
    @IBOutlet weak var stress: UILabel!
    @IBOutlet weak var support: UILabel!
    @IBOutlet weak var depression: UILabel!
    @IBOutlet weak var anxiety: UILabel!
    @IBOutlet weak var restinghr: UILabel!
    @IBOutlet weak var maxhr: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var back: UIButton!
    
    let transiton = SlideInTransition()
    let db = Firestore.firestore()
    let uid = Auth.auth().currentUser!.uid
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        back.layer.cornerRadius = 10
        startIndicator()
        setUpptsd()
    }
    
    func setUpptsd() {
        var result = [[Int]]()
        result = []
        db.collection("tests").whereField("uid", isEqualTo: uid).whereField("index", isEqualTo: 0).getDocuments { (snapshot, err) in
            if (!snapshot!.isEmpty) {
                for doc in snapshot!.documents {
                    result.append([(doc.get("timestamp") as? Int)!, (doc.get("score") as? Int)!])
                }
                let test = result.sorted{$0[0] < $1[0]}.last
                if test != nil {
                    let date = Date(timeIntervalSince1970: TimeInterval(test![0]))
                    let formatter = DateFormatter()
                    formatter.dateStyle = .short
                    formatter.timeStyle = .none
                    formatter.locale = Locale.current
                    self.ptsd.text = "\(test![1])/80 (\(formatter.string(from: date)))"
                }
            }
            self.setUpstress()
        }
    }
    
    func setUpstress() {
        var result = [[Int]]()
        result = []
        db.collection("tests").whereField("uid", isEqualTo: uid).whereField("index", isEqualTo: 1).getDocuments { (snapshot, err) in
            if (!snapshot!.isEmpty) {
                for doc in snapshot!.documents {
                    result.append([(doc.get("timestamp") as? Int)!, (doc.get("score") as? Int)!])
                }
                let test = result.sorted{$0[0] < $1[0]}.last
                if test != nil {
                    let date = Date(timeIntervalSince1970: TimeInterval(test![0]))
                    let formatter = DateFormatter()
                    formatter.dateStyle = .short
                    formatter.timeStyle = .none
                    formatter.locale = Locale.current
                    self.stress.text = "\(test![1])/280 (\(formatter.string(from: date)))"
                }
            }
            self.setUpsupport()
        }
    }
    
    func setUpsupport() {
        var result = [[Int]]()
        result = []
        db.collection("tests").whereField("uid", isEqualTo: uid).whereField("index", isEqualTo: 2).getDocuments { (snapshot, err) in
            if (!snapshot!.isEmpty) {
                for doc in snapshot!.documents {
                    result.append([(doc.get("timestamp") as? Int)!, (doc.get("score") as? Int)!])
                }
                let test = result.sorted{$0[0] < $1[0]}.last
                if test != nil {
                    let date = Date(timeIntervalSince1970: TimeInterval(test![0]))
                    let formatter = DateFormatter()
                    formatter.dateStyle = .short
                    formatter.timeStyle = .none
                    formatter.locale = Locale.current
                    self.support.text = "\(test![1])/120 (\(formatter.string(from: date)))"
                }
            }
            self.setUpdepression()
        }
    }
    
    func setUpdepression() {
        var result = [[Int]]()
        result = []
        db.collection("tests").whereField("uid", isEqualTo: uid).whereField("index", isEqualTo: 3).getDocuments { (snapshot, err) in
            if (!snapshot!.isEmpty) {
                for doc in snapshot!.documents {
                    result.append([(doc.get("timestamp") as? Int)!, (doc.get("score") as? Int)!])
                }
                let test = result.sorted{$0[0] < $1[0]}.last
                if test != nil {
                    let date = Date(timeIntervalSince1970: TimeInterval(test![0]))
                    let formatter = DateFormatter()
                    formatter.dateStyle = .short
                    formatter.timeStyle = .none
                    formatter.locale = Locale.current
                    self.depression.text = "\(test![1])/42 (\(formatter.string(from: date)))"
                }
            }
            self.setUpanxiety()
        }
    }

    func setUpanxiety() {
        var result = [[Int]]()
        result = []
        db.collection("tests").whereField("uid", isEqualTo: uid).whereField("index", isEqualTo: 4).getDocuments { (snapshot, err) in
            if (!snapshot!.isEmpty) {
                for doc in snapshot!.documents {
                    result.append([(doc.get("timestamp") as? Int)!, (doc.get("score") as? Int)!])
                }
                let test = result.sorted{$0[0] < $1[0]}.last
                if test != nil {
                    let date = Date(timeIntervalSince1970: TimeInterval(test![0]))
                    let formatter = DateFormatter()
                    formatter.dateStyle = .short
                    formatter.timeStyle = .none
                    formatter.locale = Locale.current
                    self.anxiety.text = "\(test![1])/42 (\(formatter.string(from: date)))"
                }
            }
            self.setUpresting()
        }
    }
    
    func setUpresting() {
        var result = [Int]()
        result = []
        let now = Date()
        let oneMonth = TimeInterval(60 * 60 * 24 * 30)
        let referenceTimeInterval = (Int)(Date(timeInterval: -oneMonth, since: now).timeIntervalSince1970)
        db.collection("restingHR").whereField("uid", isEqualTo: uid).getDocuments { (snapshot, err) in
            if (!snapshot!.isEmpty) {
                for doc in snapshot!.documents {
                    if ((doc.get("timestamp") as? Int)!) >= referenceTimeInterval {
                        result.append((doc.get("hr") as? Int)!)
                    }
                }
                self.restinghr.text = "\((result.reduce(0, +)) / (result.count)) bpm"
            }
            self.setUpmax()
        }
    }
    
    func setUpmax() {
        var result = [Int]()
        var time = [Int]()
        result = []
        time = []
        let now = Date()
        let oneMonth = TimeInterval(60 * 60 * 24 * 30)
        let referenceTimeInterval = (Int)(Date(timeInterval: -oneMonth, since: now).timeIntervalSince1970)
        db.collection("incidentsHR").whereField("uid", isEqualTo: uid).getDocuments { (snapshot, err) in
            if (!snapshot!.isEmpty) {
                for doc in snapshot!.documents {
                    if ((doc.get("startTime") as? Int)!) >= referenceTimeInterval {
                        result.append((doc.get("maxHR") as? Int)!)
                        time.append(((doc.get("endTime") as? Int)!) - (doc.get("startTime") as? Int)!)
                    }
                }
                self.duration.text = "\(self.timeString(from: TimeInterval((time.reduce(0, +)) / (time.count))))"
                self.maxhr.text = "\((result.reduce(0, +)) / (result.count)) bpm"
            }
            self.stopIndicator()
        }
    }
    
    private func timeString(from timeInterval: TimeInterval) -> String {
        let seconds = Int(timeInterval.truncatingRemainder(dividingBy: 60))
        let minutes = Int(timeInterval.truncatingRemainder(dividingBy: 60 * 60) / 60)
        let hours = Int(timeInterval / 3600)
        return String(format: "%.2d:%.2d:%.2d", hours, minutes, seconds)
    }

    @IBAction func menuButtonTapped(_ sender: Any) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
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
}

extension ReportViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}
