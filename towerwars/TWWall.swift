//
//  TWWall.swift
//  towerwars
//
//  Created by Anton Begehr on 13.12.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//

import SpriteKit
import GameplayKit

class TWWall: TWBlock {
    
    var buildTowerComponent: TWBuildTowerComponent {
        guard let buildTowerComponent = component(ofType: TWBuildTowerComponent.self) else { fatalError("A Block entity must have a TWBuildTowerComponent.") }
        return buildTowerComponent
    }
    
    init(position: CGPoint, entityManager: TWEntityManager) {
        
        // node
        let size = CGSize(width: TWBlock.width, height: TWBlock.width)
        let node = TouchableShapeNode(rectOf: size, cornerRadius: CGFloat(0.1*TWBlock.width))
        node.fillColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        node.strokeColor = .init(red: 1, green: 1, blue: 1, alpha: 1)
        node.physicsBody = SKPhysicsBody(rectangleOf: size)
        node.physicsBody!.isDynamic = false
        //physics changes (maybe temporarily): adjusted bitmasks so that it doesn't collide with a creep (contact function in gameScene would be triggered)
        node.physicsBody!.categoryBitMask = mapBitMask
        
        super.init(node: node, position: position, entityManager: entityManager)
        
        // buildTowerComponent
        let buildTowerComponent = TWBuildTowerComponent(entityManager: entityManager)
        addComponent(buildTowerComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
