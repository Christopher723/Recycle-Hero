//
//  LevelSelect.swift
//  Recylce2
//
//  Created by Christopher Woods on 1/22/24.
//

import SpriteKit



class LevelPreview: SKScene{
    
    
    var previewText: SKSpriteNode!
    var startButton: SKSpriteNode!
    
    
    override func didMove(to view: SKView) {
        
        
        self.backgroundColor = UIColor(red: 145/255, green: 217/255, blue: 255/255, alpha: 1.0)
        
        startButton = SKSpriteNode(imageNamed: "PreviewStartButton")
        startButton.position = CGPoint(x: frame.width/2, y:frame.height / 5)
        startButton.zPosition = 21
        startButton.name = "start"
        
        
        
        previewText = SKSpriteNode(imageNamed: "PreviewText")
        previewText.position = CGPoint(x: frame.width / 2, y:frame.height / 2)
        previewText.zPosition = 20
        previewText.setScale(1.3)
        previewText.name = "preview"
    
        addChild(startButton)
        addChild(previewText)
        
      
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            if nodesArray.first?.name == "start"{
                let levelSelect = GameScene(size: self.size)
                self.view?.presentScene(levelSelect)
            }
            
            
        }
        
        
        
        
    }
}
