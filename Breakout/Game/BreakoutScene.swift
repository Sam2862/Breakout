//
//  BreakoutScene.swift
//  Breakout
//
//  Created by Samuel K on 5/7/21.
//

// Imports the necessary modules.
import Foundation
import SpriteKit
import GameplayKit

// Creates a main class for the game.
class BreakoutScene: SKScene, SKPhysicsContactDelegate {
    
    // Creates properties for each important part of the game.
    var balls = [Ball]()
    var numLives = 3
    var paddle: Paddle?
    var bottomBarrier: Barrier?
    var bricks = [Brick]()
    var paddleDirection = PaddleDirection.still
    var gameOverLabel: SKLabelNode?
    var score: Int = 0
    var scoreLabel: SKLabelNode?
    var livesLabel: SKLabelNode?
    
    // Creates properties for important constants.
    let constants = BreakoutConstants()
    let gravityVector = CGVector(dx: 0, dy: 0)
    let gameGroup: UInt32 = 1
    
    /// Sets the background to blue and calls the startGame() function.
    override func didMove(to view: SKView) {
        self.backgroundColor = .blue
        self.constants.actualWidth = view.frame.width
        self.constants.safeAreaInsets = view.safeAreaInsets
        startGame()
    }
    
    /// Calls all the functions needed to start the game.
    func startGame() {
        self.scene?.removeAllChildren()
        createPhysics()
        createBalls()
        createPaddle()
        createBarriers()
        createBricks()
        createScore()
        createLives()
        // Removes the text that displays at the end of the game.
        gameOverLabel = nil
    }
    
    /// Sets the direction of the paddle, as well as the speed.
    override func update(_ currentTime: TimeInterval) {
        guard let paddle = self.paddle else { return }
        guard let view = self.view else { return }

        switch self.paddleDirection {
        case .still:
            break
        case .left:
            if paddle.position.x > paddle.width/2 {
                paddle.position = CGPoint(x: paddle.position.x-constants.paddleSpeed, y: paddle.position.y)
            }
            
        case .right:
            if paddle.position.x < view.frame.maxX-paddle.width/2 {
                paddle.position = CGPoint(x: paddle.position.x+constants.paddleSpeed, y: paddle.position.y)
            }
        }
    }
    
    /// Creates the rules for gravity and contact physics.
    func createPhysics() {
        self.physicsWorld.gravity = gravityVector
        self.physicsWorld.contactDelegate = self
    }
    
    /// Creates a ball and adds it to the balls array (look at the Ball class for more details).
    fileprivate func createABall(_ view: SKView, _ i: Int) {
        let ball = Ball(view, i, constants)
        
        ball.position = CGPoint(x: view.frame.midX+CGFloat(i)*constants.ballXGap, y: constants.ballY)
        
        self.balls.append(ball)
        addChild(ball)
    }
    
    /// This function can create multiple balls on the screen at the same time. It's currently set to only create one.
    func createBalls() {
        guard let view = self.view else { return }
        
        let numBalls = 1
        self.balls.removeAll()
        for i in 0..<numBalls {
            createABall(view, i)
        }
    }
    
    /// Creates the paddle (look at the Paddle class for more details).
    func createPaddle() {
        guard let view = self.view else { return }
        
        let paddle = Paddle(size: constants.paddleSize)
        paddle.position = CGPoint(x: view.frame.midX, y: constants.paddleY)
        
        self.paddle = paddle
        addChild(paddle)
    }
    
    /// Creates invisible barriers on all four sides of the screen.
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
        
        // The bottom barrier is a property because the player loses a life if the ball hits it.
        self.bottomBarrier = bottomBarrier
        addChild(bottomBarrier)
    }
    
    /// Creates the bricks at the top of the screen (look at the brick class for more details).
    func createBricks() {
        guard let view = self.view else { return }
        bricks = [Brick]()
        
        let brickSize = CGSize(width: constants.brickWidth, height: constants.brickHeight)
        // Makes sure that there are enough bricks to fit on the screen.
        let numBricks: Int = Int(view.frame.size.width/constants.brickWidth)
        // Creates the bricks in rows.
        for brickY in 0..<4 {
            for brickX in 0..<numBricks {
                let brick = Brick(size: brickSize)
                brick.position = CGPoint(x: view.frame.minX+constants.brickWidth/2+(constants.brickWidth*CGFloat(brickX)), y: (view.frame.maxY-constants.brickHeight-constants.textDisplayHeight)-(CGFloat(brickY)*constants.brickHeight))
                
                addChild(brick)
                bricks.append(brick)
            }
        }
    }
    
    /// Creates a label at the top of the screen that displays the score.
    func createScore() {
        guard let view = self.view else { return }
        
        score = 0
        let scoreLabel = SKLabelNode(text: "Score: \(score)")
        scoreLabel.fontSize = constants.labelSize
        scoreLabel.fontColor = .white
        scoreLabel.fontName = "Courier"
        scoreLabel.position = CGPoint(x: view.frame.maxX-constants.labelPosition, y: view.frame.maxY-constants.textDisplayHeight)
        
        self.scoreLabel = scoreLabel
        addChild(scoreLabel)
    }
    
    /// Creates a label at the top of the screen that displays the player's remaining lives.
    func createLives() {
        guard let view = self.view else { return }
        
        let livesLabel = SKLabelNode(text: "Lives: \(numLives)")
        livesLabel.fontSize = constants.labelSize
        livesLabel.fontColor = .white
        livesLabel.fontName = "Courier"
        livesLabel.position = CGPoint(x: constants.labelPosition, y: view.frame.maxY-constants.textDisplayHeight)
        
        self.livesLabel = livesLabel
        addChild(livesLabel)
    }
    
    /// Detects if the player is touching the screen.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Lets the player restart the game by tapping the screen.
        guard let view = self.view, let position = touches.first?.location(in: view) else { return }
        if gameOverLabel != nil {
            startGame()
        }
        // Changes the direction of the paddle depending on where the player touches the screen.
        else if position.x<view.frame.midX {
            self.paddleDirection = .left
        }
        else {
            self.paddleDirection = .right
        }
        
        
    }
    
    /// Detects if the player isn't touching the screen.
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Stops the paddle from moving if the player is not touching the screen.
        self.paddleDirection = .still
    }
    
    /// Checks to see if the ball hit any bricks.
    func checkBrickContact(_ contact: SKPhysicsContact) {
        var done = false
        for brick in bricks {
            if done {
                break
            }
            // Removes the bricks hit by the ball.
            for ball in self.balls {
                if (contact.bodyA == ball.physicsBody && contact.bodyB == brick.physicsBody) ||
                    (contact.bodyA == brick.physicsBody && contact.bodyB == ball.physicsBody){
                    brick.removeFromParent()
                    bricks.removeAll{$0 == brick}
//                    Changes the score.
                    score += 10
                    scoreLabel?.text = "Score: \(score)"
                    done = true
                    break
                }
            }
        }
    }
    
    /// Checks to see if the ball hit the bottom barrier.
    func didBegin(_ contact: SKPhysicsContact) {
        guard let bottomBarrier = self.bottomBarrier else { return }
        guard let view = self.view else { return }

        for ball in self.balls {
            if (contact.bodyA == ball.physicsBody && contact.bodyB == bottomBarrier.physicsBody) ||
                (contact.bodyA == bottomBarrier.physicsBody && contact.bodyB == ball.physicsBody){
                // Reduces the player's remaining lives by one.
                numLives -= 1
                livesLabel?.text = "Lives: \(numLives)"
                // Ends the game if the player has zero lives.
                if numLives == 0 {
                    endGame(text: "Game Over")
                    return
                }
                // Removes the old ball and creates a new one if the player still has lives left.
                else {
                    ball.removeFromParent()
                    balls.removeAll(where: {$0 == ball})
                    createABall(view, 0)
                    break
                }
            }
        }
        // Checks if the ball made contact with the paddle or the bricks, as well as if the win conditions were met.
        checkPaddleContact(contact)
        checkBrickContact(contact)
        checkForWin()
    }
    
    /// Displays a win message if there are no more bricks left.
    func checkForWin() {
        if bricks.isEmpty {
            endGame(text: "Congratulations! You Win!")
        }
    }
    
    /// Applys a force to the ball depending on where it hits the paddle.
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
                ball.adjustAngle()
            }
        }
    }
    
    /// Ends the game and resets the lives player's.
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
