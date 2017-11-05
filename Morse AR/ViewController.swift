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
    let translationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TranslationViewController") as! TranslationViewController
    
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.showsStatistics = false
        
        imageView.isHidden = true
        translationViewController.clearImageView = {
            self.imageView.isHidden = true
        }
        
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
        let context = CIContext()
        let cgImage = context.createCGImage(ciImage, from: ciImage.extent)
        guard let cgImage2 = cgImage else { return }
        let uiImage = UIImage(cgImage: cgImage2)
        
        //openCVWrapper.processImage(uiImage)
        
        let morse = [MorseChar(elements: "-.-."), MorseChar(elements: "---"), MorseChar(elements: "-.."), MorseChar(elements: ".")]
        let translation = morse.translate()
        
        imageView.image = uiImage
        imageView.isHidden = false
        
        translationViewController.modalPresentationStyle = .overCurrentContext
        self.present(translationViewController, animated: false, completion: nil)
        translationViewController.setTranslationText(text: translation)

    }
}



extension CGImage {
    func rotate() -> CGImage {
        let rotatedSize = CGSize(width: self.height, height: self.width)
        // Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap = UIGraphicsGetCurrentContext()!
        
        // Move the origin to the middle of the image so we will rotate and scale around the center.
        bitmap.translateBy(x: rotatedSize.width / 2.0, y: rotatedSize.height / 2.0)
        
        //   // Rotate the image context
        bitmap.rotate(by: CGFloat.pi / 2)
        
        // Now, draw the rotated/scaled image into the context
        bitmap.scaleBy(x: 1.0, y: -1.0)
        bitmap.draw(self, in: CGRect(x: -width / 2, y: -height / 2, width: width, height: height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}





