//
//  TestHistoryViewController.swift
//  ECE1778Project
//
//  Created by Yue Cai on 2020-02-03.
//  Copyright © 2020 ECE1778. All rights reserved.
//

import UIKit
import Charts
import Firebase

class TestHistoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{

    
    @IBOutlet weak var resultChart: LineChartView!
    @IBOutlet weak var historyCollection: UICollectionView!
    
    let transiton = SlideInTransition()
    var testIndex : Int = -1
    var testResult = [[Int]]()    
    
    override func viewDidLoad() {
        self.resultChart.isHidden = true
        self.historyCollection.isHidden = true
        setUpElements()
        historyCollection.dataSource = self
        historyCollection.delegate = self
//        resultChart.isUserInteractionEnabled = false
        super.viewDidLoad()
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }

    func setUpElements() {
        var result = [[Int]]()
        result = []
        let uid = Auth.auth().currentUser!.uid
        let db = Firestore.firestore()
        db.collection("tests").whereField("uid", isEqualTo: uid).whereField("index", isEqualTo: testIndex).getDocuments { (snapshot, err) in
            if (!snapshot!.isEmpty) {
                for doc in snapshot!.documents {
                    result.append([(doc.get("timestamp") as? Int)!, (doc.get("score") as? Int)!])
                }
                self.testResult = result.sorted{$0[0] < $1[0]}
                print(self.testResult)
                self.setChartValus()
                self.historyCollection.reloadData()
                self.resultChart.isHidden = false
                self.historyCollection.isHidden = false

            }
        }
    }
    
    func setChartValus(){
        let now = Date()
        let oneYear = TimeInterval(60 * 60 * 24 * 365)

        let referenceTimeInterval = Date(timeInterval: -oneYear, since: now).timeIntervalSince1970
        
        let formatter = DateFormatter()
           formatter.dateStyle = .short
           formatter.timeStyle = .none
           formatter.locale = Locale.current

           let xValuesNumberFormatter = ChartXAxisFormatter(referenceTimeInterval: referenceTimeInterval, dateFormatter: formatter)
        
        var entries = [ChartDataEntry]()
        for record in testResult {
            if (TimeInterval(record[0]) > referenceTimeInterval){
                let timeInterval = TimeInterval(record[0])
                let xValue = Double(timeInterval)

                let yValue = record[1]
                let entry = ChartDataEntry(x: xValue, y: Double(yValue))
                entries.append(entry)
            }
            
        }

        resultChart.xAxis.valueFormatter = xValuesNumberFormatter
        resultChart.xAxis.labelCount = 12
        resultChart.xAxis.axisMinimum = Double(referenceTimeInterval)
        resultChart.xAxis.axisMaximum = Double(now.timeIntervalSince1970)
        resultChart.xAxis.labelPosition = XAxis.LabelPosition.bottom
        resultChart.xAxis.labelRotationAngle = 45
        resultChart.xAxis.labelTextColor = UIColor.white
        resultChart.leftAxis.labelTextColor = UIColor.white
    
        resultChart.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        resultChart.legend.enabled = false

        resultChart.rightAxis.enabled = false
        
        let data = LineChartDataSet(entries)
        data.setColors(UIColor.white)
        data.setCircleColors(UIColor.white)
        data.circleRadius = 2.0
        let lineChartData = LineChartData(dataSet: data)
        lineChartData.setDrawValues(false)
        lineChartData.highlightEnabled = false
        resultChart.data = lineChartData
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToTestHome" {
            let testVC = segue.destination as! TestViewController
            let testIndex = sender as! Int
            testVC.testIndex = testIndex
        }
    }
    
    @IBAction func bactButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "backToTestHome", sender: testIndex)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        testResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "historyCell", for: indexPath) as! HistoryCell
        cell.result = testResult[testResult.count - indexPath.item - 1]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "testResultVC") as? TestResultViewController
        vc?.score = testResult[testResult.count - indexPath.item - 1][1]
        vc?.testIndex = testIndex
        vc?.fromHistory = true
        view.window?.rootViewController = vc
        view.window?.makeKeyAndVisible()
    }
    
}

extension TestHistoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: (collectionView.frame.size.height - 40)/5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension TestHistoryViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}
