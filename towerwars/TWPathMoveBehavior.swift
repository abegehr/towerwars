//
//  TWCreepBehavior.swift
//  towerwars
//
//  Created by Anton Begehr on 18.10.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//

import Foundation
import GameplayKit

class TWPathMoveBehavior: GKBehavior {
    init(targetSpeed: Float, path: GKPath) {
        super.init()
        
        if (targetSpeed > 0) {
            setWeight(1.0, for: GKGoal(toReachTargetSpeed: targetSpeed))
            setWeight(1.0, for: GKGoal(toStayOn: path, maxPredictionTime: 1.0))
            setWeight(1.0, for: GKGoal(toFollow: path, maxPredictionTime: 1.0, forward: true))
        }
    }
}
