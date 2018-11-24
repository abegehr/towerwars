import SpriteKit
import GameplayKit

var w: CGFloat {
    return (UIScreen.main.bounds.width + UIScreen.main.bounds.height) * 0.05
}

let creepCategory:UInt32 = 0x1 << 0
let towerRangeCircleCategory:UInt32 = 0x1 << 1

var ranges: [String: CGFloat] = [
    "arrow": w * 3,
    "cannon": w * 2,
]

class TWRangeComponent : GKComponent {
    
    
    var range: CGFloat
    var creepsInRange: [TWCreep] = []
    var circleNode: SKShapeNode?
    
    init(type: TowerType, spriteComponent: TWSpriteComponent) {
        self.range = ranges[type]!
        let circle = CGRect(x: 0.0 - self.range, y: 0.0 - self.range, width: self.range * 2, height: self.range * 2)
        self.circleNode = SKShapeNode(rect: circle, cornerRadius: self.range)
        super.init()
        
        if let circleNode = self.circleNode{
            circleNode.position = CGPoint(x: 0.0, y: 0.0)
            circleNode.strokeColor = .white
            //circleNode.fillColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
            circleNode.physicsBody = SKPhysicsBody(circleOfRadius: self.range)
            circleNode.physicsBody!.isDynamic = false
            circleNode.physicsBody!.categoryBitMask = towerRangeCircleCategory
            circleNode.physicsBody!.contactTestBitMask = creepCategory
            circleNode.physicsBody!.collisionBitMask = creepCategory
            spriteComponent.node.addChild(circleNode)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCreepToRange(creep: TWCreep) {
        print("addCreepToRange: ", creep)
        
        if !(creepsInRange.contains(creep) ) {
            creepsInRange.append(creep)
            print("added creep to creepsInRange: ", creepsInRange)
        }
    }
    
    func removeCreepFromRange(creep: TWCreep) {
        print("removeCreepFromRange: ", creep)
        if let index = creepsInRange.firstIndex(of: creep) {
            creepsInRange.remove(at: index)
            print("removed creep from range: ", creepsInRange)
        }
    }
    
}
