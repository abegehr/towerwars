//
//  TWWall.swift
//  towerwars
//
//  Created by Anton Begehr on 18.10.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//

import SpriteKit
import GameplayKit

class TWPath: GKEntity {
    
    let entityManager: TWEntityManager
    
    var spriteComponent: TWSpriteComponent {
        guard let spriteComponent = component(ofType: TWSpriteComponent.self) else { fatalError("A path entity must have a TWSpriteComponent.") }
        return spriteComponent
    }
    
    
    init(position: CGPoint, width: CGFloat = 60.0, entityManager: TWEntityManager) {
        
        self.entityManager = entityManager
        
        super.init()
        
        // spriteComponent
        let size = CGSize(width: width, height: width)
        let node = TouchableShapeNode(rectOf: size, cornerRadius: CGFloat(0.1*width))
        node.position = position
        node.fillColor = .init(red: 0.7, green: 0.7, blue: 0.1, alpha: 1)
        node.strokeColor = .init(red: 1, green: 1, blue: 1, alpha: 1)
        
        let spriteComponent = TWSpriteComponent(node: node)
        addComponent(spriteComponent)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
