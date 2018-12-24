import SpriteKit

class TWLevelScene: SKScene {
    
    var background = SKSpriteNode(imageNamed: "mainBackground")
    //var levelButton = SKSpriteNode(imageNamed: "playButton")
    
    //TODO do this in init
    override func didMove(to view: SKView) {
        
        //margins
        let marginX: CGFloat = 125.0
        let marginY: CGFloat = 200.0
        let paddingX: CGFloat = 25.0
        
        //buttonSize
        let buttonWidth = CGFloat((frame.size.width-marginX)/3)
        let buttonHeight = buttonWidth
        let buttonSize = CGSize(width: buttonWidth, height: buttonHeight)
        
        //background
        background.size = frame.size
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        addChild(background)

        //create buttons
        for i in 0..<15 {
            
            let levelButton = SKSpriteNode(imageNamed: "playButton")
            levelButton.position = CGPoint(x: CGFloat(i%3)*(buttonWidth+paddingX)+marginX, y: 800.0-CGFloat(floor(Double(i/3)))*buttonHeight+marginY)
            levelButton.size = buttonSize
            self.addChild(levelButton)
            
        }
 
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            /*if node == levelButton {
                if view != nil {
                    let transition:SKTransition = SKTransition.fade(withDuration: 1)
                    let scene:SKScene = TWGameScene(size: self.size)
                    self.view?.presentScene(scene, transition: transition)
                }
            }*/
        }
    }
}
