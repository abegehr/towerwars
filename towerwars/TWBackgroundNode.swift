//
//  TWBackgroundNode.swift
//  towerwars
//
//  Created by Anton Begehr on 30.11.18.
//  Copyright © 2018 Anton Begehr. All rights reserved.
//

import SpriteKit

public enum GradientDirection {
    case Up
    case Left
    case UpLeft
    case UpRight
}

class TWBackgroundNode: SKSpriteNode {
    
    init(size: CGSize, color1: CIColor, color2: CIColor, direction: GradientDirection) {
        
        let context = CIContext(options: nil)
        let filter = CIFilter(name: "CILinearGradient")
        var startVector: CIVector
        var endVector: CIVector
        
        filter!.setDefaults()
        
        switch direction {
            case .Up:
                startVector = CIVector(x: size.width * 0.5, y: 0)
                endVector = CIVector(x: size.width * 0.5, y: size.height)
            case .Left:
                startVector = CIVector(x: size.width, y: size.height * 0.5)
                endVector = CIVector(x: 0, y: size.height * 0.5)
            case .UpLeft:
                startVector = CIVector(x: size.width, y: 0)
                endVector = CIVector(x: 0, y: size.height)
            case .UpRight:
                startVector = CIVector(x: 0, y: 0)
                endVector = CIVector(x: size.width, y: size.height)
        }
        
        filter!.setValue(startVector, forKey: "inputPoint0")
        filter!.setValue(endVector, forKey: "inputPoint1")
        filter!.setValue(color1, forKey: "inputColor0")
        filter!.setValue(color2, forKey: "inputColor1")
        
        let image = context.createCGImage(filter!.outputImage!, from: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let texture = SKTexture(cgImage: image!)
        
        super.init(texture: texture, color: .clear, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

