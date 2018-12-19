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
    
    let entityManager: TWEntityManager
    
    var spriteComponent: TWSpriteComponent {
        guard let spriteComponent = component(ofType: TWSpriteComponent.self) else { fatalError("A Creep entity must have a TWSpriteComponent.") }
        return spriteComponent
    }
    
    var inRangesComponent: TWInRangesComponent {
        guard let inRangesComponent = component(ofType: TWInRangesComponent.self) else { fatalError("A Creep entity must have a TWInRangesComponent.") }
        return inRangesComponent
    }
    
    var healthComponent: TWHealthComponent {
        guard let healthComponent = component(ofType: TWHealthComponent.self) else { fatalError("A Creep entity must have a TWHealthComponent.") }
        return healthComponent
    }
    
    var pathMoveComponent: TWPathMoveComponent {
        guard let pathMoveComponent = component(ofType: TWPathMoveComponent.self) else { fatalError("A Creep entity must have a TWPathMoveComponent.") }
        return pathMoveComponent
    }
    
    var teamComponent: TWTeamComponent {
        guard let teamComponent = component(ofType: TWTeamComponent.self) else { fatalError("A Creep entity must have a TWTeamComponent.") }
        return teamComponent
    }
    
    init(health: CGFloat = 2.0, showHealthbar: Bool = true, node: SKNode, team: Team, entityManager: TWEntityManager) {
        self.entityManager = entityManager
        
        super.init()
        
        // physicsBody
        let physicsBody = node.physicsBody ?? SKPhysicsBody(circleOfRadius: 15)
        physicsBody.isDynamic = true
        physicsBody.collisionBitMask = mapBitMask
        node.physicsBody = physicsBody
        
        // spriteComponent
        let spriteComponent = TWSpriteComponent(node: node)
        addComponent(spriteComponent)
        
        // inRangesComponent
        let inRangesComponent = TWInRangesComponent()
        addComponent(inRangesComponent)
        
        // healthComponent
        var barWidth = 50.0
        if !showHealthbar {
            barWidth = 0.0
        }
        let healthComponent = TWHealthComponent(parentNode: self.component(ofType: TWSpriteComponent.self)!.node, barWidth: CGFloat(barWidth), barOffset: 25.0, health: health)
        addComponent(healthComponent)
        
        // pathMoveComponent
        let pathMoveComponent = TWPathMoveComponent(maxSpeed: 200, maxAcceleration: Float.random(in: 1 ... 15))
        addComponent(pathMoveComponent)
        
        // teamComponent
        let teamComponent = TWTeamComponent(team: team)
        addComponent(teamComponent)
    }
    
    convenience init(radius: CGFloat = 15, fillColor: UIColor = .blue, strokeColor: UIColor = TWPink, health: CGFloat = 2.0, showHealthbar: Bool = true, position: CGPoint, team: Team, entityManager: TWEntityManager) {
        
        // node
        let node = SKShapeNode(circleOfRadius: radius)
        node.fillColor = fillColor
        node.strokeColor = strokeColor
        node.position = position
        node.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        
        self.init(health: health, showHealthbar: showHealthbar, node: node, team: team, entityManager: entityManager)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func kill() {
        // remove entity
        entityManager.remove(self)
    }
    
}
