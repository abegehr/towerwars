//
//  TWWall.swift
//  towerwars
//
//  Created by Anton Begehr on 30.09.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//

import Foundation
import SpriteKit

class TWWall: SKShapeNode {
    
    init(path: CGPath) {
        super.init()
        self.path = path
        
        // texture
        self.strokeColor = .black
        self.fillColor = .white
        self.fillTexture = self.texture
    }
    
    var texture: SKTexture? {
        var texture: SKTexture?
        
        if let image = UIImage(named: "Wall") {
            
            UIGraphicsBeginImageContext(self.frame.size)// need to use instance frame?
            let context = UIGraphicsGetCurrentContext()
            
            if let cgImage = image.cgImage {
                context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height), byTiling: true)
                
                if let tiledImage = UIGraphicsGetImageFromCurrentImageContext() {
                    texture = SKTexture(image: tiledImage)
                }
            }
            
            UIGraphicsEndImageContext()
        }
        
        return texture
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
