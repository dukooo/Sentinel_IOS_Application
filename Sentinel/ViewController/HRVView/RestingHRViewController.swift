//
//  RestingHRViewController.swift
//  Sentinel
//
//  Created by Yue Cai on 2020-03-10.
//  Copyright © 2020 ECE1778. All rights reserved.
//

import UIKit
import HealthKit
import Firebase
import Charts

class RestingHRViewController: UIViewController {

    @IBOutlet weak var restingHistory: LineChartView!
    @IBOutlet weak var restingDescription: UITextView!
    
    let transiton = SlideInTransition()
    var restingResult = [[Int]]()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
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
    
    func setUpElements() {
        HealthKitManager.authorizeHealthKit()
        restingDescription.text = Constants.restingDescription
        startIndicator()
        loadRestingHistory()
    }
    
    let health = HKHealthStore()
    let heartRateType:HKQuantityType   = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
    var shownWarning : Bool = false
    
    func getHeartRateData()
    {
        let endTime = Date()
        let startTime = endTime.addingTimeInterval(-2.0)
        print("startTime: \(startTime)")
        print("endTime: \(endTime)")
        let predicate = HKQuery.predicateForSamples(withStart: startTime, end: endTime, options: [])
        let sortDescriptors = [
            NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: true)
        ]
        let heartRateQuery = HKSampleQuery(sampleType: heartRateType,
                                           predicate: predicate,
                                           limit: HKObjectQueryNoLimit,
                                           sortDescriptors: sortDescriptors)
        { (query:HKSampleQuery, results:[HKSample]?, error:Error?) -> Void in
                guard let results = results else { return }
                if results.count == 0 && !self.shownWarning {
                    self.shownWarning = true
                    DispatchQueue.main.async {

                        print("=========================== No data Found OR Access Denied ===========================")
                        self.showNilError()
                    }
                } else {
                    DispatchQueue.main.async {
                        print("=========================== Access Success And Data Found ===========================")
                        guard let samples = results as? [HKQuantitySample],
                            error == nil else {return}
                        let result = samples[0]
                        let heartRateUnit = HKUnit(from: "count/min")
                        let heartRate = result.quantity.doubleValue(for: heartRateUnit)
                        print(heartRate)
                        self.storeRestingHR(hr: Int(heartRate), time: Int(startTime.timeIntervalSince1970))
                    }
            }
        }
        health.execute(heartRateQuery)
    }
    
    func showNilError() {
        stopIndicator()
        let alert = UIAlertController(title: "No Heart Rate Data Found", message: "There was no heart rate data found for current moment. Make sure Health is collecting data from a heart rate sensor. If you expected to see data, it may be that ARTRate is not authorised to read you heart rate data. Please go to the settings app (Privacy -> HealthKit) to change this.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Go to settings", style: .default, handler:  { action in
            if let url = URL(string:UIApplication.openSettingsURLString) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }            }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func storeRestingHR(hr: Int, time: Int) {
        let db = Firestore.firestore()
        db.collection("restingHR").addDocument(data: ["uid": Auth.auth().currentUser!.uid, "timestamp": time, "hr": hr])  {error in
            if error != nil {
                print(error?.localizedDescription ?? "Error when storing test result")
            }
            else {
                print("stored")
                self.loadRestingHistory()
            }
        }
    }
    
    func loadRestingHistory() {
        var result = [[Int]]()
        result = []
        let uid = Auth.auth().currentUser!.uid
        let db = Firestore.firestore()
        db.collection("restingHR").whereField("uid", isEqualTo: uid).getDocuments { (snapshot, err) in
            if (!snapshot!.isEmpty) {
                for doc in snapshot!.documents {
                    result.append([(doc.get("timestamp") as? Int)!, (doc.get("hr") as? Int)!])
                }
                self.restingResult = result.sorted{$0[0] < $1[0]}
                print(self.restingResult)
                self.setUpChart()
            }
        }
    }
    
    func setUpChart(){
        let now = Date()
        let fiveDays = TimeInterval(60 * 60 * 24 * 5)

        let referenceTimeInterval = Date(timeInterval: -fiveDays, since: now).timeIntervalSince1970
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        formatter.locale = Locale.current

        let xValuesNumberFormatter = ChartXAxisFormatter(referenceTimeInterval: referenceTimeInterval, dateFormatter: formatter)
        
        var entries = [ChartDataEntry]()
        for record in restingResult {
            if (TimeInterval(record[0]) > referenceTimeInterval){
                let timeInterval = TimeInterval(record[0])
                let xValue = Double(timeInterval)

                let yValue = record[1]
                let entry = ChartDataEntry(x: xValue, y: Double(yValue))
                entries.append(entry)
            }
            
        }

        restingHistory.xAxis.valueFormatter = xValuesNumberFormatter
        restingHistory.xAxis.labelCount = 12
        restingHistory.xAxis.axisMinimum = Double(referenceTimeInterval)
        restingHistory.xAxis.axisMaximum = Double(now.timeIntervalSince1970)
        restingHistory.xAxis.labelPosition = XAxis.LabelPosition.bottom
        restingHistory.xAxis.labelRotationAngle = 45
        restingHistory.xAxis.labelTextColor = UIColor.white
        restingHistory.leftAxis.labelTextColor = UIColor.white
    
        restingHistory.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        restingHistory.legend.enabled = false

        restingHistory.rightAxis.enabled = false
        
        let data = LineChartDataSet(entries)
        data.setColors(UIColor.white)
        data.setCircleColors(UIColor.white)
        data.circleRadius = 2.0
        let lineChartData = LineChartData(dataSet: data)
        lineChartData.setDrawValues(false)
        lineChartData.highlightEnabled = false
        restingHistory.data = lineChartData
        stopIndicator()
    }
    
    @IBAction func measureTapped(_ sender: Any) {
        startIndicator()
        getHeartRateData()
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

extension RestingHRViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}
