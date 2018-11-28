//
//  TouchableShapeNode.swift
//  towerwars
//
//  Created by Anton Begehr on 28.11.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//

import SpriteKit

class TouchableShapeNode: SKShapeNode {
    
    override init() {
        super.init()
        
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touched")
    }
    
}

