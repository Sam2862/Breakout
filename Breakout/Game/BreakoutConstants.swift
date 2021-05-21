//
//  BreakoutConstants.swift
//  Breakout
//
//  Created by ITPathways on 5/21/21.
//

import Foundation
import SpriteKit

class BreakoutConstants {
    let defaultWidth: CGFloat = 320
    var actualWidth: CGFloat = 320
    var designRatio: CGFloat {
        return actualWidth/defaultWidth
    }
    var ballY: CGFloat {
        return designRatio*40
    }
    var ballXGap: CGFloat {
        return designRatio*20
    }
    var paddleSize: CGSize {
        return CGSize(width: designRatio*100, height: designRatio*5)
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
}