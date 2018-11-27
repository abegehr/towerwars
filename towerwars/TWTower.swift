import SpriteKit
import GameplayKit

typealias TowerType = String


class TWTower : GKEntity {
    
    var type: TowerType
    
    //todo: EntityManager?
    init(type: TowerType, team: Team, entityManager: TWEntityManager) {
        self.type = type
        super.init()
        //todo depend on type:
        let texture = SKTexture(imageNamed: "arrowTower1")
        let node = SKSpriteNode(texture: texture, color: .white, size: texture.size())

        let spriteComponent = TWSpriteComponent(node: node)
        addComponent(spriteComponent)
        spriteComponent.addToNodeKey()
        addComponent(TWTeamComponent(team: team))
        addComponent(TWRangeComponent(type: self.type, spriteComponent: spriteComponent))
        addComponent(TWFiringComponent(type: self.type))
        //todo: firing component
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
