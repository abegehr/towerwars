import SpriteKit
import GameplayKit

class TWFiringComponent : GKComponent {
    
    //todo attackType with array like range[type!]
    //var attackType: CGFloat
    var creepsInRange: [TWCreep] = []
    var targetCreep: TWCreep?
    let attackDamage: Float = 1
    init(type: TowerType) {
        super.init()
        attack()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCreepToRange(creep: TWCreep) {
        //print("addCreepToRange: ", creep)
        
        if !(creepsInRange.contains(creep) ) {
            creepsInRange.append(creep)
            //print("added creep to creepsInRange: ", creepsInRange)
        }
    }
    
    func removeCreepFromRange(creep: TWCreep) {
        //print("removeCreepFromRange: ", creep)
        if let index = creepsInRange.firstIndex(of: creep) {
            creepsInRange.remove(at: index)
            //print("removed creep from range: ", creepsInRange)
        }
    }
    
    //this will just keep going
    func attack() {
        let cooldown = 1.0
        _ = Timer.scheduledTimer(withTimeInterval: cooldown, repeats: true) { timer in
            //update our target
            self.findTarget()
            //if we have a target:
            if let targetCreep = self.targetCreep {
                //print("found a target")
                
                //for now: check if it the next shot kills it and if so, remove it from range
                if (targetCreep.component(ofType: TWHealthComponent.self)?.health)!-CGFloat(self.attackDamage) <= CGFloat(0.0) {
                    self.removeCreepFromRange(creep: targetCreep)
                }
                
                //deal damage to it
                targetCreep.component(ofType: TWHealthComponent.self)?.takeDamage(CGFloat(self.attackDamage))

            } else {
                //print("no target found")
            }
        }
    }
    
    func findTarget() {
        
        //no need to do anything if we already have a target
        if let targetCreep = self.targetCreep {
            if self.creepsInRange.contains(targetCreep) {
                return
            }
        }

        //set new target if there are creeps in range
        if self.creepsInRange.count > 0 {
            self.targetCreep = self.creepsInRange[0]
        } else {
            self.targetCreep = nil
        }
        
        return
    }
}
