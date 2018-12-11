import SpriteKit
import GameplayKit

class TWInRangeComponent: GKComponent {
    
    var inRanges: Set<TWRangeComponent> = []
    
    override init() {
        super.init()
    }
    
    override func didAddToEntity() {
        super.didAddToEntity()
        
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
    
    func removeFromAllRanges() {
        for range in inRanges {
            range.removeFromRange(entity: entity!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
