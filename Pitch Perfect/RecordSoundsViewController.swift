//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Gregory Ray on 3/22/17.
//  Copyright © 2017 Udacity - Gregory Ray. All rights reserved.
//  References: Udacity "Pitch Perfect Course"

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!
    
    //IBOutlets for RecordSoundsViewController UI elements
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Stop recording button is disabled when the view loads.
        stopRecordingButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Debug test point
        print("viewWillAppear called")
        
    }
    
    //Dispose of any resources that can be recreated.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Recording button label change, disable recording button, enable stop recording button.
    @IBAction func recodAudio(_ sender: Any) {
        print("Record button was pressed")
        //Debug test point
        recordingLabel.text = "Recording in Progress"
        recordButton.isEnabled = false
        stopRecordingButton.isEnabled = true

        //File path directory, file name, URL file path, and session constants
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        let session = AVAudioSession.sharedInstance()
    
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)

        //Attempts to record audio using AVAudioRecorder delegate protocol
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
            audioRecorder.delegate = self
            audioRecorder.isMeteringEnabled = true
            audioRecorder.prepareToRecord()
            audioRecorder.record()
        
        
    }
    
    //Stop recording button is enabling record button, disabling stop record button, declaring
    // audioSession, and deactivating the audioSession.
    @IBAction func stopRecording(_ sender: Any) {
        print("Stop record button pressed")
        //Debug test point
        recordingLabel.text = "Tap to Record"
        recordButton.isEnabled = true
        stopRecordingButton.isEnabled = false
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("audioRecorderDidFinishRecording called")
            if flag {
                performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
                //Debug test point if the audio was successfully recorded.
                print("Recording Successful")
                
                
            } else {
                //Debug test point if the audio recording failed
                print("Recording Failed")
                
            }
    }
    
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("override func prepare for seque called")
        if segue.identifier == "stopRecording" {
            let playSoundVC = segue.destination as! PlaySoundViewController
            let recordedAudioURL = sender as! URL
            playSoundVC.recordedAudioURL = recordedAudioURL
        }
    }
}

