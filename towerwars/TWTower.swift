import SpriteKit
import GameplayKit

typealias TowerType = String


class TWTower : GKEntity {
    
    var didAddSprite: Bool = false
    var type: TowerType
    
    //todo: EntityManager?
    init(type: TowerType, team: Team, entityManager: TWEntityManager) {
        self.type = type
        super.init()
        //todo depend on type:
        let texture = SKTexture(imageNamed: "arrowTower1")
        let spriteComponent = TWSpriteComponent(node: nil, texture: texture)
        addComponent(spriteComponent)
        spriteComponent.addToNodeKey()
        addComponent(TWTeamComponent(team: team))
        addComponent(TWRangeComponent(type: self.type, spriteComponent: spriteComponent))
        //todo: firing component
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
