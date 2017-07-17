//
//  ViewController.swift
//  Scribe
//
//  Created by Gabriel Colmenares on 7/16/17.
//  Copyright © 2017 Gabriel Colmenares. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate{

    @IBOutlet var textView: UITextView!
    @IBOutlet var recordButton: UIButton!
    @IBOutlet var stateLabel: UILabel!
    
    var audioPlayer: AVAudioPlayer!
    
    let audioEngine = AVAudioEngine()
    let speechRecognizer = SFSpeechRecognizer()!
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    
    var isRecording = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func startRecording() throws {

        let node = audioEngine.inputNode!
        let recordingFormat = node.outputFormat(forBus: 0)
        
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat){ (buffer, _) in
            self.request.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
        
        SFSpeechRecognizer.requestAuthorization{ authStatus in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized{
                self.speechRecognizer.accessibilityLanguage = "Spanish"
                self.recognitionTask = self.speechRecognizer.recognitionTask(with: self.request){(res, err) in
                    if let error = err{
                        print("There was an error: \(error)")
                    }else{
                        self.textView.text = res?.bestTranscription.formattedString
                    }
                }
            }
        }
        
    }
    
    func stopRecording(){
        audioEngine.stop()
        audioEngine.inputNode?.removeTap(onBus: 0)
        request.endAudio()
    }
    
    @IBAction func record(_ sender: UIButton) {
        if !isRecording{
            sender.setTitle("", for: .normal)
            isRecording = true
            self.stateLabel.text = "recording"
            
            do{
                try startRecording()
            }catch{
                print("Error recording!")
            
            }
        }else{
            sender.setTitle("", for: .normal)
            isRecording = false
            self.stateLabel.text = "tap and transcribe"
            stopRecording()
        }
    }

}

