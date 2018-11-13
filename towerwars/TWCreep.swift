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
    
    var nodeComponent: TWSpriteComponent {
        guard let nodeComponent = component(ofType: TWSpriteComponent.self) else { fatalError("A Creep entity must have a TWSpriteComponent.") }
        return nodeComponent
    }
    
    var pathMoveComponent: TWPathMoveComponent {
        guard let pathMoveComponent = component(ofType: TWPathMoveComponent.self) else { fatalError("A Creep entity must have a TWPathMoveComponent.") }
        return pathMoveComponent
    }
    
    var teamComponent: TWTeamComponent {
        guard let teamComponent = component(ofType: TWTeamComponent.self) else { fatalError("A Creep entity must have a TWTeamComponent.") }
        return teamComponent
    }
    
    init(position: CGPoint, path: GKPath, team: Team) {
        super.init()
        
        // nodeComponent
        let radius = Float(15)
        let node = SKShapeNode(circleOfRadius: CGFloat(radius))
        node.position = position
        node.fillColor = .blue
        node.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(radius))
        let nodeComponent = TWSpriteComponent(node: node)
        addComponent(nodeComponent)
        
        // pathMoveComponent
        let pathMoveComponent = TWPathMoveComponent(maxSpeed: 200, maxAcceleration: Float.random(in: 1 ... 15), radius: Float(radius), path: path)
        addComponent(pathMoveComponent)
        
        // teamComponent
        let teamComponent = TWTeamComponent(team: team)
        addComponent(teamComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
