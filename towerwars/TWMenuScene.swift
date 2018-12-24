import SpriteKit

class TWMenuScene: SKScene {
    
    var background = SKSpriteNode(imageNamed: "mainBackground")
    var playButton = SKSpriteNode(imageNamed: "playButton")
    var optionsButton = SKSpriteNode(imageNamed: "options")
    var helpButton = SKSpriteNode(imageNamed: "help")
    
    override func didMove(to view: SKView) {
        
        //background
        background.size = frame.size
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        addChild(background)
        
        //play button
        playButton.position = CGPoint(x: frame.midX, y: frame.midY)
        self.addChild(playButton)
        
        //options button
        optionsButton.position = CGPoint(x: frame.midX/2+75, y: frame.midY-300.0)
        optionsButton.size = CGSize(width: 150.0, height: 150.0)
        self.addChild(optionsButton)
        
        //help button
        helpButton.position = CGPoint(x: frame.midX*(3/2)-75, y: frame.midY-300.0)
        helpButton.size = CGSize(width: 150.0, height: 150.0)
        self.addChild(helpButton)
        
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
