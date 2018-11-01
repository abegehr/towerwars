//
//  TWCreepAgent.swift
//  towerwars
//
//  Created by Anton Begehr on 17.10.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//

import Foundation
import GameplayKit

class TWPathMoveComponent: GKAgent2D, GKAgentDelegate {
    
    init(maxSpeed: Float, maxAcceleration: Float, radius: Float, path: GKPath) {
        super.init()
        
        self.delegate = self
        self.maxSpeed = maxSpeed
        self.maxAcceleration = maxAcceleration
        self.radius = radius
        self.mass = 0.01
        
        // behavior
        behavior = TWPathMoveBehavior(targetSpeed: maxSpeed, path: path)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func agentWillUpdate(_ agent: GKAgent) {
        guard let creep = entity?.component(ofType: GKSKNodeComponent.self) else {
            return
        }
        
        position = float2(x: Float(creep.node.position.x), y: Float(creep.node.position.y))
    }
    
    func agentDidUpdate(_ agent: GKAgent) {
        guard let creep = entity?.component(ofType: GKSKNodeComponent.self) else {
            return
        }
        
        creep.node.position = CGPoint(x: CGFloat(position.x), y: CGFloat(position.y))
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
    }
}
