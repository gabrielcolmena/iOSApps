//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Gabriel Colmenares on 6/19/17.
//  Copyright © 2017 Gabriel Colmenares. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {

    
    enum Operation: String{
        case Divide = "/"
        case Multiply = "*"
        case Substract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    var btnSound: AVAudioPlayer!
    var runningNumber = ""
    var currentOperation = Operation.Empty
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    @IBOutlet var outputLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "belly", ofType: "mp3")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
        outputLabel.text = "0"
    }
    @IBAction func numberPress(sender: UIButton){
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLabel.text = runningNumber
    }
    func playSound(){
        if btnSound.isPlaying{
            btnSound.stop()
        }else{
        btnSound.play()
        }
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOparetion(operation: .Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOparetion(operation: .Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOparetion(operation: .Substract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOparetion(operation: .Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOparetion(operation: currentOperation)
    }
    
    func processOparetion(operation: Operation){
        playSound()
        if currentOperation != Operation.Empty {
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Substract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLabel.text = result
            }
            
            currentOperation = operation
        } else {
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
    
}

