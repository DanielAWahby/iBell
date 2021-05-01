//
//  ViewController.swift
//  iBell
//
//  Created by Daniel Wahby on 30/03/2021.
//

import UIKit
import Gifu
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var imageView: GIFImageView!
    @IBOutlet weak var shakeLabel: UILabel!
    var soundEffect = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.prepareForAnimation(withGIFNamed: "Bell"){
            print("GIF is ready")        }
        soundEffect.delegate = self
        self.becomeFirstResponder()
    }
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            self.toggleAnimation()
        }
    }
    func toggleAnimation() {
        do {
            let path = Bundle.main.path(forResource: "Bell.mp3", ofType:nil)!
            let url = URL(fileURLWithPath: path)
            imageView.animationDuration = 2
            soundEffect = try AVAudioPlayer(contentsOf: url)
            soundEffect.play()
            imageView.startAnimatingGIF()
            self.resignFirstResponder()
        } catch {
          print("Could not play sound !!")
        }
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool){
        print("Finished Playing")
        imageView.stopAnimating()
        imageView.stopAnimatingGIF()
    }
    

}

