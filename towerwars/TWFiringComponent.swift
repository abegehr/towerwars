import SpriteKit
import GameplayKit

class TWFiringComponent : GKComponent {
    
    //todo attackType with array like range[type!]
    //var attackType: CGFloat
    var creepsInRange: [TWCreep] = []
    let attackDamage: Float = 1
    init(type: TowerType) {
        super.init()
        
        
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
    
    func attack() {
        
    }
}
