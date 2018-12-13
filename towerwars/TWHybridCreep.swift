//
//  TWHybridCreep.swift
//  towerwars
//
//  Created by Anton Begehr on 13.12.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//

import SpriteKit
import GameplayKit

class TWHybridCreep: TWCreep {
    
    init(position: CGPoint, team: Team, entityManager: TWEntityManager) {
        
        super.init(position:position, team: team, entityManager: entityManager)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func kill() {
        // remove entity
        entityManager.remove(self)
        
        // TODO: spawn two minicreeps
        // get necessary components
        if let spriteComponent = component(ofType: TWSpriteComponent.self),
            let teamComponent = component(ofType: TWTeamComponent.self),
            let pathComponent = component(ofType: TWPathComponent.self) {
            
            for _ in [0, 1] {
                let miniCreep = TWMiniCreep(position: spriteComponent.node.position, team: teamComponent.team, entityManager: entityManager)
                
                miniCreep.addComponent(pathComponent)
                
                entityManager.add(miniCreep)
            }
        }
    }
    
}
