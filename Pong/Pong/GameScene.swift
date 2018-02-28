//
//  GameScene.swift
//  Pong
//
//  Created by Tao Ong on 2/27/18.
//  Copyright © 2018 Tao Ong. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    var mainScore = SKLabelNode()
    var enemyScore = SKLabelNode()
    
    var score = [Int]()
    
    func startGame() {
        score = [0, 0]
        ball.physicsBody?.applyImpulse(CGVector(dx: -20, dy: -20))
    }
    
    func addScore(player : SKSpriteNode) {
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if player == main {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
            mainScore.text = "\(score[0])"
        } else if player == enemy {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -20, dy: -20))
            enemyScore.text = "\(score[1])"
        }
        
    }
    
    override func didMove(to view: SKView) {
        
        startGame()
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        main = self.childNode(withName: "main") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        mainScore = self.childNode(withName: "mainScore") as! SKLabelNode
        enemyScore = self.childNode(withName: "enemyScore") as! SKLabelNode
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            main.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            main.run(SKAction.moveTo(x: location.x, duration: 0))
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        switch currentGameType {
        case .easy:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.3))
            break
        case .medium:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
            break
        case .hard:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.7))
            break
        }
        
        
        if ball.position.y <= main.position.y - 70 {
            addScore(player: enemy)
        } else if ball.position.y >= enemy.position.y + 70  {
            addScore(player: main)
        }
    }
}
