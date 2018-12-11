import SpriteKit
import GameplayKit

let mapBitMask:UInt32 = 0x1 << 0
let rangeBitMask:UInt32 = 0x1 << 1
let inRangeBitMask:UInt32 = 0x1 << 2

class TWRangeComponent : GKComponent {
    
    var inRange: [GKEntity?] = []
    
    var target: GKEntity? {
        if !inRange.isEmpty {
            return inRange[0]
        }
        return nil
    }
    
    init(range: CGFloat) {
        super.init()
        
        // get spriteComponent
        if let spriteComponent = entity?.component(ofType: TWSpriteComponent.self) {
            
            // physicsBody
            let physicsBody = SKPhysicsBody(circleOfRadius: range)
            physicsBody.isDynamic = false
            physicsBody.categoryBitMask = rangeBitMask
            physicsBody.contactTestBitMask = inRangeBitMask
            
            // node
            let node = SKNode()
            node.physicsBody = physicsBody
            // add entity to node userData
            node.userData = NSMutableDictionary()
            node.userData!["entity"] = entity!
            
            spriteComponent.node.addChild(node)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addToRange(entity: GKEntity) {
        if !(inRange.contains(entity) ) {
            inRange.append(entity)
        }
    }
    
    func removeFromRange(entity: GKEntity) {
        if let index = inRange.firstIndex(of: entity) {
            inRange.remove(at: index)
        }
    }
    
}
