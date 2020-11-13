//
//  Log.swift
//  Sentinel
//
//  Created by Ran Yang on 2020-03-12.
//  Copyright © 2020 ECE1778. All rights reserved.
//


import Foundation

class Log: NSObject {
    var uid: String
    var name: String
    var eventDescription: String
    var hrsData: String
    var startTime: Int
    var endTime: Int
    var maxHR: Double
    var avgHR: Double
    
        
    init?(data: [String: Any]) {
        self.uid = data["uid"] as! String
        self.name = data["name"] as! String
        self.eventDescription = data["description"] as! String
        self.hrsData = data["hrsData"] as! String
        self.startTime = data["startTime"] as! Int
        self.endTime = data["endTime"] as! Int
        self.maxHR = data["maxHR"] as! Double
        self.avgHR = data["avgHR"] as! Double
    }
    
    func getMap() -> [String: Any] {
        return ["uid": uid,
                "name": name,
                "description": eventDescription,
                "hrsData": hrsData,
                "startTime": startTime,
                "endTime": endTime,
                "maxHR": maxHR,
                "avgHR": avgHR]
    }
    
}

