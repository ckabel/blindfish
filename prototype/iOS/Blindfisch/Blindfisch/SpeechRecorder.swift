//
//  SpeechRecorder.swift
//  Blindfisch
//
//  Created by Christian Kabelin on 26.08.16.
//  Copyright © 2016 Christian Kabelin. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Speech
import AVKit


public class SpeechRecorder : NSObject {
    
    var locale = "de-DE"
    var speechRecognizer: SFSpeechRecognizer?
    
    let audioEngine = AVAudioEngine()
    
    let request = SFSpeechAudioBufferRecognitionRequest()
    
    var isAuthorized: Bool?
    var isDenied: Bool?
    var isRestricted: Bool?
    var isNotDetermined: Bool?
    
    var speechRecognitionTask: SFSpeechRecognitionTask?
    
    func initSpeech() {
        self.speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: self.locale))
    }
    
    func initSpeech(loc: String) {
        self.locale = loc
        self.speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: self.locale))
    }
    
    func authorizeSpeech () {
        isAuthorized = false
        isDenied = false
        isRestricted = false
        isNotDetermined = false
        
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    self.isAuthorized = true
                    break
                case .denied:
                    self.isDenied = true
                    break
                case .restricted:
                    self.isRestricted = true
                    break
                case .notDetermined:
                    self.isNotDetermined = true
                    break
                }
            }
        }
    }
    
    func startRecording() {
        /*
        let node = audioEngine.inputNode!
        let format = node.outputFormat(forBus: 0)
        
        //, block: <#T##AVAudioNodeTapBlock##AVAudioNodeTapBlock##(AVAudioPCMBuffer, AVAudioTime) -> Void#>)
        
        node.installTap(onBus: 0, bufferSize: 1024, format: format) {
            (buffer, _) in self.request
        }
 
        */
        audioEngine.prepare()
        
        try! audioEngine.start()
        
        self.speechRecognitionTask = speechRecognizer?.recognitionTask(with: self.request) {
            result, error in
            guard error == nil else { print("Error: \(error)"); return }
            guard let result = result else { print("No result!"); return }
            
            print(result.bestTranscription.formattedString)
        }
        
    }
    
    func stopRecording() {
        self.audioEngine.stop()
        self.request.endAudio()
    }
    
    func cancelRecording() {
        self.audioEngine.stop()
        self.speechRecognitionTask?.cancel()
    }
    
}
