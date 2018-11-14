//
//  TWCastleComponent.swift
//  towerwars
//
//  Created by Anton Begehr on 13.11.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class TWCastleComponent: GKComponent {
    
    let entityManager: TWEntityManager
    
    init(entityManager: TWEntityManager) {
        self.entityManager = entityManager
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {

        super.update(deltaTime: seconds)
        
        // Get required components
        guard let teamComponent = entity?.component(ofType: TWTeamComponent.self),
            let spriteComponent = entity?.component(ofType: TWSpriteComponent.self) else {
                return
        }
        
        // Loop through enemy entities
        let enemyCreeps = entityManager.creepsForTeam(teamComponent.team.oppositeTeam())
        for enemyCreep in enemyCreeps {
            
            // Get required components
            guard let enemySpriteComponent = enemyCreep.component(ofType: TWSpriteComponent.self) else {
                continue
            }
            
            // Check for intersection
            if (spriteComponent.node.calculateAccumulatedFrame().intersects(enemySpriteComponent.node.calculateAccumulatedFrame())) {
                // if enemyCreep reached castle
                // remove enemyCreep
                entityManager.remove(enemyCreep)
                // decrease castle health
                if let castleHealthComponent = entity?.component(ofType: TWHealthComponent.self) {
                    castleHealthComponent.takeDamage(2) //TODO: determine damage by using a TWHitComponent
                }
            }
        }
        
    }
    
}

