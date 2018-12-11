import SpriteKit
import GameplayKit

class TWFiringComponent : GKComponent {
    
    var entityManager: TWEntityManager
    
    let attackDamage: Float = 1
    let cooldown: Double = 1
    
    init(entityManager: TWEntityManager) {
        
        self.entityManager = entityManager
        
        super.init()
        
        attack_target()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func runFiringAnimation() {
        guard let spriteComponent = entity?.component(ofType: TWSpriteComponent.self) else {
            return
        }
        
        let firingAnimation = SKAction.sequence([SKAction.scale(to: 1.1, duration: 0.1), SKAction.scale(to: 1.0, duration: 0.1)])
        spriteComponent.node.run(firingAnimation)
    }
    
    func attack_target() {
        // after every cooldown cycle
        _ = Timer.scheduledTimer(withTimeInterval: self.cooldown, repeats: true) { _ in
            // get rangeComponent
            if let rangeComponent = self.entity?.component(ofType: TWRangeComponent.self) {
                // get target
                if let target = rangeComponent.target {
                    
                    self.runFiringAnimation()
                    
                    // tmp: removing creep from range if next shot kills it
                    // todo: remove dead creeps from range automatically
                    if (target.component(ofType: TWHealthComponent.self)?.health)!-CGFloat(self.attackDamage) <= CGFloat(0.0) {
                        rangeComponent.removeFromRange(entity: target)
                    }
                    
                    // deal damage
                    target.component(ofType: TWHealthComponent.self)?.takeDamage(CGFloat(self.attackDamage))
                }
            }
        }
    }
    
}
