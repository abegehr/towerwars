//
//  TWBuildTowerComponent.swift
//  towerwars
//
//  Created by Anton Begehr on 28.11.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//

import SpriteKit
import GameplayKit

class TWBuildTowerComponent: GKComponent {
    
    let entityManager: TWEntityManager
    
    init(entityManager: TWEntityManager) {
        self.entityManager = entityManager
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @discardableResult func buildTower(team: Team) -> Bool {
        // get components
        let castle = entityManager.castleForTeam(team)
        guard let castleComponent = castle?.component(ofType: TWCastleComponent.self),
            let spriteComponent = entity?.component(ofType: TWSpriteComponent.self) else {
            return false
        }
        
        // enough coins?
        let cost = 10
        if (castleComponent.coins >= cost) {
            // enough coins
            castleComponent.coins -= cost
            
            // building tower
            let position = spriteComponent.node.position
            entityManager.buildTower(type: .arrow, posX: position.x, posY: position.y, team: .team1)
            
            return true
        } else {
            // not enough coins
            if let spriteComponent = entity?.component(ofType: TWSpriteComponent.self) {
                // show not enough coins error
                let label = SKLabelNode(fontNamed: "Arial")
                label.text = "10 coins"
                label.fontSize = 18
                label.fontColor = SKColor.red
                spriteComponent.node.addChild(label)
                
                let fade_in = SKAction.group([SKAction.scale(to: 2, duration: 0.4), SKAction.fadeIn(withDuration: 0.4)])
                let fade_out = SKAction.group([SKAction.scale(to: 1, duration: 0.4), SKAction.fadeOut(withDuration: 0.4)])
                let label_action = SKAction.sequence([fade_in, fade_out, SKAction.removeFromParent()])
                
                label.run(label_action)
            }
        }
        
        return false
    }
    
}
