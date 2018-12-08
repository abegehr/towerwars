import SpriteKit
import GameplayKit

let creepCategory:UInt32 = 0x1 << 0
let towerRangeCircleCategory:UInt32 = 0x1 << 1

class TWRangeComponent : GKComponent {
    
    var range: CGFloat
    var circleNode: SKNode?
    
    var creepsInRange: [TWCreep?] = []
    var targetCreep: TWCreep? {
        if !creepsInRange.isEmpty {
            return creepsInRange[0]
        }
        return nil
    }
    
    init(range: CGFloat, spriteComponent: TWSpriteComponent) {
        self.range = range
        
        //let circle = CGRect(x: 0.0 - self.range, y: 0.0 - self.range, width: self.range * 2, height: self.range * 2)
        self.circleNode = SKNode() //SKShapeNode(rect: circle, cornerRadius: self.range)
        
        super.init()
        
        if let circleNode = self.circleNode{
            circleNode.position = CGPoint(x: 0.0, y: 0.0)
            //circleNode.strokeColor = .white
            //circleNode.fillColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
            circleNode.physicsBody = SKPhysicsBody(circleOfRadius: self.range)
            circleNode.physicsBody!.isDynamic = false
            circleNode.physicsBody!.categoryBitMask = towerRangeCircleCategory
            circleNode.physicsBody!.contactTestBitMask = creepCategory
            circleNode.physicsBody!.collisionBitMask = creepCategory
            spriteComponent.node.addChild(circleNode)
        }
    }
    
    func addCreepToRange(creep: TWCreep) {
        // add creep to in range
        if !(creepsInRange.contains(creep) ) {
            creepsInRange.append(creep)
        }
    }
    
    func removeCreepFromRange(creep: TWCreep) {
        // remove creep from in range
        if let index = creepsInRange.firstIndex(of: creep) {
            creepsInRange.remove(at: index)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
