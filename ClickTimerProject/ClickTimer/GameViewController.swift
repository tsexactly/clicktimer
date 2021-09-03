//
//  ViewController.swift
//  ClickTimer
//
//  Created by Tim Strobl on 07.04.20.
//  Copyright © 2020 Tim Strobl. All rights reserved.
//

import UIKit
import Foundation

class GameViewController: UIViewController {
    
    @IBOutlet weak var banner: UILabel!
    
    @IBOutlet weak var fixedlabel: UILabel!
    
    @IBOutlet weak var scorelabel: UILabel!
    
    @IBOutlet weak var colorview: UIView!
    
    @IBOutlet weak var retrybutton: UIButton!
    
    //    @IBAction func retrybutton(_ sender: UIButton) {
    //        dismiss(animated: false, completion: nil)
    //    }
    
    @IBOutlet weak var cheatlabel: UILabel!
    
    var oldscore: Double = 1.0
    
    var reactiontimer = Timer()
    var reactiontime = 0.000
    var colorchanged = false
    var cheated = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        colorview.backgroundColor = .systemRed
        colorview.layer.cornerRadius = 5.0
        colorview.layer.masksToBounds = false
        retrybutton.layer.cornerRadius = 5.0
        
        let randomTime = (arc4random() % 10) + 1
        
        reactiontimer = Timer.scheduledTimer(timeInterval: TimeInterval(randomTime), target: self, selector: #selector(switchGreen), userInfo: nil, repeats: false)
        
        colorview.isUserInteractionEnabled = true
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewtapped))
        
        colorview.addGestureRecognizer(tapRecognizer)
        
    }
    
    
    @objc func switchGreen() {
        
        if !cheated {
            
            colorview.backgroundColor = .systemGreen
            
            colorchanged = true
            
            reactiontimer = Timer.scheduledTimer(timeInterval: 0.001, target: self , selector: #selector(scorer), userInfo: nil , repeats: true)
            
        }
        
    }
    
    @objc func scorer() { reactiontime += 0.001 }
    
    
    @objc func viewtapped(sender: UIView) {
        
        if colorchanged {
            
            if reactiontimer.isValid {
                reactiontimer.invalidate()
            }
            
            fixedlabel.isHidden = false
            scorelabel.text = String(format: "Reaktionszeit: %.3fs", reactiontime)
            scorelabel.isHidden = false
        }
        
        else {
            
            cheated = true
            cheatlabel.isHidden = false
            reactiontime = 1.000
        }
        retrybutton.isHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "backtomenu" {
            
            if reactiontime < oldscore {
                UserDefaults.standard.setValue(reactiontime, forKey: "highscore")
            }
            
        }
        
    }
    
    
}

