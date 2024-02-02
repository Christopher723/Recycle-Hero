//
//  MenuScene.swift
//  Recylce2
//
//  Created by Christopher Woods on 1/22/24.
//

import SpriteKit


class MenuScene: SKScene{
    var crane: SKSpriteNode!
    var RecycleHeros: SKSpriteNode!
    var startButton: SKSpriteNode!
    
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = UIColor(red: 145/255, green: 217/255, blue: 255/255, alpha: 1.0)
        
            
        
            RecycleHeros = SKSpriteNode(imageNamed: "RecycleHeroText")
        
        RecycleHeros.position = CGPoint(x: frame.width/2, y:frame.height/1.3)
            RecycleHeros.zPosition = 20
            RecycleHeros.name = "recycleHeroText"
        
           
        
        startButton = SKSpriteNode(imageNamed: "Start")
        startButton.position = CGPoint(x: self.size.width / 2, y: frame.height / 9.5)
        startButton.zPosition = 20
        startButton.name = "startButton"
        
        crane = SKSpriteNode(imageNamed: "Crane")
        crane.setScale(1)
        crane.position = CGPoint(x: self.size.width / 3.7, y: self.size.height / 5)
        crane.zPosition = 21
        crane.name = "crane"
        
//            playButtonNode = SKSpriteNode(color: UIColor.red, size: CGSize(width: 200, height: 100))
//            playButtonNode?.name = "playGameButton"
//            playButtonNode?.position = CGPoint(x: self.size.width / 2, y: self.size.height / 3)
//            playButtonNode?.zPosition = 10
        
            
            addChild(startButton)
            addChild(RecycleHeros)
            addChild(crane)
        
            
        }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            if nodesArray.first?.name == "startButton"{
                let worldSelect = WorldSelect(size: self.size)
                self.view?.presentScene(worldSelect)
            }
        }
            
        
        
        
    }
    
    
    
    
}
