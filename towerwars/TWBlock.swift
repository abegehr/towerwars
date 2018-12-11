//
//  TWWall.swift
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
    
    var buildTowerComponent: TWBuildTowerComponent {
        guard let buildTowerComponent = component(ofType: TWBuildTowerComponent.self) else { fatalError("A Block entity must have a TWBuildTowerComponent.") }
        return buildTowerComponent
    }
    
    init(position: CGPoint, width: CGFloat = 60.0, entityManager: TWEntityManager) {
        
        self.entityManager = entityManager
        
        super.init()
        
        // spriteComponent
        let size = CGSize(width: width, height: width)
        let node = TouchableShapeNode(rectOf: size, cornerRadius: CGFloat(0.1*width))
        node.position = position
        node.fillColor = .init(red: 0.7, green: 0.7, blue: 0.7, alpha: 1)
        node.strokeColor = .init(red: 1, green: 1, blue: 1, alpha: 1)
        node.physicsBody = SKPhysicsBody(rectangleOf: size)
        node.physicsBody!.isDynamic = false
        //physics changes (maybe temporarily): adjusted bitmasks so that it doesn't collide with a creep (contact function in gameScene would be triggered)
        node.physicsBody!.categoryBitMask = mapBitMask
        let spriteComponent = TWSpriteComponent(node: node)
        addComponent(spriteComponent)
        spriteComponent.addToNodeKey()
        
        // buildTowerComponent
        let buildTowerComponent = TWBuildTowerComponent(entityManager: entityManager)
        addComponent(buildTowerComponent)
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
