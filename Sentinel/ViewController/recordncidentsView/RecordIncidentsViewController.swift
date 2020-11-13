//
//  HRRecordingViewController.swift
//  Sentinel
//
//  Created by Ran Yang on 2020-03-05.
//  Copyright © 2020 ECE1778. All rights reserved.
//

import UIKit
import HealthKit
import Firebase


class RecordIncidentsViewController: UIViewController{

    @IBOutlet weak var menu: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var start: UIButton!
    @IBOutlet weak var end: UIButton!
    @IBOutlet weak var time: UILabel!

    let transiton = SlideInTransition()
    var stopwatch : Stopwatch? = nil
    var startTime : Date? = nil
    var endTime : Date? = nil
    var heartRateSet : [Double] = []
    var heartRateString : String = ""
    var maxHR : Double = 0.0
    var avgHR : Double = 0.0
    
    override func viewDidLoad() {
        HealthKitManager.authorizeHealthKit()
        super.viewDidLoad()
        end.isHidden = true
        time.isHidden = true
        stopwatch = Stopwatch { (timeInterval) in
            self.time.text = self.timeString(from :timeInterval)
        }
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }
    private func timeString(from timeInterval: TimeInterval) -> String {
        let seconds = Int(timeInterval.truncatingRemainder(dividingBy: 60))
        let minutes = Int(timeInterval.truncatingRemainder(dividingBy: 60 * 60) / 60)
        let hours = Int(timeInterval / 3600)
        return String(format: "%.2d:%.2d:%.2d", hours, minutes, seconds)
    }
    
    deinit {
        stopwatch!.stop()
    }
    
    @IBAction func startBtnTapped(_ sender: Any) {
        label.text = "Recording..."
        label.font = UIFont(name: "Helvetica Neue", size: 30 )
        start.isHidden = true
        end.isHidden = false
        time.isHidden = false
        stopwatch!.toggle()
//        startTime = Calendar.current.date(byAdding: .minute, value: -10, to: Date())
        self.startTime = Date()
    }

    @IBAction func endBtnTapped(_ sender: Any) {
        stopwatch!.stop()
        self.endTime = Date()
        self.getHeartRateData()
        
    }

    let health = HKHealthStore()
    let heartRateType:HKQuantityType   = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
    var shownWarning : Bool = false

    func getHeartRateData()
    {
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
 
            // For test ....
//            DispatchQueue.main.async {
//                self.heartRateSet = [60.0, 80.0, 77.0, 67.0, 90.0, 100.0, 98.0, 99.0, 100.0, 110.0, 115.0, 116.0, 116.0, 116.0, 116.0, 115.0, 113.0, 110.0, 110.0, 112.0]
//                var sumHR = 0.0
//                for heartRate in self.heartRateSet {
//                    self.maxHR = max(self.maxHR, heartRate)
//                    sumHR = sumHR + heartRate
//                    self.heartRateString = self.heartRateString + String(heartRate) + ","
//                }
//                self.avgHR = sumHR / Double(self.heartRateSet.count)
//
//                let vc = self.storyboard?.instantiateViewController(identifier: "saveRecordVC") as? SaveRecordViewController
//
//                vc?.startTime = self.startTime
//                vc?.endTime = self.endTime
//                vc?.heartRateString = self.heartRateString
//                vc?.avgHR = self.avgHR
//                vc?.maxHR = self.maxHR
//                print("---------------------------------")
//                print(self.startTime)
//                print(self.endTime)
//                print(self.heartRateString)
//                print(self.avgHR)
//                print(self.maxHR)
//                print("---------------------------------")
//
//                self.view.window?.rootViewController = vc
//            }
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
                        var sumHR = 0.0
                        for result in samples {
                            let heartRateUnit = HKUnit(from: "count/min")
                            let heartRate = result.quantity.doubleValue(for: heartRateUnit)
                            print(heartRate)
                            self.maxHR = max(self.maxHR, heartRate)
                            sumHR = sumHR + heartRate
                            self.heartRateSet.append(heartRate)
                            self.heartRateString = self.heartRateString + String(heartRate) + ","
                        }
                        self.avgHR = sumHR / Double(samples.count)

                        let vc = self.storyboard?.instantiateViewController(identifier: "saveRecordVC") as? SaveRecordViewController

                        vc?.startTime = self.startTime
                        vc?.endTime = self.endTime
                        vc?.heartRateString = self.heartRateString
                        vc?.avgHR = self.avgHR
                        vc?.maxHR = self.maxHR
                        self.view.window?.rootViewController = vc
                        self.view.window?.makeKeyAndVisible()
                    }
            }
        }
        health.execute(heartRateQuery)
    }
    
    func showNilError() {
        let alert = UIAlertController(title: "No Heart Rate Data Found", message: "There was no heart rate data found for the selected time.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
//        alert.addAction(UIAlertAction(title: "Go to settings", style: .default, handler:  { action in
//            if let url = URL(string:UIApplication.openSettingsURLString) {
//                if UIApplication.shared.canOpenURL(url) {
//                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
//                }
//            }            }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension RecordIncidentsViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}

