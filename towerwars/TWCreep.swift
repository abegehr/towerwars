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
    
    var pathMoveComponent: TWPathMoveComponent {
        guard let pathMoveComponent = component(ofType: TWPathMoveComponent.self) else { fatalError("A Creep entity must have a pathMoveComponent.") }
        return pathMoveComponent
    }
    
    init(position: CGPoint, path: GKPath) {
        super.init()
        
        // nodeComponent
        let radius = Float(15)
        let node = SKShapeNode(circleOfRadius: CGFloat(radius))
        node.position = position
        node.fillColor = .blue
        node.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(radius))
        let nodeComponent = GKSKNodeComponent(node: node)
        addComponent(nodeComponent)
        
        // pathMoveComponent
        let pathMoveComponent = TWPathMoveComponent(maxSpeed: 200, maxAcceleration: Float.random(in: 1 ... 15), radius: Float(radius), path: path)
        addComponent(pathMoveComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
