//
//  GameScene.swift
//  MyGame
//
//  Created by ITPathways on 5/7/21.
//

import Foundation
import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var ball: SKShapeNode?
    var paddle: SKShapeNode?
    
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
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 50)
        
        ball.physicsBody?.collisionBitMask = gameGroup
        ball.physicsBody?.contactTestBitMask = gameGroup
        
        ball.physicsBody?.friction = 0
        ball.physicsBody?.linearDamping = 0
        
        self.ball = ball
        addChild(ball)
    }
    
    func makeSolidRectange(node: SKNode, size: CGSize) {
        node.physicsBody = SKPhysicsBody(rectangleOf: size)
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.isDynamic = false
        node.physicsBody?.collisionBitMask = 1
        node.physicsBody?.contactTestBitMask = 1
    }
    
    func createPaddle() {
        guard let view = self.view else { return }
        
        let size = CGSize(width: 100, height: 5)
        let paddle = SKShapeNode(rectOf: size)
        paddle.position = CGPoint(x: view.frame.midX, y: size.height/2)
        paddle.fillColor = .darkGray
        paddle.physicsBody = SKPhysicsBody(rectangleOf: size)
        
        self.paddle = paddle
        addChild(paddle)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let view = self.view, let position = touches.first?.location(in: view) else { return }
        
        if position.x<view.frame.midX {
            self.paddle?.physicsBody?.velocity = CGVector(dx: -10, dy: 0)
        }
        else {
            self.paddle?.physicsBody?.velocity = CGVector(dx: 10, dy: 0)
        }
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.paddle?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
    }
}
