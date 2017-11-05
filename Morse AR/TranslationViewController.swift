//
//  TranslationViewController.swift
//  Morse AR
//
//  Created by Nate Thompson on 11/4/17.
//  Copyright © 2017 Nate Thompson. All rights reserved.
//

import UIKit

class TranslationViewController: UIViewController {
    
    @IBOutlet weak var translationView: UIView!
    @IBOutlet weak var textView: UITextView!
    
    var clearImageView: (() -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setTranslationText(text: String) {
        textView.text = text
    }

    @IBAction func textViewDoneButtonPressed(_ sender: Any) {
        performDismissalAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        preflightPresentationAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        performPresentationAnimation()
    }
    
    func preflightPresentationAnimation() {
        translationView.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
    }
    
    func performPresentationAnimation() {
        UIView.animate(
            withDuration: 0.6,
            delay: 0,
            usingSpringWithDamping: 0.87,
            initialSpringVelocity: 0,
            options: [],
            animations: {
                self.translationView.transform = .identity
        },
            completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.clearImageView()
        performDismissalAnimation()
    }
    
    func performDismissalAnimation() {
        UIView.animate(
            withDuration: 0.6,
            delay: 0,
            usingSpringWithDamping: 0.87,
            initialSpringVelocity: 0,
            options: [],
            animations: {
                self.translationView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        },
            completion: { _ in
                self.dismiss(animated: false, completion: nil)
        })
    }
}
