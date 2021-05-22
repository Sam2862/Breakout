//
//  BreakoutConstants.swift
//  Breakout
//
//  Created by ITPathways on 5/21/21.
//
// Imports the necessary functions.
import Foundation
import SpriteKit

// Creates a class for the constants.
class BreakoutConstants {
    // Creates constants for the width of the screen and the safe area insets.
    let defaultWidth: CGFloat = 320
    var actualWidth: CGFloat = 320
    var safeAreaInsets = UIEdgeInsets.zero
    // Creates a constant for the ratio of the width of the screen using the width of an iPod screen for reference.
    var designRatio: CGFloat {
        return actualWidth/defaultWidth
    }
    // Changes the size, position, and speed of different object depends on the size of the screen.
    var ballY: CGFloat {
        return designRatio*40
    }
    var ballXGap: CGFloat {
        return designRatio*20
    }
    var paddleSize: CGSize {
        return CGSize(width: designRatio*100, height: designRatio*5)
    }
    var paddleY: CGFloat {
        return paddleSize.height+safeAreaInsets.bottom
    }
    var brickWidth: CGFloat {
       return designRatio*40
    }
    var brickHeight: CGFloat {
        return designRatio*20
    }
    var ballRadius: CGFloat {
        return designRatio*10
    }
    var labelSize: CGFloat {
        return designRatio*20
    }
    var labelPosition: CGFloat {
        return (designRatio*70)
    }
    var textDisplayHeight: CGFloat {
        return (designRatio*20)+safeAreaInsets.top
    }
    var ballSpeed: CGFloat {
        return designRatio*140
    }
    var ballVelocityY1: CGFloat {
        return designRatio*20
    }
    var ballVelocityY2: CGFloat {
        return designRatio*90
    }
    var paddleSpeed: CGFloat {
        return designRatio*4
    }
    
}
