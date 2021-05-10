//
//  GameScene.swift
//  MyGame
//
//  Created by ITPathways on 5/7/21.
//

import Foundation
import SpriteKit
import GameplayKit

enum PaddleDirection {
    case still
    case left
    case right
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var ball: SKShapeNode?
    var paddle: SKShapeNode?
    var paddleDirection = PaddleDirection.still
    
    let gravityVector = CGVector(dx: 0, dy: 0)
    let gameGroup: UInt32 = 1
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .blue
        startGame()
    }
    
    func startGame() {
        createPhysics()
        createBall()
        createPaddle()
        createBarriers()
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard let paddle = self.paddle else { return }
        guard let view = self.view else { return }

        switch self.paddleDirection {
        case .still:
            break
        case .left:
            if paddle.position.x > paddle.frame.size.width/2 {
                paddle.position = CGPoint(x: paddle.position.x-3, y: paddle.position.y)
            }
            
        case .right:
            if paddle.position.x < view.frame.maxX-paddle.frame.size.width/2 {
                paddle.position = CGPoint(x: paddle.position.x+3, y: paddle.position.y)
            }
        }
    }
    
    func createPhysics() {
        self.physicsWorld.gravity = gravityVector
        self.physicsWorld.contactDelegate = self
    }
    
    func createBall() {
        guard let view = self.view else { return }
        
        let ball = SKShapeNode(circleOfRadius: 10)
        
        ball.position = CGPoint(x: view.frame.midX, y: 20)
        ball.fillColor = .white
        
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        ball.physicsBody?.velocity = CGVector(dx: -100, dy: 100)
        
        ball.physicsBody?.collisionBitMask = gameGroup
        ball.physicsBody?.contactTestBitMask = gameGroup
        
        ball.physicsBody?.friction = 0
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.allowsRotation = false
        ball.physicsBody?.angularDamping = 0
        ball.physicsBody?.restitution = 0.5
        
        self.ball = ball
        addChild(ball)
    }
    
    func makeSolidRectange(node: SKNode, size: CGSize) {
        node.physicsBody = SKPhysicsBody(rectangleOf: size)
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.isDynamic = false
        node.physicsBody?.collisionBitMask = 1
        node.physicsBody?.contactTestBitMask = 1
        node.physicsBody?.friction = 0
        node.physicsBody?.restitution = 0.5
    }
    
    func createPaddle() {
        guard let view = self.view else { return }
        
        let size = CGSize(width: 100, height: 5)
        let paddle = SKShapeNode(rectOf: size)
        paddle.position = CGPoint(x: view.frame.midX, y: size.height)
        paddle.fillColor = .darkGray
        paddle.physicsBody = SKPhysicsBody(rectangleOf: size)
        paddle.physicsBody?.isDynamic = false
        paddle.physicsBody?.friction = 0
        paddle.physicsBody?.restitution = 0.5
        paddle.physicsBody?.allowsRotation = false
        
        self.paddle = paddle
        addChild(paddle)
    }
    
    func createBarriers() {
        guard let view = self.view else { return }
        
        let size = CGSize(width: 1, height: view.frame.size.height)
        let leftBarrier = SKShapeNode(rectOf: size)
        leftBarrier.position = CGPoint(x: 0, y: view.frame.midY)
        leftBarrier.strokeColor = .blue
        
        makeSolidRectange(node: leftBarrier, size: size)
        addChild(leftBarrier)
        
        let rightBarrier = SKShapeNode(rectOf: size)
        rightBarrier.position = CGPoint(x: view.frame.size.width, y: view.frame.midY)
        rightBarrier.strokeColor = .blue
        
        makeSolidRectange(node: rightBarrier, size: size)
        addChild(rightBarrier)
        
        let horizontalSize = CGSize(width: view.frame.size.width, height: 1)
        let topBarrier = SKShapeNode(rectOf: horizontalSize)
        topBarrier.position = CGPoint(x: view.frame.midX, y: view.frame.maxY)
        topBarrier.strokeColor = .blue
        
        makeSolidRectange(node: topBarrier, size: horizontalSize)
        addChild(topBarrier)
        
        let bottomBarrier = SKShapeNode(rectOf: horizontalSize)
        bottomBarrier.position = CGPoint(x: view.frame.midX, y: view.frame.minY)
        bottomBarrier.strokeColor = .white
        
        makeSolidRectange(node: bottomBarrier, size: horizontalSize)
        addChild(bottomBarrier)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let view = self.view, let position = touches.first?.location(in: view) else { return }
        
        if position.x<view.frame.midX {
            self.paddleDirection = .left
        }
        else {
            self.paddleDirection = .right
        }
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.paddleDirection = .still
    }
}
