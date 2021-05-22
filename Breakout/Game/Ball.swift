//
//  Ball.swift
//  Breakout
//
//  Created by ITPathways on 5/19/21.
//
// Imports the necessary functions.
import Foundation
import SpriteKit
import GameplayKit

// Creates a class for the ball.
class Ball: SKShapeNode {
    // Creates variables for the ball and for the constants.
    let constants: BreakoutConstants
    var ball: SKShapeNode?
    let gameGroup: UInt32 = 1
    // Sets the size, color, and physics properties of the ball.
    init(_ view: SKView, _ i: Int, _ constants: BreakoutConstants) {
        self.constants = constants
        super.init()
        let ball = SKShapeNode(circleOfRadius: constants.ballRadius)
        self.ball = ball
        ball.fillColor = .white
        
        let speed: CGFloat = constants.ballSpeed
        let yVelocity = CGFloat(GKARC4RandomSource.sharedRandom().nextInt(upperBound: Int(constants.ballVelocityY1)))+constants.ballVelocityY2
        let xVelocity: CGFloat
        if GKARC4RandomSource.sharedRandom().nextBool() {
            xVelocity = sqrt(speed*speed-yVelocity*yVelocity) * -1
        }
        else {
            xVelocity = sqrt(speed*speed-yVelocity*yVelocity)
        }
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: constants.ballRadius)
        self.physicsBody?.velocity = CGVector(dx: xVelocity, dy: yVelocity)
        self.physicsBody?.collisionBitMask = gameGroup
        self.physicsBody?.contactTestBitMask = gameGroup
        self.physicsBody?.friction = 0
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.angularDamping = 0
        self.physicsBody?.restitution = 1
        
        self.addChild(ball)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// Adjusts the angle of the ball if it hits the paddle at a bad angle.
    func adjustAngle() {
        guard let physicsBody = self.physicsBody else { return }
        var angle = VectorMath.degrees(vector: physicsBody.velocity)
        if angle>160.0 {
            angle = 150.0
        } else if angle<20.0 {
            angle = 30.0
        } else {
            return
        }
        let newVelocity = VectorMath.make(angleDegrees: angle, speed: VectorMath.length(vector: physicsBody.velocity))
        physicsBody.velocity = newVelocity
        print(angle)
    }
}
