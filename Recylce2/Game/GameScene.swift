//
//  GameScene.swift
//  Recylce2
//
//  Created by Christopher Woods on 1/21/24.
//

import SpriteKit
import GameplayKit
import AVKit

class GameScene: SKScene {
    var conveyer: SKSpriteNode!
    var textures: [SKTexture] = []
    var backgroundSky: SKSpriteNode!
    
    var greenBox: SKSpriteNode!
    var blueBox: SKSpriteNode!
    var yellowBox: SKSpriteNode!
    var trashBin : SKSpriteNode!
    
    
    var paperStack: SKSpriteNode!
    var waterBottle: SKSpriteNode!
    var sodaCan: SKSpriteNode!
    var pizzaBox: SKSpriteNode!
    var whiteBag: SKSpriteNode!
    var brownBag: SKSpriteNode!
    var pizzaBite: SKSpriteNode!
    
    var introSheet:SKSpriteNode!
    var howToPlay2: SKSpriteNode!
    var introExitButton: SKSpriteNode!
    var panel: SKSpriteNode!
    var resume: SKSpriteNode!
    var quit: SKSpriteNode!
    var pause: SKSpriteNode!
    var howToPlay: SKSpriteNode!
    var musicText: SKSpriteNode!
    var soundText: SKSpriteNode!
    var hapticText: SKSpriteNode!
    var slider1: SKSpriteNode!
    var slider2: SKSpriteNode!
    var slider3: SKSpriteNode!
    var pauseMenuExit: SKSpriteNode!
    var howToPlay2Exit :SKSpriteNode!
    let backgroundSound = SKAudioNode(fileNamed: "backgroundMusic")
    var scoreLabel: SKLabelNode!
    var score: Int = 0
    
    var gameTime: Double = 0
    var selectedNode: SKNode?
    var moving: Int = 1
    var isPaused2: Bool = true
    let nodeNames = ["sodaCan", "waterBottle","paperStack", "pizzaBox", "whiteBag", "brownBag", "pizzaBite"]
    let trashNodes = ["pizzaBox", "whiteBag", "brownBag","pizzaBite"]
    let boxNames = ["greenBox", "blueBox", "yellowBox"]
    var boxNodes: [SKSpriteNode] = []
    
    let squareSize = CGSize(width: 100, height: 100)
    var lifeNodes: [SKSpriteNode] = []
    
    var life: Int = 3
    var levelOneSpawns: [Int] = [6, 4, 5,3,1,0,2,1,0,3,2,1]
    
    
    let heavyHaptic = UIImpactFeedbackGenerator(style: .heavy)
    let lightHaptic = UIImpactFeedbackGenerator(style: .light)
    
    var isHaptic: Bool = true
    var isMusic: Bool = true
    var isSound: Bool = true
    
   

    // 2 - Play sound
    
    
    override func didMove(to view: SKView) {
//        self.backgroundColor = UIColor(red: 145/255, green: 217/255, blue: 255/255, alpha: 1.0)
        backgroundSky = SKSpriteNode(imageNamed: "DaySky")
        backgroundSky.name = "backgroundSky"
        backgroundSky.position = CGPoint(x: self.frame.width/2.0, y: self.frame.height/1.7)
        backgroundSky.zPosition = -10
        self.addChild(backgroundSky)
        
        
        setupGame()
        
        
        self.addChild(backgroundSound)
        
        
    }
    func createTexture(_ name:String) -> [SKTexture]{
        let textureAtlas = SKTextureAtlas(named: name)
        var frames = [SKTexture]()
        for i in 1...textureAtlas.textureNames.count - 1{
            frames.append(textureAtlas.textureNamed(textureAtlas.textureNames[i]))
        }
        return frames
    }
    func setUpHowToPlay2(){
        howToPlay2 = SKSpriteNode(imageNamed: "HowToPlay2")
        howToPlay2.name = "howToPlay2"
       
        howToPlay2.position = CGPoint(x: self.frame.width/2.0, y: self.frame.height/2.0)
        howToPlay2.zPosition = 59
        
        howToPlay2Exit  = SKSpriteNode(imageNamed: "PauseMenuExit")
        howToPlay2Exit.position = CGPoint(x: 125, y: 245)
        howToPlay2Exit.zPosition = 70
        howToPlay2Exit.name = "howToPlay2Exit"
        
        addChild(howToPlay2)
        howToPlay2.addChild(howToPlay2Exit)
    }
    
    func setUpIntro(delay: CGFloat){
        self.enumerateChildNodes(withName: "conveyer"){node, stop in
            if let action = node.action(forKey: "moving"){
                action.speed = 0
            }
            
        }
        isPaused2 = false
        introSheet = SKSpriteNode(imageNamed: "IntroSheet")
        introSheet.name = "introSheet"
        introSheet.position = CGPoint(x: self.frame.width/2.0, y: self.frame.height/2.0)
        introSheet.zPosition = 60
        
        introExitButton  = SKSpriteNode(imageNamed: "PauseMenuExit")
        introExitButton.position = CGPoint(x: 130, y: 260)
        introExitButton.zPosition = 70
        introExitButton.name = "introExitButton"
        
        
       
        addChild(introSheet)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [self] in
            introSheet.addChild(self.introExitButton)
            
        }
        
    }
    func removeSetup(){
        introSheet.removeFromParent()
        introExitButton.removeFromParent()
        
    }
    func removeSetup2(){
        howToPlay2Exit.removeFromParent()
        howToPlay2.removeFromParent()
        isPaused2 = true
        self.enumerateChildNodes(withName: "conveyer"){node, stop in
            if let action = node.action(forKey: "moving"){
                action.speed = 1
            }
                    
        }
    }
    
    func setupGame(){
//        spawnNewCircle()
        
        
        setUpBox(myBox: &greenBox, name: "greenBox", imageName: "NewPaperBin", x: 75)
        setUpBox(myBox: &blueBox, name: "blueBox", imageName: "NewPlasticBin", x: 200)
        setUpBox(myBox: &yellowBox, name: "yellowBox", imageName: "NewMetalBin", x: 325)
        setUpBox(myBox: &trashBin, name: "trashBin", imageName: "Truck2", x: 420, y: 154, zPosition: -3, myScale: 0.07)
//        setUpScoreBox()
        setUpConveyer()
        setUpPause()
        setUpLife()
        backgroundSound.run(SKAction.play())
        setUpIntro(delay: 2.0)
        
    }
    func setUpConveyer(){
        conveyer = SKSpriteNode(imageNamed: "Conveyer1")
        conveyer.position = CGPoint(x: 160, y: 65)
        conveyer.zPosition = -2
        conveyer.name = "conveyer"
        textures.append(SKTexture(imageNamed: "Conveyer1"))
        textures.append(SKTexture(imageNamed: "Conveyer2"))
        textures.append(SKTexture(imageNamed: "Conveyer3"))
        textures.append(SKTexture(imageNamed: "Conveyer4"))
        textures.append(SKTexture(imageNamed: "Conveyer5"))
      
        
        conveyer.run(SKAction.repeatForever(SKAction.animate(with: textures, timePerFrame: 0.1)), withKey: "moving")
                        
                        
        self.addChild(conveyer)
    }
    
    func touchDown(atPoint pos : CGPoint) {
       
    }
    
    func setUpLife(){
        life = 3
        let node1 = SKSpriteNode(imageNamed: "Heart")
        let node2 = SKSpriteNode(imageNamed: "Heart")
        let node3 = SKSpriteNode(imageNamed: "Heart")
        let place1 = SKSpriteNode(imageNamed: "HeartPlaceHolder")
        let place2 = SKSpriteNode(imageNamed: "HeartPlaceHolder")
        let place3 = SKSpriteNode(imageNamed: "HeartPlaceHolder")
        
        
        setUpLifePos(node1, i: self.frame.width/2.0 - 75, j: 675)
        setUpLifePos(node2, i: self.frame.width/2.0, j: 675)
        setUpLifePos(node3, i: self.frame.width/2.0 + 75, j: 675)
        //placeholderDots
        setUpLifePos(place1, i: self.frame.width/2.0 - 75, j: 675, zPosition: 49, setScale: 1)
        setUpLifePos(place2, i: self.frame.width/2.0, j: 675, zPosition: 49, setScale: 1)
        setUpLifePos(place3, i: self.frame.width/2.0 + 75, j: 675, zPosition: 49, setScale: 1)
        
        lifeNodes.append(node1)
        lifeNodes.append(node2)
        lifeNodes.append(node3)
    }
    func setUpLifePos(_ node: SKSpriteNode, i:CGFloat, j:CGFloat, zPosition: CGFloat = 50, setScale: CGFloat = 0.5){
        node.setScale(setScale)
        node.zPosition = zPosition
        node.position = (CGPoint(x: i, y: j))
        
        self.addChild(node)
    }
   
    
    
    
    
    func gameOver(){
        lifeNodes[life - 1].removeFromParent()
        life -= 1
        if isHaptic{
            heavyHaptic.impactOccurred()
        }
        if life <= 0 {
            life = 0
            //replace this with gameover screen
            self.view?.presentScene(GameOver(size: self.size))
        }
        
        
        
    }
    
    

    
    
    func touchMoved(toPoint pos : CGPoint) {
       
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        for t in touches { self.touchDown(atPoint: t.location(in: self))
            
            let touchedNodes = nodes(at: t.location(in: self))
            for touchedSprite in touchedNodes {
                
                for node in nodeNames{
                    if isPaused2{
                        if (touchedSprite.name == node) {
                            selectedNode = touchedSprite
                            touchedSprite.removeAllActions()
                        }
                    }
                }
                //go back to level select
                if (touchedSprite.name == "quit") {
                    let worldSelect = WorldSelect(size: self.size)
                    self.view?.presentScene(worldSelect)
                }
                if (touchedSprite.name == "slider3") {
                    if isHaptic{
                        slider3.removeFromParent()
                        createPanelHelper(myName: &slider3, name: "slider3", imageName: "SliderOff", x: 65, y: 0)
                        isHaptic = false
                        
                    }
                    else{
                        slider3.removeFromParent()
                        createPanelHelper(myName: &slider3, name: "slider3", imageName: "SliderOn", x: 65, y: 0)
                        isHaptic = true
                    }
                }
                if (touchedSprite.name == "slider1") {
                    if isMusic{
                        slider1.removeFromParent()
                        createPanelHelper(myName: &slider1, name: "slider1", imageName: "SliderOff", x: 65, y: 140)
                        isMusic = false
                        backgroundSound.run(SKAction.stop())
                        
                    }
                    else{
                        slider1.removeFromParent()
                        createPanelHelper(myName: &slider1, name: "slider1", imageName: "SliderOn", x: 65, y: 140)
                        
                        isMusic = true
                        backgroundSound.run(SKAction.play())
                    }
                }
                
                
                if (touchedSprite.name == "slider2") {
                    if isSound{
                        slider2.removeFromParent()
                        createPanelHelper(myName: &slider2, name: "slider2", imageName: "SliderOff", x: 65, y: 70)
                        isSound = false
                        backgroundSound.run(SKAction.stop())
                        
                    }
                    else{
                        slider2.removeFromParent()
                        createPanelHelper(myName: &slider2, name: "slider2", imageName: "SliderOn", x: 65, y: 70)
                        isSound = true
                        backgroundSound.run(SKAction.play())
                    }
                }

                
                if (touchedSprite.name == "introExitButton"){
                    removeSetup()
                    setUpHowToPlay2()
                }
                if (touchedSprite.name == "howToPlay2Exit"){
                    removeSetup2()
                }
                if (touchedSprite.name == "howToPlay"){
                    panel.removeFromParent()
                    setUpIntro(delay: 0)
                }
                //check if sprite resumed is clicked. if so target all nodes with name and stop their skaction
                if (touchedSprite.name == "pause") {
                    if !levelOneSpawns.isEmpty{
                        createPanel()
                        for nodeName in nodeNames {
                            self.enumerateChildNodes(withName: nodeName) {
                                node, stop in
                                if let action = node.action(forKey: "moving") {
                                    action.speed = 0
                                    
                                }
                            }
                        }
                        
                        //pauses conveyer anidmation too
                        self.enumerateChildNodes(withName: "conveyer"){node, stop in
                            if let action = node.action(forKey: "moving"){
                                action.speed = 0
                            }
                            
                        }
                        
                        isPaused2 = false
                    }
                                    
                }
                //check if sprite resumed is clicked. if so target all nodes with name and resume their skaction
                if (touchedSprite.name == "resume" || touchedSprite.name == "pauseMenuExit")  {
                    
                    panel.removeFromParent()
                    
                    for nodeName in nodeNames {
                        self.enumerateChildNodes(withName: nodeName) {
                            node, stop in
                            if let action = node.action(forKey: "moving") {
                                action.speed = 1
                            }
                        }
                    }
                   
                    self.enumerateChildNodes(withName: "conveyer"){node, stop in
                        if let action = node.action(forKey: "moving"){
                            action.speed = 1
                        }
                                
                    }
                    
                    isPaused2 = true
                    
                       
                }
                
                
                
                
                
                
                
            }
            
            
            
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isPaused2{
            //        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
            guard let selectedNode = selectedNode else {return}
            
            for touch in touches {
                let location = touch.location(in: self)
                selectedNode.position = location
            }
            
        }
    }
    
    func scoreHaptic(){
        if isHaptic{
            score += 1
            lightHaptic.impactOccurred()
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        if isPaused2{
            
            if let selectedNode{
                
                for node in boxNodes{
                    
                    
                    if node.contains(selectedNode.position) {
                        // Circle is released within the target square
                        if selectedNode.name == "paperStack" && node.name == "greenBox"{
                            scoreHaptic()
                            
                        }
                        else if selectedNode.name == "waterBottle" && node.name == "blueBox"{
                            scoreHaptic()
                        }
                        else if selectedNode.name == "sodaCan" && node.name == "yellowBox"{
                            scoreHaptic()
                        }
                        else if trashNodes.contains(selectedNode.name!) && node.name == "trashBin"{
                            scoreHaptic()
                        }
                        else{
                            gameOver()
                            
                        }
                        
                        
                      
                        selectedNode.removeFromParent()
                        
                    }
                    
                    else{
                        let shrink = SKAction.resize(toWidth: 0,height : 0, duration: 3)
                        let minusPoint = SKAction.run{ [self] in
                            gameOver()
                        }
                        let remove = SKAction.removeFromParent()
                        
                        let removeSequence = SKAction.sequence([shrink, remove])
                        
                        selectedNode.run(removeSequence)
                    }
                    
                    
                }
            }
            
            selectedNode = nil
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
//    func setUpSquare(){
//        
////        targetSquare = SKShapeNode(rectOf: squareSize)
////        targetSquare.fillColor = UIColor.green
////        targetSquare.position = CGPoint(x: size.width / 2, y: size.height - squareSize.height / 2)
////        targetSquare.zPosition = 0 // Place the square below the circle
////
////        // Add the target square to the scene
//        targetSquare = SKSpriteNode(imageNamed: "GreenTub")
//        targetSquare.position = CGPoint(x: size.width / 2, y: size.height - squareSize.height)
//        targetSquare.zPosition = 0 // Place the square below the circle
//        targetSquare.setScale(0.2)
//        addChild(targetSquare)
//    }
    func setUpBox(myBox: inout SKSpriteNode!, name: String, imageName: String, x: Int = 100, y: Int = 550, zPosition: Int = 0 , myScale: CGFloat = 1){
        myBox = SKSpriteNode(imageNamed: imageName)
        myBox.position = CGPoint(x: x ,y: y)
        myBox.zPosition = CGFloat(zPosition) // Place the square below the circle
        
        myBox.name = name
        myBox.setScale(myScale)
        boxNodes.append(myBox)
        addChild(myBox)
    }
    
    func setUpScoreBox(){
        scoreLabel = SKLabelNode(text: "Score: 0")
        
        scoreLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height - 100)
        addChild(scoreLabel)
        setUpPause()
    }
    
    func incrementScore(){
        score += 1
//        scoreLabel.text = "Score: \(score)"
    }
    func spawnItem(myName: inout SKSpriteNode!, name: String, imageName: String, setScale: CGFloat = 0.1, x: Int = -60, y: Int = 120, isTrash: Bool) {
        myName = SKSpriteNode(imageNamed: imageName)
        myName.setScale(setScale)
        myName.position = CGPoint(x: x, y:y)
        myName.zPosition = 1
        myName.name = name
        
        let moveRight = SKAction.moveTo(x: 320, duration: 6)
        let shrink = SKAction.resize(toWidth: 0,height : 0, duration: 2)
        let wait = SKAction.wait(forDuration: 1.1)
        let remove = SKAction.removeFromParent()
        if isTrash{
            let completionAction = SKAction.run { [self] in
                name == name ? incrementScore() : gameOver()
                
            }
            let moveSequence = SKAction.sequence([wait, moveRight,shrink, completionAction, remove])
            myName.run(SKAction.repeatForever(moveSequence), withKey:"moving")
        }
        else{
            let completionAction = SKAction.run { [self] in
                name == name ? gameOver() : incrementScore()
            }
            let moveSequence = SKAction.sequence([wait, moveRight, shrink, completionAction, remove])
            myName.run(SKAction.repeatForever(moveSequence), withKey:"moving")
        }
        

        addChild(myName)
    }
    func createPanelHelper(myName: inout SKSpriteNode!, name: String, imageName: String, setScale: CGFloat = 0.1, x: Int = -60, y: Int = 105){
        myName = SKSpriteNode(imageNamed: imageName)
        myName.position = CGPoint(x: x, y: y)
        myName.name = name
        panel.addChild(myName)
    }

    func createPanel(){
        if childNode(withName: "panel") == nil{
            panel = SKSpriteNode(imageNamed: "PauseMenu")
            panel.name = "panel"
            panel.position = CGPoint(x: self.frame.width/2.0, y: self.frame.height/2.0)
            panel.zPosition = 60
            addChild(panel)
            
            
            createPanelHelper(myName: &slider1, name: "slider1", imageName: isMusic ? "SliderOn" : "SliderOff", x: 65, y: 140)
            createPanelHelper(myName: &slider2, name: "slider2", imageName: isSound ? "SliderOn" : "SliderOff", x: 65, y: 70)
            createPanelHelper(myName: &slider3, name: "slider3", imageName: isHaptic ? "SliderOn" : "SliderOff", x: 65, y: 0)
            createPanelHelper(myName: &musicText, name: "musicText", imageName: "Music", x: -65, y: 140)
            createPanelHelper(myName: &soundText, name: "soundText", imageName: "Sound", x: -65, y: 70)
            createPanelHelper(myName: &hapticText, name: "hapticText", imageName: "Haptic", x: -65, y: 0)
            createPanelHelper(myName: &howToPlay, name: "howToPlay", imageName: "HowToPlayButton", x: 0, y: -100)
            createPanelHelper(myName: &resume, name: "resume", imageName: "PausePlayButton", x: -65, y: -200)
            createPanelHelper(myName: &quit, name: "quit", imageName: "PauseHomeButton", x: 65, y: -200)
            createPanelHelper(myName: &pauseMenuExit, name: "pauseMenuExit", imageName: "PauseMenuExit", x: 130, y: 260)
            
        }
    }
    
    
    
    
    func setUpPause(){
        pause = SKSpriteNode(imageNamed: "SettingsButton")
        pause.name = "pause"
        pause.position = CGPoint(x: self.frame.width / 8 , y: self.frame.height / 1.09)
        addChild(pause)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        //stops incrementing everything when paused
        if isPaused2{
            gameTime += 1.0
        }
        
        if gameTime.truncatingRemainder(dividingBy: 120.0) == 0 && isPaused2{
//            var randomInt = Int.random(in: 1..<3)
//            if randomInt == 1{
//                spawnNewCircle(name: "Circle", color: UIColor.green)
//            }
//            else{
//                spawnNewCircle(name: "Circle2", color: UIColor.red)
//            }
            if !levelOneSpawns.isEmpty{
                
                if levelOneSpawns.first == 0 {
                    spawnItem(myName: &paperStack, name: "paperStack", imageName: "Paper_Stack",y: 110, isTrash: false)
                }
                if levelOneSpawns.first == 1 {
                    spawnItem(myName: &waterBottle, name: "waterBottle", imageName: "Water_Bottle", setScale: 0.15, isTrash: false)
                }
                if levelOneSpawns.first == 2 {
                    spawnItem(myName: &sodaCan, name: "sodaCan", imageName: "Soda_Can",setScale: 0.15, y: 110, isTrash: false)
                }
                if levelOneSpawns.first == 3 {
                    spawnItem(myName: &pizzaBox, name: "pizzaBox", imageName: "PizzaBoxTrash",setScale: 0.02, y: 110, isTrash: true)
                }
                if levelOneSpawns.first == 4 {
                    spawnItem(myName: &whiteBag, name: "whiteBag", imageName: "TrashBag",setScale: 0.03, y: 120, isTrash: true)
                }
                if levelOneSpawns.first == 5 {
                    spawnItem(myName: &whiteBag, name: "brownBag", imageName: "BrownBag",setScale: 0.03, y: 120, isTrash: true)
                }
                if levelOneSpawns.first == 6 {
                    spawnItem(myName: &pizzaBite, name: "pizzaBite", imageName: "PizzaBite",setScale: 0.07, y: 110, isTrash: true)
                }
                
                levelOneSpawns.removeFirst()
            }
            else{
               //replace this with a win screen
                
                if selectedNode == nil && isPaused2{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
                        LevelComplete.starAmount = self.life
                        self.view?.presentScene(LevelComplete(size: self.size))
                        
                    }
                }
                
            }
            
        }
        
    }
    
    
}

//
//
//    func spawnPaperStack(name: String) {
//        paperStack = SKSpriteNode(imageNamed: "Paper_Stack")
//        paperStack.setScale(0.1)
//        paperStack.position = CGPoint(x: -60, y: 70)
//        paperStack.zPosition = 1 // Place the circle above the square
//        paperStack.name = name
//
//        let moveRight = SKAction.moveTo(x: 420, duration: 5)
//        let wait = SKAction.wait(forDuration: 2)
//        let remove = SKAction.removeFromParent()
//        let completionAction = SKAction.run { [self] in
//            name == "paperStack" ? gameOver() : incrementScore()
//        }
//        let moveSequence = SKAction.sequence([wait, moveRight, completionAction, remove])
//        paperStack.run(SKAction.repeatForever(moveSequence), withKey:"moving")
//
//        addChild(paperStack)
//
//
//        }
//
//    func spawnWaterBottle(name: String) {
//        waterBottle = SKSpriteNode(imageNamed: "Water_Bottle")
//        waterBottle.setScale(0.15)
//        waterBottle.position = CGPoint(x: -60, y: 70)
//        waterBottle.zPosition = 1 // Place the circle above the square
//        waterBottle.name = name
//
//        let moveRight = SKAction.moveTo(x: 420, duration: 5)
//        let wait = SKAction.wait(forDuration: 2)
//        let remove = SKAction.removeFromParent()
//        let completionAction = SKAction.run { [self] in
//            name == "waterBottle" ? gameOver() : incrementScore()
//        }
//
//        let moveSequence = SKAction.sequence([wait, moveRight, completionAction, remove])
//        waterBottle.run(SKAction.repeatForever(moveSequence), withKey:"moving")
//        addChild(waterBottle)
//
//    }
//    func spawnSodaCan(name: String) {
//        sodaCan = SKSpriteNode(imageNamed: "Soda_Can")
//        sodaCan.setScale(0.2)
//        sodaCan.position = CGPoint(x: -60, y: 70)
//        sodaCan.zPosition = 1 // Place the circle above the square
//        sodaCan.name = name
//
//        let moveRight = SKAction.moveTo(x: 420, duration: 5)
//        let wait = SKAction.wait(forDuration: 2)
//        let remove = SKAction.removeFromParent()
//        let completionAction = SKAction.run { [self] in
//            name == "sodaCan" ? gameOver() : incrementScore()
//        }
//
//        let moveSequence = SKAction.sequence([wait, moveRight, completionAction, remove])
//        sodaCan.run(SKAction.repeatForever(moveSequence), withKey:"moving")
//        addChild(sodaCan)
//
//    }
    
