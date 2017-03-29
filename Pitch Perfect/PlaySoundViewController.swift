//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by Gregory Ray on 3/24/17.
//  Copyright © 2017 Udacity - Gregory Ray. All rights reserved.
//  References: Udacity "Pitch Perfect Course"

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {

    //IBOutlets to PlaySoundViewController buttons
    //Button Images(name: image appearance) slowButton: "snail", fastButton: "rabbit"
    //highPitchButton: "squirell", lowPitchButton: "vader", echoButton: "echo",
    //reverbButton: "reverb", stopButton: "stop"
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var highPitchButton: UIButton!
    @IBOutlet weak var lowPitchButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!

    //AVFoundation, Audio Systems API variables
    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    //Enumerates button type by the View Tag entered on corresponding storyboard button
    enum ButtonType: Int {
        case slow = 0, fast = 1, highpitch = 2, lowpitch = 3, echo = 4, reverb = 5
        
    }
    
    //Playback desired sound base on which button is pressed then configures UI as playing audio
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .highpitch:
            playSound(pitch: 1000)
        case .lowpitch:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    //Debugging test point
    //Audio playback is stoped when the stop button is pressed
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        print("Stop Audio button pressed")
        
        stopAudio()
    }
    
    //Setup Audio on the view
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }

    override func viewWillAppear(_ animated: Bool) {
        configureUI(.notPlaying)
    }
    
    // Dispose of any resources that can be recreated.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    
}
    // MARK: - Navigation



