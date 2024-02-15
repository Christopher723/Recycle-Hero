//
//  LevelSelect.swift
//  Recylce2
//
//  Created by Christopher Woods on 1/22/24.
//

import SpriteKit



class GameOver: SKScene{
    
    var gameOver: SKSpriteNode!
    var playAgain: SKSpriteNode!
    var levelSelectButton: SKSpriteNode!
    override func didMove(to view: SKView) {
        
        
        self.backgroundColor = UIColor(red: 145/255, green: 217/255, blue: 255/255, alpha: 1.0)
        
        
        
        gameOver = SKSpriteNode(imageNamed: "GameOver")
        gameOver.position = CGPoint(x: frame.width/2, y:frame.height / 1.5)
        gameOver.zPosition = 20
        gameOver.name = "gameOver"
        
        
        
        playAgain = SKSpriteNode(imageNamed: "PlayAgain")
        playAgain.position = CGPoint(x: frame.width / 2, y:frame.height / 4)
        playAgain.zPosition = 20
        playAgain.name = "playAgain"
        
        
        levelSelectButton = SKSpriteNode(imageNamed: "LevelSelectButton")
        levelSelectButton.position = CGPoint(x: frame.width/2, y:frame.height / 9)
        levelSelectButton.zPosition = 20
        levelSelectButton.name = "levelSelectButton"
      
        
        
        
        
        addChild(levelSelectButton)
        addChild(gameOver)
        addChild(playAgain)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            if nodesArray.first?.name == "levelSelectButton"{
                let WorldSelect = WorldSelect(size: self.size)
                self.view?.presentScene(WorldSelect)
            }
            
            else if nodesArray.first?.name == "playAgain"{
                let gameScene = GameScene(size: self.size)
                self.view?.presentScene(gameScene)
            }
        }
        
        
        
        
    }
}
