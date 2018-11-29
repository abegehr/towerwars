import SpriteKit
import GameplayKit

class TWCreepPhysicsComponent: GKComponent {
    
    
    init(spriteComponent: TWSpriteComponent) {
        super.init()
        
        let pBody = SKPhysicsBody(circleOfRadius: w / 2)
        
        //physics changes
        pBody.isDynamic = true
        pBody.categoryBitMask = creepCategory
        pBody.contactTestBitMask = towerRangeCircleCategory
        pBody.collisionBitMask = 0
        
        spriteComponent.node.physicsBody = pBody
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
