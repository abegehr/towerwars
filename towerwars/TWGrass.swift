//
//  TWWall.swift
//  towerwars
//
//  Created by Anton Begehr on 18.10.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//

import SpriteKit
import GameplayKit

class TWGrass: TWBlock {
    
    var buildTowerComponent: TWBuildTowerComponent {
        guard let buildTowerComponent = component(ofType: TWBuildTowerComponent.self) else { fatalError("A grass entity must have a TWBuildTowerComponent.") }
        return buildTowerComponent
    }
    
    init(position: CGPoint, entityManager: TWEntityManager) {
        
        // settings
        let width = 60.0
        
        // node
        let size = CGSize(width: TWBlock.width, height: TWBlock.width)
        let node = TouchableShapeNode(rectOf: size, cornerRadius: CGFloat(0.1*width))
        node.position = position
        node.fillColor = .init(red: 0.1, green: 1.0, blue: 0.1, alpha: 1)
        node.strokeColor = .init(red: 1, green: 1, blue: 1, alpha: 1)
        
        super.init(node: node, position: position, entityManager: entityManager)
        
        // buildTowerComponent
        let buildTowerComponent = TWBuildTowerComponent(entityManager: entityManager)
        addComponent(buildTowerComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
