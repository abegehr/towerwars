//
//  TWCharacter.swift
//  towerwars
//
//  Created by Anton Begehr on 30.09.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//

import Foundation
import SpriteKit

class TWCharacter: SKShapeNode {
    
    init(position: CGPoint){
        super.init()
        
        // position
        self.position = position
        
        // form
        let radius = 25
        let diameter = 2*radius
        self.path = CGPath.init(ellipseIn: CGRect(x: -radius, y: -radius, width: diameter, height: diameter), transform: nil)
        
        // color
        self.fillColor = UIColor.blue
        
        // physicsBody
        self.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(diameter/2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
