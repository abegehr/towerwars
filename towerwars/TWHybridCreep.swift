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
        // settings
        let radius = CGFloat(20.0)
        let color1 = UIColor.blue
        let color2 = TWPink
        
        // node
        let node = SKNode()
        node.position = position
        node.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        
        // half circle 1
        let crop1 = SKCropNode()
        let mask1 = SKSpriteNode(color: .black, size: CGSize(width: 2*radius, height: 2*radius))
        mask1.position.y = radius
        let circle1 = SKShapeNode(circleOfRadius: radius)
        circle1.strokeColor = color2
        circle1.fillColor = color1
        crop1.addChild(circle1)
        crop1.maskNode = mask1
        node.addChild(crop1)
        
        // half circle 2
        let crop2 = SKCropNode()
        let mask2 = SKSpriteNode(color: .black, size: CGSize(width: 2*radius, height: 2*radius))
        mask2.position.y = -radius
        let circle2 = SKShapeNode(circleOfRadius: radius)
        circle2.strokeColor = color1
        circle2.fillColor = color2
        crop2.addChild(circle2)
        crop2.maskNode = mask2
        node.addChild(crop2)
        
        super.init(strength: 2.0, health: 1.0, showHealthbar: false, node: node, team: team, entityManager: entityManager)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func kill() {
        // remove entity
        entityManager.remove(self)
        
        // spawn two minicreeps
        // get necessary components
        if let spriteComponent = component(ofType: TWSpriteComponent.self),
            let teamComponent = component(ofType: TWTeamComponent.self),
            let pathComponent = component(ofType: TWPathComponent.self) {
            
            // minicreep settings
            let radius = CGFloat(14)
            let position = spriteComponent.node.position
            let team = teamComponent.team
            
            // blue and pink minicreeps
            let blueMiniCreep = TWCreep(radius: radius, fillColor: .blue, strokeColor: TWPink, strength: 1.0, health: 1, showHealthbar: false, position: CGPoint(x: position.x, y: position.y + radius), team: team, entityManager: entityManager)
            let pinkMiniCreep = TWCreep(radius: radius, fillColor: TWPink, strokeColor: .blue, strength: 1.0, health: 1, showHealthbar: false, position: CGPoint(x: position.x, y: position.y - radius), team: team, entityManager: entityManager)
            
            // add pathComponent
            blueMiniCreep.addComponent(pathComponent)
            pinkMiniCreep.addComponent(pathComponent)
            
            // add minicreeps
            entityManager.add(blueMiniCreep)
            entityManager.add(pinkMiniCreep)
            
        }
    }
    
}
