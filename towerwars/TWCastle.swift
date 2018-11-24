//
//  TWCastle.swift
//  towerwars
//
//  Created by Anton Begehr on 01.11.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//

import SpriteKit
import GameplayKit

class TWCastle: GKEntity {
    
    var spriteComponent: TWSpriteComponent {
        guard let spriteComponent = component(ofType: TWSpriteComponent.self) else { fatalError("A Castle entity must have a TWSpriteComponent.") }
        return spriteComponent
    }
    
    var castleComponent: TWCastleComponent {
        guard let castleComponent = component(ofType: TWCastleComponent.self) else { fatalError("A Castle entity must have a TWCastleComponent.") }
        return castleComponent
    }
    
    init(color: UIColor, position: CGPoint, team: Team, entityManager: TWEntityManager) {
        super.init()
        
        // spriteComponent
        let size = CGSize(width: 100, height: 100)
        let node = SKShapeNode(rectOf: size)
        node.position = position
        node.fillColor = color
        node.zPosition = 100
        
        // spriteComponent
        let spriteComponent = TWSpriteComponent(node: node, texture: nil)
        addComponent(spriteComponent)
        
        // teamComponent
        let teamComponent = TWTeamComponent(team: team)
        addComponent(teamComponent)
        
        // castleComponent
        let castleComponent = TWCastleComponent(entityManager: entityManager)
        addComponent(castleComponent)
        
        // healthComponent
        let healthComponent = TWHealthComponent(parentNode: spriteComponent.node, barWidth: 100, barOffset: 0, health: 100, entityManager: entityManager)
        addComponent(healthComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
