import SpriteKit
import GameplayKit

class TWFiringComponent : GKComponent {
    
    var entityManager: TWEntityManager
    
    //todo attackType with array like range[type!]
    //var attackType: CGFloat
    var creepsInRange: [TWCreep] = []
    var targetCreep: TWCreep?
    let attackDamage: Float = 1
    let cooldown: Double = 1
    
    init(type: TowerType, entityManager: TWEntityManager) {
        
        self.entityManager = entityManager
        
        super.init()
        
        attack_target()
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
    
    func runFiringAnimation() {
        guard let spriteComponent = entity?.component(ofType: TWSpriteComponent.self) else {
            return
        }
        
        let firingAnimation = SKAction.sequence([SKAction.scale(to: 1.1, duration: 0.1), SKAction.scale(to: 1.0, duration: 0.1)])
        
        spriteComponent.node.run(firingAnimation)
    }
    
    //this will just keep going
    func attack_target() {
        _ = Timer.scheduledTimer(withTimeInterval: self.cooldown, repeats: true) { _ in
            
            //update our target
            self.findTarget()
            //if we have a target:
            if let targetCreep = self.targetCreep {
                //print("found a target")
                self.runFiringAnimation()
                
                //for now: check if it the next shot kills it and if so, remove it from range
                if (targetCreep.component(ofType: TWHealthComponent.self)?.health)!-CGFloat(self.attackDamage) <= CGFloat(0.0) {
                    // shot kills creep
                    self.removeCreepFromRange(creep: targetCreep)
                    // earns one coin
                    //self.earn_coin()
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
    
    func earn_coin() {
        if let teamComponent = entity?.component(ofType: TWTeamComponent.self) {
            if let castle = entityManager.castleForTeam(teamComponent.team) {
                if let castleComponent = castle.component(ofType: TWCastleComponent.self) {
                    //TODO: problematic since many creep are spawned as the game progresses
                    castleComponent.coins += 1
                }
            }
        }
    }
    
}
