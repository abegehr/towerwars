import SpriteKit
import GameplayKit

let mapBitMask:UInt32 = 0x1 << 0
let rangeBitMask:UInt32 = 0x1 << 1
let inRangeBitMask:UInt32 = 0x1 << 2

class TWRangeComponent : GKComponent {
    
    var node = SKNode()
    
    var inRange: Set<GKEntity> = []
    var target: GKEntity? {
        if !inRange.isEmpty {
            return inRange.first
        }
        return nil
    }
    
    init(range: CGFloat) {
        super.init()
        
        // physicsBody
        let physicsBody = SKPhysicsBody(circleOfRadius: range)
        physicsBody.isDynamic = false
        physicsBody.categoryBitMask = rangeBitMask
        physicsBody.contactTestBitMask = inRangeBitMask
        
        node.physicsBody = physicsBody
    }
    
    override func didAddToEntity() {
        // get spriteComponent
        if let spriteComponent = entity?.component(ofType: TWSpriteComponent.self) {
            
            // add entity to node userData
            node.userData = NSMutableDictionary()
            node.userData!["entity"] = entity!
            
            // add rangeNode to spriteComponent.node
            spriteComponent.node.addChild(node)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addToRange(entity: GKEntity) {
        if !(inRange.contains(entity) ) {
            inRange.insert(entity)
            
            // update TWInRangeComponent
            if let inRangeComponent = entity.component(ofType: TWInRangeComponent.self) {
                inRangeComponent.inRanges.insert(self)
            }
        }
    }
    
    func removeFromRange(entity: GKEntity) {
        inRange.remove(entity)
        
        // update TWInRangeComponent
        if let inRangeComponent = entity.component(ofType: TWInRangeComponent.self) {
            inRangeComponent.inRanges.remove(self)
        }
    }
    
}
