//
//  RecordLogViewController.swift
//  Sentinel
//
//  Created by Ran Yang on 2020-03-12.
//  Copyright © 2020 ECE1778. All rights reserved.
//

import UIKit
import Charts

class RecordLogViewController: UIViewController {

    @IBOutlet weak var lineChart: LineChartView!
    @IBOutlet weak var maxHR: UILabel!
    @IBOutlet weak var avgHR: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var eventDescription: UITextView!
    @IBOutlet weak var name: UILabel!
    
    let transiton = SlideInTransition()
    var log : Log? = nil
    
    override func viewDidLoad() {
        if (log != nil){
            setUpElements()
        }
        super.viewDidLoad()
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
    
    func setUpElements(){
        name.text = log!.name
        eventDescription.text = log!.eventDescription
        if eventDescription.text.isEmpty {
            eventDescription.isHidden = true
        }
        avgHR.text = String(log!.avgHR)
        maxHR.text = String(log!.maxHR)
        
        let startTime = Date(timeIntervalSince1970: TimeInterval(log!.startTime))
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd (HH:mm:ss)"
        
        self.startTime.text = formatter.string(from: startTime)
        
        duration.text = timeString(from: TimeInterval(log!.endTime - log!.startTime))
        
        if !log!.hrsData.isEmpty {
            setChartValus()
        }
    }
    
    func setChartValus(){
        let referenceTimeInterval = TimeInterval(log!.startTime)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"

        let xValuesNumberFormatter = ChartXAxisFormatter(referenceTimeInterval: referenceTimeInterval, dateFormatter: formatter)
        
        var entries = [ChartDataEntry]()
        
        let splits = log?.hrsData.components(separatedBy: ",")
        
        if splits != nil {
            var timestamp = log!.startTime
            for hrData in splits! {
                if !hrData.isEmpty {
                    let xValue = Double(TimeInterval(timestamp))
                    let yValue = Double(hrData)
                    let entry = ChartDataEntry(x: xValue, y: yValue!)
                    entries.append(entry)
                    timestamp = timestamp + 1
                }
            }
        }
        
        lineChart.xAxis.valueFormatter = xValuesNumberFormatter
//        lineChart.xAxis.labelCount = 12
        lineChart.xAxis.axisMinimum = Double(referenceTimeInterval)
        lineChart.xAxis.axisMaximum = Double(TimeInterval(log!.endTime))
        lineChart.xAxis.labelPosition = XAxis.LabelPosition.bottom
        lineChart.xAxis.labelRotationAngle = 45
        lineChart.xAxis.labelTextColor = UIColor.white
        lineChart.leftAxis.labelTextColor = UIColor.white
    
        lineChart.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        lineChart.legend.enabled = false

        lineChart.rightAxis.enabled = false
        
        let data = LineChartDataSet(entries)
        data.setColors(UIColor.white)
        data.setCircleColors(UIColor.white)
        data.circleRadius = 2.0
        let lineChartData = LineChartData(dataSet: data)
        lineChartData.setDrawValues(false)
        lineChartData.highlightEnabled = false
        lineChart.data = lineChartData
        
    }
}

extension RecordLogViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}

