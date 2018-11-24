//
//  TWSpriteComponent.swift
//  towerwars
//
//  Created by Anton Begehr on 13.11.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//

import SpriteKit
import GameplayKit

class TWSpriteComponent: GKSKNodeComponent {

    let textureNode: SKSpriteNode?

    init(node: SKNode?, texture: SKTexture?) {
        if let texture = texture {
            self.textureNode = SKSpriteNode(texture: texture, color: .white, size: texture.size())
            super.init()
        } else if let node = node {
            self.textureNode = nil
            super.init(node: node)
        } else {
            fatalError("Neither Texture nor Node was specified for TWSpriteComponent.")
        }
    }
    
    func addToNodeKey() {
        node.userData = NSMutableDictionary()
        node.userData!["entity"] = self.entity!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

