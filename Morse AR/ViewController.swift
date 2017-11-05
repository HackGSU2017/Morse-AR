//
//  ViewController.swift
//  Morse AR
//
//  Created by Nate Thompson on 11/4/17.
//  Copyright © 2017 Nate Thompson. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    let openCVWrapper = OpenCVWrapper()

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene/Users/Nate/GitHub/Morse AR/Morse AR/Morse AR-Bridging-Header.h
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        
        
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }

    @IBAction func translateButtonPressed(_ sender: Any) {
        
        guard let pixelBuffer = sceneView.session.currentFrame?.capturedImage else { return }
        
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        let uiImage = UIImage(ciImage: ciImage)
        
        //openCVWrapper.processImage(uiImage)
        
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TranslationViewController") as! TranslationViewController
        viewController.modalPresentationStyle = .overCurrentContext
        self.present(viewController, animated: false, completion: nil)
        viewController.setTranslationText(text: "test translation text")
        
        

    }
    

    
}


