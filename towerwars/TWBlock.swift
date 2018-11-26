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
    
    var spriteComponent: TWSpriteComponent {
        guard let spriteComponent = component(ofType: TWSpriteComponent.self) else { fatalError("A Block entity must have a TWSpriteComponent.") }
        return spriteComponent
    }
    
    init(position: CGPoint) {
        super.init()
        
        // spriteComponent
        let texture = SKTexture(imageNamed: "Wall")
        let size = texture.size()
        let node = SKSpriteNode(texture: texture, color: .clear, size: size)
        node.position = position
        node.physicsBody = SKPhysicsBody(rectangleOf: size)
        node.physicsBody!.isDynamic = false
        //physics changes (maybe temporarily): adjusted bitmasks so that it doesn't collide with a creep (contact function in gameScene would be triggered)
        node.physicsBody!.categoryBitMask = creepCategory
        node.physicsBody!.contactTestBitMask = 2
        node.physicsBody!.collisionBitMask = 0
        let spriteComponent = TWSpriteComponent(node: node)
        addComponent(spriteComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
