//
//  TWCastle.swift
//  towerwars
//
//  Created by Anton Begehr on 01.11.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class TWCastle: GKEntity {
    
    var nodeComponent: GKSKNodeComponent {
        guard let nodeComponent = component(ofType: GKSKNodeComponent.self) else { fatalError("A Castle entity must have a TWSpriteComponent.") }
        return nodeComponent
    }
    
    var castleComponent: TWCastleComponent {
        guard let castleComponent = component(ofType: TWCastleComponent.self) else { fatalError("A Castle entity must have a TWCastleComponent.") }
        return castleComponent
    }
    
    init(color: UIColor, position: CGPoint, team: Team, entityManager: TWEntityManager) {
        super.init()
        
        // nodeComponent
        let size = CGSize(width: 100, height: 100)
        let node = SKShapeNode(rectOf: size)
        node.position = position
        node.fillColor = color
        node.zPosition = 100
        let nodeComponent = GKSKNodeComponent(node: node)
        addComponent(nodeComponent)
        
        // castleComponent
        let castleComponent = TWCastleComponent(entityManager: entityManager)
        addComponent(castleComponent)
        
        // healthComponent
        //let healthComponent = TWHealthComponent(entityManager: entityManager)
        //addComponent(healthComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
