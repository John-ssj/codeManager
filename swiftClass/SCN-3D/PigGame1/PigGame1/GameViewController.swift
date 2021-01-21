//
//  GameViewController.swift
//  PigGame1
//
//  Created by 史导的Mac on 2020/12/8.
//

import UIKit
import SceneKit
import SpriteKit
//import GameplayKit


class GameViewController: UIViewController {
    
    let game = GameHelper.sharedInstance
    
    var activeCollisionsBitMask: Int = 0
    
    var scnView: SCNView!
    var gameScene: SCNScene!
    var splashScene: SCNScene!
    
    var pigNode: SCNNode!
    var cameraNode: SCNNode!
    var cameraFollowNode: SCNNode!
    var lightFollowNode: SCNNode!
    var trafficNode: SCNNode!
    
    var collisionNode: SCNNode!
    var frontCollisionNode: SCNNode!
    var backCollisionNode: SCNNode!
    var leftCollisionNode: SCNNode!
    var rightCollisionNode: SCNNode!
    
    var driveLeftAction: SCNAction!
    var driveRightAction: SCNAction!
    
    var jumpLeftAction: SCNAction!
    var jumpRightAction: SCNAction!
    var jumpForwardAction: SCNAction!
    var jumpBackwardAction: SCNAction!
    
    var triggerGameOver: SCNAction!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let view = self.view as! SKView? {
//            // Load the SKScene from 'GameScene.sks'
//            if let scene = SKScene(fileNamed: "GameScene") {
//                // Set the scale mode to scale to fit the window
//                scene.scaleMode = .aspectFill
//
//                // Present the scene
//                view.presentScene(scene)
//            }
//
//            view.ignoresSiblingOrder = true
//
//            view.showsFPS = true
//            view.showsNodeCount = true
//        }
        
        setupScenes()
        setupNodes()
        setupActions()
        setupTraffic()
        setupGestures()
        setupSounds()
        
        game.state = .tapToPlay
    }
    
    func setupScenes() {
        scnView = SCNView(frame: self.view.frame)
        self.view.addSubview(scnView)
        scnView.delegate = self
        
        gameScene = SCNScene(named: "/MrPig.scnassets/GameScene2.scn")
        gameScene.physicsWorld.contactDelegate = self
        splashScene = SCNScene(named: "/MrPig.scnassets/SplashScene2.scn")
        scnView.present(splashScene, with: .doorsOpenHorizontal(withDuration: 0.5), incomingPointOfView: nil, completionHandler: nil)
    }
    
    func setupNodes() {
        pigNode = gameScene.rootNode.childNode(withName: "MrPig", recursively:true)!
        cameraNode = gameScene.rootNode.childNode(withName: "camera", recursively: true)!
        cameraNode.addChildNode(game.hudNode)
        cameraFollowNode = gameScene.rootNode.childNode(withName: "FollowCamera", recursively: true)!
        lightFollowNode = gameScene.rootNode.childNode(withName: "FollowLight", recursively: true)!
        trafficNode = gameScene.rootNode.childNode(withName: "Traffic", recursively: true)!
        
        collisionNode = gameScene.rootNode.childNode(withName: "Collision", recursively: true)!
        frontCollisionNode = gameScene.rootNode.childNode(withName: "Front", recursively: true)!
        backCollisionNode = gameScene.rootNode.childNode(withName: "Back", recursively: true)!
        leftCollisionNode = gameScene.rootNode.childNode(withName: "Left", recursively: true)!
        rightCollisionNode = gameScene.rootNode.childNode(withName: "Right", recursively: true)!
        
        pigNode.physicsBody?.contactTestBitMask = BitMasks.BitMaskVehicle | BitMasks.BitMaskCoin | BitMasks.BitMaskHouse
        frontCollisionNode.physicsBody?.contactTestBitMask = BitMasks.BitMaskObstacle
        backCollisionNode.physicsBody?.contactTestBitMask = BitMasks.BitMaskObstacle
        leftCollisionNode.physicsBody?.contactTestBitMask = BitMasks.BitMaskObstacle
        rightCollisionNode.physicsBody?.contactTestBitMask = BitMasks.BitMaskObstacle
    }
    
    func setupActions() {
        driveLeftAction = SCNAction.repeatForever(SCNAction.move(by:
        SCNVector3Make(-2.0, 0, 0), duration: 1.0))
        driveRightAction = SCNAction.repeatForever(SCNAction.move(by:
        SCNVector3Make(2.0, 0, 0), duration: 1.0))
        
        let duration = 0.2
        
        let bounceUpAction = SCNAction.moveBy(x: 0, y: 1.0, z: 0, duration: duration * 0.5)
        let bounceDownAction = SCNAction.moveBy(x: 0, y: -1.0, z: 0, duration: duration * 0.5)
        
        bounceUpAction.timingMode = .easeOut
        bounceDownAction.timingMode = .easeIn
        
        let bounceAction = SCNAction.sequence([bounceUpAction, bounceDownAction])
        
        let moveLeftAction = SCNAction.moveBy(x: -1.0, y: 0, z: 0, duration: duration)
        let moveRightAction = SCNAction.moveBy(x: 1.0, y: 0, z: 0, duration: duration)
        let moveForwardAction = SCNAction.moveBy(x: 0, y: 0, z: -1.0, duration: duration)
        let moveBackwardAction = SCNAction.moveBy(x: 0, y: 0, z: 1.0, duration: duration)
        
        let turnLeftAction = SCNAction.rotateTo(x: 0, y: convertToRadians(angle: -90), z: 0, duration: duration, usesShortestUnitArc: true)
        let turnRightAction = SCNAction.rotateTo(x: 0, y: convertToRadians(angle: 90), z: 0, duration: duration, usesShortestUnitArc: true)
        let turnForwardAction = SCNAction.rotateTo(x: 0, y:
        convertToRadians(angle: 180),  z: 0, duration: duration, usesShortestUnitArc: true)
        let turnBackwardAction = SCNAction.rotateTo(x: 0, y:
        convertToRadians(angle: 0),  z: 0, duration: duration, usesShortestUnitArc: true)
        
        jumpLeftAction = SCNAction.group([turnLeftAction, bounceAction, moveLeftAction])
        jumpRightAction = SCNAction.group([turnRightAction, bounceAction, moveRightAction])
        jumpForwardAction = SCNAction.group([turnForwardAction, bounceAction, moveForwardAction])
        jumpBackwardAction = SCNAction.group([turnBackwardAction, bounceAction, moveBackwardAction])
        
        
        let spinAround = SCNAction.rotateBy(x: 0, y: convertToRadians(angle:
        720), z: 0, duration: 2.0)
        let riseUp = SCNAction.moveBy(x: 0, y: 10, z: 0, duration: 2.0)
        let fadeOut = SCNAction.fadeOpacity(to: 0, duration: 2.0)
        let goodByePig = SCNAction.group([spinAround, riseUp, fadeOut])

        let gameOver = SCNAction.run { (node:SCNNode) -> Void in
            self.pigNode.position = SCNVector3(0, 0, 0)
            self.pigNode.eulerAngles = SCNVector3(0, 0, 0)
            self.pigNode.opacity = 1.0
            self.startSplash()
        }
        
        triggerGameOver = SCNAction.sequence([goodByePig, gameOver])
    }
    
    func setupTraffic() {
        for node in trafficNode.childNodes {
          if node.name?.contains("Bus") == true {
            driveLeftAction.speed = 1.0
            driveRightAction.speed = 1.0
          } else {
            driveLeftAction.speed = 2.0
            driveRightAction.speed = 2.0
          }
          if node.eulerAngles.y > 0 {
            node.runAction(driveLeftAction)
        } else {
            node.runAction(driveRightAction)
          }
        }
    }
    
    func setupGestures() {
        let swipeRight = UISwipeGestureRecognizer(target: self,
                                                  action: #selector(GameViewController.handleGesture(_:)))
        swipeRight.direction = .right
        scnView.addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self,
                                                 action: #selector(GameViewController.handleGesture(_:)))
        swipeLeft.direction = .left
        scnView.addGestureRecognizer(swipeLeft)
        let swipeForward = UISwipeGestureRecognizer(target: self,
                                                    action: #selector(GameViewController.handleGesture(_:)))
        swipeForward.direction = .up
        scnView.addGestureRecognizer(swipeForward)
        let swipeBackward = UISwipeGestureRecognizer(target: self,
                                                     action: #selector(GameViewController.handleGesture(_:)))
        swipeBackward.direction = .down
        scnView.addGestureRecognizer(swipeBackward)
    }
    
    func setupSounds() {
        if game.state == .tapToPlay {
            let music = SCNAudioSource(fileNamed: "MrPig.scnassets/Audio/Music.mp3")!
                music.volume = 0.3;
                music.loops = true
                music.shouldStream = true
                music.isPositional = false
            
            let musicPlayer = SCNAudioPlayer(source: music)
            splashScene.rootNode.addAudioPlayer(musicPlayer)
        }
        
        else if game.state == .playing {
            
            let traffic = SCNAudioSource(fileNamed: "MrPig.scnassets/Audio/Traffic.mp3")!
            traffic.volume = 0.3
            traffic.loops = true
            traffic.shouldStream = true
            traffic.isPositional = true
            
            let trafficPlayer = SCNAudioPlayer(source: traffic)
            gameScene.rootNode.addAudioPlayer(trafficPlayer)
            
            game.loadSound(name: "Jump", fileNamed: "MrPig.scnassets/Audio/Jump.wav")
            game.loadSound(name: "Blocked", fileNamed: "MrPig.scnassets/Audio/Blocked.wav")
            game.loadSound(name: "Crash", fileNamed: "MrPig.scnassets/Audio/Crash.wav")
            game.loadSound(name: "CollectCoin", fileNamed: "MrPig.scnassets/Audio/CollectCoin.wav")
            game.loadSound(name: "BankCoin", fileNamed: "MrPig.scnassets/Audio/BankCoin.wav")
        }

    }
    
    func updatePositions() {
        // 小猪周围4个检测方块
        collisionNode.position = pigNode.position
        
        // 摄像头
        let lerpX = (pigNode.position.x - cameraFollowNode.position.x) * 0.05
        let lerpZ = (pigNode.position.z - cameraFollowNode.position.z) * 0.05
        cameraFollowNode.position.x += lerpX
        cameraFollowNode.position.z += lerpZ
        
        // 灯光
        lightFollowNode.position = cameraFollowNode.position
    }
    
    func updateTraffic() {
        for node in trafficNode.childNodes {
            if node.position.x > 25 {
                node.position.x = -25
            } else if node.position.x < -25 {
                node.position.x = 25
            }
        }
    }
    
    
    func startGame() {
        splashScene.isPaused = true
        let transition = SKTransition.doorsOpenVertical(withDuration: 1.0)
        scnView.present(gameScene, with: transition, incomingPointOfView: nil, completionHandler: {
            self.game.state = .playing
            self.setupSounds()
            self.gameScene.isPaused = false
        })
    }
    
    func stopGame() {
        game.state = .gameOver
        game.reset()
        pigNode.runAction(triggerGameOver)
    }
    
    func startSplash() {
        gameScene.isPaused = true
        let transition = SKTransition.doorsOpenVertical(withDuration: 1.0)
        scnView.present(splashScene, with: transition, incomingPointOfView: nil, completionHandler: {
            self.game.state = .tapToPlay
            self.setupSounds()
            self.splashScene.isPaused = false
        })
    }
    
    @objc func handleGesture(_ sender: UISwipeGestureRecognizer) {
        guard game.state == .playing else { return }
        
        let activeFrontCollision = ((activeCollisionsBitMask & BitMasks.BitMaskFront) == BitMasks.BitMaskFront)
        let activeBackCollision = ((activeCollisionsBitMask & BitMasks.BitMaskBack) == BitMasks.BitMaskBack)
        let activeLeftCollision = ((activeCollisionsBitMask & BitMasks.BitMaskLeft) == BitMasks.BitMaskLeft)
        let activeRightCollision = ((activeCollisionsBitMask & BitMasks.BitMaskRight) == BitMasks.BitMaskRight)
        guard (sender.direction == .up && !activeFrontCollision) ||
                (sender.direction == .down && !activeBackCollision) ||
                (sender.direction == .left && !activeLeftCollision) ||
                (sender.direction == .right && !activeRightCollision) else {
            game.playSound(node: pigNode, name: "Blocked")
            return
        }
        
        switch sender.direction {
        case .up:
            pigNode.runAction(jumpForwardAction)
        case .down:
            pigNode.runAction(jumpBackwardAction)
        case .left:
            if pigNode.position.x >  -15 {
                pigNode.runAction(jumpLeftAction)
            }
        case .right:
            if pigNode.position.x < 15 {
                pigNode.runAction(jumpRightAction)
            }
        default:
            break
        }
        game.playSound(node: pigNode, name: "Jump")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if game.state == .tapToPlay{
            startGame()
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 控制状态栏
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // 控制屏幕旋转
    override var shouldAutorotate: Bool {
        return true
    }
}


extension GameViewController: SCNSceneRendererDelegate, SCNPhysicsContactDelegate {
    
    struct BitMasks {
        static let BitMaskPig = 1
        static let BitMaskVehicle = 2
        static let BitMaskObstacle = 4
        static let BitMaskFront = 8
        static let BitMaskBack = 16
        static let BitMaskLeft = 32
        static let BitMaskRight = 64
        static let BitMaskCoin = 128
        static let BitMaskHouse = 256
    }
    
    
    // RendererDelegate
    func renderer(_ renderer: SCNSceneRenderer, didApplyAnimationsAtTime time: TimeInterval) {
        guard game.state == .playing else { return }
        game.updateHUD()
        updatePositions()
        updateTraffic()
    }
    
    
    // PhysicsContactDelegate
    func physicsWorld(_ world: SCNPhysicsWorld,
                      didBegin contact: SCNPhysicsContact) {
        
        guard game.state == .playing else {
            return
        }
        
        
        // 边界检测
        var collisionBoxNode: SCNNode!
        if contact.nodeA.physicsBody?.categoryBitMask == BitMasks.BitMaskObstacle {
            collisionBoxNode = contact.nodeB
        } else {
            collisionBoxNode = contact.nodeA
        }
        
        activeCollisionsBitMask |=    collisionBoxNode.physicsBody!.categoryBitMask
        
        
        // 撞车检测，游戏结束
        var contactNode: SCNNode!
        if contact.nodeA.physicsBody?.categoryBitMask == BitMasks.BitMaskPig {
            contactNode = contact.nodeB
        } else {
            contactNode = contact.nodeA
        }
        
        if contactNode.physicsBody?.categoryBitMask == BitMasks.BitMaskVehicle {
            stopGame()
            game.playSound(node: pigNode, name: "Crash")
        }
        
        
        // 收集金币
        if contactNode.physicsBody?.categoryBitMask == BitMasks.BitMaskCoin {
          contactNode.isHidden = true
            //隐藏金币,并在60秒后重新出现
            contactNode.runAction(SCNAction.waitForDurationThenRunBlock(duration: 0) { (node: SCNNode!) -> Void in
                node.isHidden = false
            })
            game.collectCoin()
            game.playSound(node: pigNode, name: "CollectCoin")
        }
    }
    
    
    func physicsWorld(_ world: SCNPhysicsWorld,
                      didEnd contact: SCNPhysicsContact) {
        
        guard game.state == .playing else {
            return
        }
        
        var collisionBoxNode: SCNNode!
        if contact.nodeA.physicsBody?.categoryBitMask == BitMasks.BitMaskObstacle {
            collisionBoxNode = contact.nodeB
        } else {
            collisionBoxNode = contact.nodeA
        }
        
        activeCollisionsBitMask &=
            ~collisionBoxNode.physicsBody!.categoryBitMask
    }
    
}
