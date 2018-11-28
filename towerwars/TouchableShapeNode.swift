//
//  TouchableShapeNode.swift
//  towerwars
//
//  Created by Anton Begehr on 28.11.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//

import SpriteKit

class TouchableShapeNode: SKShapeNode {
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touched")
    }
    
}

