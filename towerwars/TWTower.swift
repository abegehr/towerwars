import SpriteKit
import GameplayKit

enum TowerType: Int {
    case arrow = 1
    
    static let allValues = [arrow]
}

class TWTower : GKEntity {
    
    var spriteComponent: TWSpriteComponent {
        guard let spriteComponent = component(ofType: TWSpriteComponent.self) else { fatalError("A Castle entity must have a TWSpriteComponent.") }
        return spriteComponent
    }
    
    var teamComponent: TWTeamComponent {
        guard let teamComponent = component(ofType: TWTeamComponent.self) else { fatalError("A Castle entity must have a TWTeamComponent.") }
        return teamComponent
    }
    
    var rangeComponent: TWRangeComponent {
        guard let rangeComponent = component(ofType: TWRangeComponent.self) else { fatalError("A Castle entity must have a TWRangeComponent.") }
        return rangeComponent
    }
    
    var firingComponent: TWFiringComponent {
        guard let firingComponent = component(ofType: TWFiringComponent.self) else { fatalError("A Castle entity must have a TWFiringComponent.") }
        return firingComponent
    }
    
    init(range: CGFloat, team: Team, entityManager: TWEntityManager) {
        super.init()
        
        // node
        let node = SKSpriteNode(imageNamed: "arrowTower1")
        
        // spriteComponent
        let spriteComponent = TWSpriteComponent(node: node)
        addComponent(spriteComponent)
        spriteComponent.addToNodeKey()
        
        // teamComponent
        addComponent(TWTeamComponent(team: team))
        
        // rangeComponent
        addComponent(TWRangeComponent(range: range))
        
        // firingComponent
        addComponent(TWFiringComponent(entityManager: entityManager))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
