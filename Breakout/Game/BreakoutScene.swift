//
//  BreakoutScene.swift
//  Breakout
//
//  Created by Samuel K on 5/7/21.
//
/*
 To do:
 
 5. Score
 */

import Foundation
import SpriteKit
import GameplayKit

class BreakoutScene: SKScene, SKPhysicsContactDelegate {
    
    var balls = [SKShapeNode]()
    var numLives = 3
    var paddle: Paddle?
    var bottomBarrier: Barrier?
    var bricks = [Brick]()
    var paddleDirection = PaddleDirection.still
    var gameOverLabel: SKLabelNode?
    var score: Int = 0
    var scoreLabel: SKLabelNode?
    var livesLabel: SKLabelNode?
    
    let textDisplayHeight: CGFloat = 20
    let gravityVector = CGVector(dx: 0, dy: 0)
    let gameGroup: UInt32 = 1
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .blue
        startGame()
    }
    
    func startGame() {
        self.scene?.removeAllChildren()
        createPhysics()
        createBall()
        createPaddle()
        createBarriers()
        createBricks()
        createScore()
        createLives()
        gameOverLabel = nil
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard let paddle = self.paddle else { return }
        guard let view = self.view else { return }

        switch self.paddleDirection {
        case .still:
            break
        case .left:
            if paddle.position.x > paddle.width/2 {
                paddle.position = CGPoint(x: paddle.position.x-4, y: paddle.position.y)
            }
            
        case .right:
            if paddle.position.x < view.frame.maxX-paddle.width/2 {
                paddle.position = CGPoint(x: paddle.position.x+4, y: paddle.position.y)
            }
        }
    }
    
    func createPhysics() {
        self.physicsWorld.gravity = gravityVector
        self.physicsWorld.contactDelegate = self
    }
    
    fileprivate func createABall(_ view: SKView, _ i: Int) {
        let ball = SKShapeNode(circleOfRadius: 10)
        
        ball.position = CGPoint(x: view.frame.midX+CGFloat(i)*20, y: 40)
        ball.fillColor = .white
        
        let speed: CGFloat = 140
        let yVelocity = CGFloat(GKARC4RandomSource.sharedRandom().nextInt(upperBound: 20))+90
        let xVelocity: CGFloat
        if GKARC4RandomSource.sharedRandom().nextBool() {
            xVelocity = sqrt(speed*speed-yVelocity*yVelocity) * -1
        }
        else {
            xVelocity = sqrt(speed*speed-yVelocity*yVelocity)
        }
        
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        ball.physicsBody?.velocity = CGVector(dx: xVelocity, dy: yVelocity)
        ball.physicsBody?.collisionBitMask = gameGroup
        ball.physicsBody?.contactTestBitMask = gameGroup
        
        ball.physicsBody?.friction = 0
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.allowsRotation = false
        ball.physicsBody?.angularDamping = 0
        ball.physicsBody?.restitution = 1
        
        self.balls.append(ball)
        addChild(ball)
    }
    
    func createBall() {
        guard let view = self.view else { return }
        
        let numBalls = 1
        self.balls.removeAll()
        for i in 0..<numBalls {
            createABall(view, i)
        }
    }
    
    func createPaddle() {
        guard let view = self.view else { return }
        
        let size = CGSize(width: 100, height: 5)
        let paddle = Paddle(size: size)
        paddle.position = CGPoint(x: view.frame.midX, y: size.height)
        
        self.paddle = paddle
        addChild(paddle)
    }
    
    func createBarriers() {
        guard let view = self.view else { return }
        
        let size = CGSize(width: 1, height: view.frame.size.height)
        let leftBarrier = Barrier(size: size)
        leftBarrier.position = CGPoint(x: 0, y: view.frame.midY)
        
        addChild(leftBarrier)
        
        let rightBarrier = Barrier(size: size)
        rightBarrier.position = CGPoint(x: view.frame.size.width, y: view.frame.midY)
        
        addChild(rightBarrier)
        
        let horizontalSize = CGSize(width: view.frame.size.width, height: 1)
        let topBarrier = Barrier(size: horizontalSize)
        topBarrier.position = CGPoint(x: view.frame.midX, y: view.frame.maxY)
        
        addChild(topBarrier)
        
        let bottomBarrier = Barrier(size: horizontalSize)
        bottomBarrier.position = CGPoint(x: view.frame.midX, y: view.frame.minY)
        
        self.bottomBarrier = bottomBarrier
        addChild(bottomBarrier)
    }
    
    func createBricks() {
        guard let view = self.view else { return }
        bricks = [Brick]()
        
        let brickWidth: CGFloat = 40
        let brickHeight: CGFloat = 20
        let brickSize = CGSize(width: brickWidth, height: brickHeight)
        let numBricks: Int = Int(view.frame.size.width/brickWidth)
        for brickY in 0..<4 {
            for brickX in 0..<numBricks {
                let brick = Brick(size: brickSize)
                brick.position = CGPoint(x: view.frame.minX+brickWidth/2+(brickWidth*CGFloat(brickX)), y: (view.frame.maxY-brickHeight-textDisplayHeight)-(CGFloat(brickY)*brickHeight))
                
                addChild(brick)
                bricks.append(brick)
            }
        }
    }
    
    func createScore() {
        guard let view = self.view else { return }
        
        score = 0
        let scoreLabel = SKLabelNode(text: "Score: \(score)")
        scoreLabel.fontSize = 20
        scoreLabel.fontColor = .white
        scoreLabel.fontName = "Courier"
        scoreLabel.position = CGPoint(x: view.frame.maxX-70, y: view.frame.maxY-textDisplayHeight)
        
        self.scoreLabel = scoreLabel
        addChild(scoreLabel)
    }
    
    func createLives() {
        guard let view = self.view else { return }
        
        let livesLabel = SKLabelNode(text: "Lives: \(numLives-1)")
        livesLabel.fontSize = 20
        livesLabel.fontColor = .white
        livesLabel.fontName = "Courier"
        livesLabel.position = CGPoint(x: 70, y: view.frame.maxY-textDisplayHeight)
        
        self.livesLabel = livesLabel
        addChild(livesLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let view = self.view, let position = touches.first?.location(in: view) else { return }
        if gameOverLabel != nil {
            startGame()
        }
        else if position.x<view.frame.midX {
            self.paddleDirection = .left
        }
        else {
            self.paddleDirection = .right
        }
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.paddleDirection = .still
    }
    
    func checkBrickContact(_ contact: SKPhysicsContact) {
        var done = false
        for brick in bricks {
            if done {
                break
            }
            for ball in self.balls {
                if (contact.bodyA == ball.physicsBody && contact.bodyB == brick.physicsBody) ||
                    (contact.bodyA == brick.physicsBody && contact.bodyB == ball.physicsBody){
                    brick.removeFromParent()
                    bricks.removeAll{$0 == brick}
                    score += 10
                    scoreLabel?.text = "Score: \(score)"
                    done = true
                    break
                }
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let bottomBarrier = self.bottomBarrier else { return }
        guard let view = self.view else { return }

        for ball in self.balls {
            if (contact.bodyA == ball.physicsBody && contact.bodyB == bottomBarrier.physicsBody) ||
                (contact.bodyA == bottomBarrier.physicsBody && contact.bodyB == ball.physicsBody){
                numLives -= 1
                livesLabel?.text = "Lives: \(numLives-1)"
                if numLives == 0 {
                    endGame(text: "Game Over")
                    return
                }
                else {
                    ball.removeFromParent()
                    balls.removeAll(where: {$0 == ball})
                    createABall(view, 0)
                    break
                }
            }
        }
        
        checkPaddleContact(contact)
        checkBrickContact(contact)
        checkForWin()
    }
    
    func checkForWin() {
        if bricks.isEmpty {
            endGame(text: "Congratulations! You Win!")
        }
    }
    
    func checkPaddleContact(_ contact: SKPhysicsContact) {
        guard let paddle = self.paddle else { return }
        
        for ball in self.balls {
            if (contact.bodyA == ball.physicsBody && contact.bodyB == paddle.physicsBody) ||
                (contact.bodyA == paddle.physicsBody && contact.bodyB == ball.physicsBody){
                // Checks where on the paddle the ball touched and adjusts the ball's trajectory based on that.
                // Possible solution: (ball.position.x-paddle.position.x)/50
                if (ball.position.x<paddle.position.x) {
                    ball.physicsBody?.applyImpulse(CGVector(dx: -1, dy: 0))
                }
                else {
                    ball.physicsBody?.applyImpulse(CGVector(dx: 1, dy: 0))
                }
            }
        }
    }
    
    func endGame(text: String) {
        guard let view = self.view else { return }

        self.scene?.removeAllChildren()
        let gameOverLabel = SKLabelNode(text: text)
        gameOverLabel.fontSize = 20
        gameOverLabel.fontColor = .white
        gameOverLabel.fontName = "Courier"
        gameOverLabel.position = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 2)
        
        numLives = 3
        self.gameOverLabel = gameOverLabel
        addChild(gameOverLabel)
    }
}
