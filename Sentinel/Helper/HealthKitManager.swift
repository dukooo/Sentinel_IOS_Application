//
//  HealthKitManager.swift
//  Sentinel
//
//  Created by Ran Yang on 2020-03-08.
//  Copyright © 2020 ECE1778. All rights reserved.
//

import Foundation
import HealthKit

class HealthKitManager: NSObject {

  static let healthKitStore = HKHealthStore()

  static func authorizeHealthKit() {

    let healthKitTypes: Set = [
        HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!,
//        HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!
    ]

    healthKitStore.requestAuthorization(toShare: healthKitTypes,
                                        read: healthKitTypes) { _, _ in }
  }
}
