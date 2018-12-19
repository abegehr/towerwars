//
//  TWHitComponent,swift
//  towerwars
//
//  Created by Anton Begehr on 19.11.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//
import SpriteKit
import GameplayKit

class TWHitComponent: GKSKNodeComponent {
    
    var strength: Double = 1
    
    init(strength: Double) {
        self.strength = strength
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
