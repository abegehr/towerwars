import SpriteKit
import GameplayKit

class TWInRangeComponent: GKComponent {
    
    override init() {
        super.init()
        
        // get spriteComponent
        if let spriteComponent = entity?.component(ofType: TWSpriteComponent.self) {
            
            // if physicsBody does not exist
            if !(spriteComponent.node.physicsBody != nil) {
                // use default physicsBody
                let physicsBody = SKPhysicsBody(circleOfRadius: 10)
                physicsBody.isDynamic = true
                spriteComponent.node.physicsBody = physicsBody
            }
            
            // set bitmasks on physicsBody
            if let physicsBody = spriteComponent.node.physicsBody {
                physicsBody.categoryBitMask = inRangeBitMask
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
