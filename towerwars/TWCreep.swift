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
        guard let creepPhysicsComponent = component(ofType: TWCreepPhysicsComponent.self) else { fatalError("A Creep entity must have a TWCreepPhysicsComponent.") }
        return creepPhysicsComponent
    }
    
    
    
    init(position: CGPoint, team: Team, entityManager: TWEntityManager) {
        super.init()
        
        // spriteComponent
        let radius = Float(15)
        /*let node = SKShapeNode(circleOfRadius: CGFloat(radius))
        node.fillColor = .blue
        node.position = position*/

        //todo with texture
        let texture = SKTexture(imageNamed: "quirk1")
        let node = SKSpriteNode(texture: texture, color: .white, size: texture.size())
        node.position = position
        
        let spriteComponent = TWSpriteComponent(node: node)
        addComponent(spriteComponent)
        //to access the entity later:
        spriteComponent.addToNodeKey()
        
        //physicsComponent
        let creepPhysicsComponent = TWCreepPhysicsComponent(spriteComponent: spriteComponent)
        addComponent(creepPhysicsComponent)
        
        //healthComponent
        let healthComponent = TWHealthComponent(parentNode: self.component(ofType: TWSpriteComponent.self)!.node, barWidth: 50.0, barOffset: 25.0, health: 2.0, entityManager: entityManager)
        addComponent(healthComponent)
        
        // pathMoveComponent
        let pathMoveComponent = TWPathMoveComponent(maxSpeed: 200, maxAcceleration: Float.random(in: 1 ... 15), radius: Float(radius))
        addComponent(pathMoveComponent)
        
        // teamComponent
        let teamComponent = TWTeamComponent(team: team)
        addComponent(teamComponent)
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
