//
//  SpeechWrapper.swift
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

public class SpeechWrapper {

    let speechRecorder = SpeechRecorder()
    
    func authorizeSpeech () {
        speechRecorder.authorizeSpeech()
    }
    
    func speak(msg: String) {
        let utterance = AVSpeechUtterance(string: msg)
        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
    }
    
    func startRecording() {
        self.speechRecorder.startRecording()
    }
    
    func stopRecording() {
        self.speechRecorder.stopRecording()
    }
}


