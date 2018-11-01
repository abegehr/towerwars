//
//  TWWall.swift
//  towerwars
//
//  Created by Anton Begehr on 18.10.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//

import Foundation
import SpriteKit

class TWWall: SKSpriteNode {
    
    init(position: CGPoint) {
        let texture = SKTexture(imageNamed: "Wall")
        super.init(texture: texture, color: .clear, size: texture.size())
        
        // position
        self.position = position
        
        // physics body
        self.physicsBody = SKPhysicsBody(rectangleOf: self.frame.size)
        self.physicsBody!.isDynamic = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
