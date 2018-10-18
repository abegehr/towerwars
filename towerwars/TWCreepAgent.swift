//
//  TWCreepAgent.swift
//  towerwars
//
//  Created by Anton Begehr on 17.10.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//

import Foundation
import GameplayKit

class TWCreepAgent: GKAgent2D, GKAgentDelegate {
    
    init(maxSpeed: Float, maxAcceleration: Float, radius: Float, path: GKPath) {
        super.init()
        
        self.delegate = self
        self.maxSpeed = maxSpeed
        self.maxAcceleration = maxAcceleration
        self.radius = radius
        print(self.mass)
        self.mass = 0.01
        
        // behavior
        behavior = TWCreepBehavior(targetSpeed: maxSpeed, path: path)
        print("TWCreepAgent - behavior: ", behavior!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func agentWillUpdate(_ agent: GKAgent) {
        print("agentWillUpdate")
        print("agentWillUpdate - entity: ", entity!)
        
        guard let creep = entity?.component(ofType: TWCreepNodeComponent.self) else {
            return
        }
        
        position = float2(x: Float(creep.node.position.x), y: Float(creep.node.position.y))
        
        print("agentWillUpdate - position: ", position)
    }
    
    func agentDidUpdate(_ agent: GKAgent) {
        print("agentDidUpdate - entity: ", entity!)
        print("agentDidUpdate")
        
        guard let creep = entity?.component(ofType: TWCreepNodeComponent.self) else {
            return
        }
        
        creep.node.position = CGPoint(x: CGFloat(position.x), y: CGFloat(position.y))
        
        print("agentDidUpdate - position: ", position)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        print("agent update - self: ", self)
        
        guard let entity = entity else {
            return
        }
        
        print("agent update - entity: ", entity)
        
        behavior = self.behavior
    }
}
