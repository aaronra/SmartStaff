//
//  AudioRecorder.swift
//  SmartStaff
//
//  Created by RhoverF on 6/4/15.
//  Copyright (c) 2015 Cloudstaff. All rights reserved.
//

import UIKit
import AVFoundation

class AudioRecorder: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?

    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var stopButton: UIButton!
    
        
    @IBAction func recordAudio(sender: AnyObject) {
        
        if audioRecorder?.recording == false {
            recordButton.enabled = false
            playButton.enabled = false
            stopButton.enabled = true
            audioRecorder?.record()
        }
    }
    
    @IBAction func playAudio(sender: AnyObject) {
        if audioRecorder?.recording == false {
            stopButton.enabled = true
            recordButton.enabled = false
            var error: NSError?
            
            audioPlayer = AVAudioPlayer(contentsOfURL: audioRecorder?.url,
                error: &error)
            
            audioPlayer?.delegate = self
            
            if let err = error {
                println("audioPlayer error: \(err.localizedDescription)")
            } else {
                audioPlayer?.play()
            }
        }
    }
    
    
    @IBAction func stopAudio(sender: AnyObject) {
    
        stopButton.enabled = false
        playButton.enabled = true
        recordButton.enabled = true
    
        if audioRecorder?.recording == true {
            audioRecorder?.stop()
        } else {
            audioPlayer?.stop()
        }
    }
    
    
    @IBAction func Backtomain(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)

    }


    override func viewDidLoad() {
        
        super.viewDidLoad()
        playButton.enabled = false
        stopButton.enabled = false
        
        let dirPaths =
        NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)
        let docsDir = dirPaths[0] as! String
        let soundFilePath =
        docsDir.stringByAppendingPathComponent("sound.aac")
        let soundFileURL = NSURL(fileURLWithPath: soundFilePath)
        let recordSettings =
        [AVEncoderAudioQualityKey: AVAudioQuality.Min.rawValue,
            AVEncoderBitRateKey: 16,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey: 44100.0]
        
        var error: NSError?
        
        let audioSession = AVAudioSession.sharedInstance()
        audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord,
            error: &error)
        
        if let err = error {
            println("audioSession error: \(err.localizedDescription)")
        }
        
        audioRecorder = AVAudioRecorder(URL: soundFileURL,
            settings: recordSettings as [NSObject : AnyObject], error: &error)
        
        if let err = error {
            println("audioSession error: \(err.localizedDescription)")
        } else {
            audioRecorder?.prepareToRecord()
        }
        
    }
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        recordButton.enabled = true
        stopButton.enabled = false
    }
    
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer!, error: NSError!) {
        println("Audio Play Decode Error")
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
    }
    
    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder!, error: NSError!) {
        println("Audio Record Encode Error")
    }
}