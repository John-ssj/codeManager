//
//  ViewController.swift
//  ARLearn2
//
//  Created by apple on 2021/1/20.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    var scnView = ARSCNView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scnView.frame = view.frame
        view.addSubview(scnView)
        scnView.delegate = self
        
        let scene = SCNScene(named: "")!
        scnView.scene = scene
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        let configuration = ARWorldTrackingConfiguration()
        
        scnView.session.run(configuration, options: .resetSceneReconstruction)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        scnView.session.pause()
    }

}

