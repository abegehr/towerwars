import SpriteKit

class TWMenuScene: SKScene {
    
    var background = SKSpriteNode(imageNamed: "mainBackground")
    var playButton = SKSpriteNode()
    let playButtonTex = SKTexture(imageNamed: "playButton")
    
    override func didMove(to view: SKView) {
        
        //TODO adjust size
        //background
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        addChild(background)
        
        //play button
        playButton = SKSpriteNode(texture: playButtonTex)
        playButton.position = CGPoint(x: frame.midX, y: frame.midY)
        self.addChild(playButton)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            if node == playButton {
                if let view = view {
                    let transition:SKTransition = SKTransition.fade(withDuration: 1)
                    let scene:SKScene = TWGameScene(size: self.size)
                    self.view?.presentScene(scene, transition: transition)
                }
            }
        }
    }
}
