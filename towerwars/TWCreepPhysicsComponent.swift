import SpriteKit
import GameplayKit

class TWCreepPhysicsComponent: GKComponent {
    
    let obligatoryNode: SKShapeNode?
    
    init(spriteComponent: TWSpriteComponent) {
        self.obligatoryNode = SKShapeNode(circleOfRadius: w / 2)
        super.init()
        
        self.obligatoryNode?.physicsBody = SKPhysicsBody(circleOfRadius: w / 2)
        
        if let pb = self.obligatoryNode?.physicsBody{
            //physics changes
            pb.isDynamic = true
            pb.categoryBitMask = creepCategory
            pb.contactTestBitMask = towerRangeCircleCategory
            pb.collisionBitMask = 0
        }
        spriteComponent.node.addChild(obligatoryNode!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
