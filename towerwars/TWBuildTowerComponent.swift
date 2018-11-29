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
        let cost = 100
        if (castleComponent.coins >= cost) {
            let position = spriteComponent.node.position
            print("building tower at: ", position)
            
            castleComponent.coins -= cost
            
            entityManager.buildTower(type: "arrow", posX: position.x, posY: position.y, team: .team1)
            
            return true
        }
        
        return false
    }
    
}


