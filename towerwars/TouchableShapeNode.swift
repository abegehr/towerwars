//
//  TouchableShapeNode.swift
//  towerwars
//
//  Created by Anton Begehr on 28.11.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//

import SpriteKit
import GameKit

class TouchableShapeNode: SKShapeNode {
    
    override init() {
        super.init()
        
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touched – TouchableShapeNode")
        
        // pass touches to entity
        //TODO: find a way to call touched generally on GKEntity. To make TouchableShapeNode generaly usable, not just by TWBlock
        if let entity = self.userData?["entity"] as? TWBlock {
            print("touched - entity: ", entity)
            entity.touched()
        }
        
    }
    
}

