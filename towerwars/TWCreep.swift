//
//  TWCreep.swift
//  towerwars
//
//  Created by Anton Begehr on 30.09.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class TWCreep: GKEntity {
    
    var nodeComponent: GKSKNodeComponent {
        guard let nodeComponent = component(ofType: GKSKNodeComponent.self) else { fatalError("A Creep entity must have a Node component.") }
        return nodeComponent
    }
    
    var agent: TWCreepAgent {
        guard let agent = component(ofType: TWCreepAgent.self) else { fatalError("A Creep entity must have a GKAgent2D component.") }
        return agent
    }
    
    init(position: CGPoint, path: GKPath) {
        super.init()
        
        // node
        let radius = Float(25)
        let node = SKShapeNode(circleOfRadius: CGFloat(radius))
        node.position = position
        node.fillColor = .blue
        node.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(radius))
        let nodeComponent = GKSKNodeComponent(node: node)
        addComponent(nodeComponent)
        
        // agent
        let agent = TWCreepAgent(maxSpeed: 150, maxAcceleration: 5, radius: Float(radius), path: path)
        print()
        addComponent(agent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
