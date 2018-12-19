//
//  TWCastleComponent.swift
//  towerwars
//
//  Created by Anton Begehr on 13.11.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//

import SpriteKit
import GameplayKit

class TWCastleComponent: GKComponent {
    
    let entityManager: TWEntityManager
    var coins: Int
    
    init(entityManager: TWEntityManager, coins: Int = 10) {
        self.entityManager = entityManager
        self.coins = coins
        
        super.init()
        
        // earn a coin every second
        _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.coins += 1
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func spawnCreep() {
        guard let spriteComponent = entity?.component(ofType: TWSpriteComponent.self) else {
            return
        }
        
        let position = CGPoint(x: spriteComponent.node.position.x, y: spriteComponent.node.position.y)

        spawnCreep(at: position)
    }
    
    func spawnCreep(at position: CGPoint) {
        guard let team = entity?.component(ofType: TWTeamComponent.self)?.team else {
            return
        }
        
        // randomly decide which creep to spawn
        var newCreep: TWCreep
        if Float.random(in: 0..<1) >= 0.33 {
            // hybrid creep
            newCreep = TWHybridCreep(position: position, team: team, entityManager: entityManager)
        } else {
            // normal creep
            newCreep = TWCreep(radius: 15.0, fillColor: .yellow, strokeColor: .red, strength: 1.0, health: 3.0, showHealthbar: true, position: position, team: team, entityManager: entityManager)
        }
        
        if let pathComponent = entity?.component(ofType: TWPathComponent.self) {
            newCreep.addComponent(pathComponent)
        }
        
        entityManager.add(newCreep)
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
                if let castleHealthComponent = entity?.component(ofType: TWHealthComponent.self), let enemyHitComponent = enemyCreep.component(ofType: TWHitComponent.self) {
                    castleHealthComponent.takeDamage(enemyHitComponent.strength)
                }
            }
        }
        
    }
    
}

