//
//  TWHealthComponent.swift
//  towerwars
//
//  Created by Anton Begehr on 13.11.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//

import SpriteKit
import GameplayKit

class TWHealthComponent: GKComponent {
    
    let fullHealth: Double
    var health: Double
    let healthBarFullWidth: CGFloat
    let healthBar: SKShapeNode
    
    //TODO: add sounds
    //let soundAction = SKAction.playSoundFileNamed("smallHit.wav", waitForCompletion: false)
    
    init(parentNode: SKNode, barWidth: CGFloat,
         barOffset: CGFloat, health: Double) {
        
        self.fullHealth = health
        self.health = health
        
        healthBarFullWidth = barWidth
        healthBar = SKShapeNode(rectOf:
            CGSize(width: healthBarFullWidth, height: 5), cornerRadius: 1)
        healthBar.fillColor = UIColor.green
        healthBar.strokeColor = UIColor.green
        healthBar.position = CGPoint(x: 0, y: barOffset)
        parentNode.addChild(healthBar)
        
        healthBar.isHidden = barWidth <= 0
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @discardableResult func takeDamage(_ damage: Double) -> Bool {
        health = max(health - damage, 0)
        
        healthBar.isHidden = false
        let healthScale = CGFloat(health/fullHealth)
        let scaleAction = SKAction.scaleX(to: healthScale, duration: 0.5)
        healthBar.run(scaleAction)
        
        if health == 0 {
            // test types
            if let creep = entity as? TWCreep {
                creep.kill()
            }
        }
        
        return health == 0
    }
    
}


