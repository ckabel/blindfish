//
//  ViewController.swift
//  Blindfisch
//
//  Created by Christian Kabelin on 26.08.16.
//  Copyright © 2016 Christian Kabelin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var appDelegate: AppDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var btnSpeak: UIButton!
    
    @IBAction func touchDown(_ sender: AnyObject) {
        self.startRecording()
    }
    
    @IBAction func touchUpInside(_ sender: AnyObject) {
        self.stopRecording()
    }
    
    @IBAction func touchUpOutside(_ sender: AnyObject) {
        self.stopRecording()
    }
    
    func startRecording() {
        //self.speak(msg: "Spreche jetzt")
        self.appDelegate.speechW.startRecording()
    }
    
    func stopRecording() {
       self.appDelegate.speechW.stopRecording()
    }
    
    func speak(msg: String) {
        self.appDelegate.speechW.speak(msg: msg)
    }


}

