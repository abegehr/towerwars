import SpriteKit

class TWMenuScene: SKScene {
    
    var background = SKSpriteNode(imageNamed: "mainBackground")
    var playButton = SKSpriteNode(imageNamed: "playButton")
    var optionsButton = SKSpriteNode(imageNamed: "options")
    
    override func didMove(to view: SKView) {
        
        //background
        background.size = frame.size
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        addChild(background)
        
        //play button
        playButton.position = CGPoint(x: frame.midX, y: frame.midY)
        self.addChild(playButton)
        
        //options button
        optionsButton.position = CGPoint(x: frame.midX, y: frame.midY-200.0)
        self.addChild(optionsButton)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            if node == playButton {
                if view != nil {
                    let transition:SKTransition = SKTransition.fade(withDuration: 1)
                    let scene:SKScene = TWLevelScene(size: self.size)
                    self.view?.presentScene(scene, transition: transition)
                }
            }
        }
    }
}
