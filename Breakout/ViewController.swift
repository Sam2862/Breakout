//
//  ViewController.swift
//  Breakout
//
//  Created by Samuel K on 5/6/21.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

    var scene: BreakoutScene?

    override func loadView() {
        super.loadView()
        self.view = SKView()
        self.view.bounds = UIScreen.main.bounds
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupScene()
    }

    func setupScene() {
        if let view = self.view as? SKView, scene == nil {
            let scene = BreakoutScene(size: view.bounds.size)
            view.presentScene(scene)
            self.scene = scene
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }


}

