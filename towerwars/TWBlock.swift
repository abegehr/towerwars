//
//  TWBlock.swift
//  towerwars
//
//  Created by Anton Begehr on 18.10.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//

import SpriteKit
import GameplayKit

class TWBlock: GKEntity {
    
    let entityManager: TWEntityManager
    
    var spriteComponent: TWSpriteComponent {
        guard let spriteComponent = component(ofType: TWSpriteComponent.self) else { fatalError("A Block entity must have a TWSpriteComponent.") }
        return spriteComponent
    }
    
    init(node: SKNode, position: CGPoint, entityManager: TWEntityManager) {
        
        self.entityManager = entityManager
        
        super.init()
        
        // spriteComponent
        node.position = position
        let spriteComponent = TWSpriteComponent(node: node)
        addComponent(spriteComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func touched() {
        print("touched TWBlock")
        
        // build a tower
        if let buildTowerComponent = self.component(ofType: TWBuildTowerComponent.self) {
            buildTowerComponent.buildTower(team: .team1)
        }
    }
}
