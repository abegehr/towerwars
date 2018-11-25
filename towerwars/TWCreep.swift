//
//  TWCreep.swift
//  towerwars
//
//  Created by Anton Begehr on 30.09.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//

import SpriteKit
import GameplayKit

class TWCreep: GKEntity {
    
    var spriteComponent: TWSpriteComponent {
        guard let spriteComponent = component(ofType: TWSpriteComponent.self) else { fatalError("A Creep entity must have a TWSpriteComponent.") }
        return spriteComponent
    }
    
    var pathMoveComponent: TWPathMoveComponent {
        guard let pathMoveComponent = component(ofType: TWPathMoveComponent.self) else { fatalError("A Creep entity must have a TWPathMoveComponent.") }
        return pathMoveComponent
    }
    
    var teamComponent: TWTeamComponent {
        guard let teamComponent = component(ofType: TWTeamComponent.self) else { fatalError("A Creep entity must have a TWTeamComponent.") }
        return teamComponent
    }
    
    var creepPhysicsComponent: TWCreepPhysicsComponent {
        guard let teamComponent = component(ofType: TWCreepPhysicsComponent.self) else { fatalError("A Creep entity must have a TWCreepPhysicsComponent.") }
        return creepPhysicsComponent
    }
    
    
    
    init(position: CGPoint, team: Team) {
        super.init()
        
        // spriteComponent
        let radius = Float(15)
        let node = SKShapeNode(circleOfRadius: CGFloat(radius))
        node.position = position
        node.fillColor = .blue
        node.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(radius))
        let spriteComponent = TWSpriteComponent(node: node)
        addComponent(spriteComponent)
        //to access the entity later:
        spriteComponent.addToNodeKey()
        
        // pathMoveComponent
        let pathMoveComponent = TWPathMoveComponent(maxSpeed: 200, maxAcceleration: Float.random(in: 1 ... 15), radius: Float(radius))
        addComponent(pathMoveComponent)
        
        // teamComponent
        let teamComponent = TWTeamComponent(team: team)
        addComponent(teamComponent)
        
        //physicsComponent
        let creepPhysicsComponent = TWCreepPhysicsComponent(spriteComponent: spriteComponent)
        addComponent(creepPhysicsComponent)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
