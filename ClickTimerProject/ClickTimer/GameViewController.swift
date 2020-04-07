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
    
    @IBOutlet weak var colorview: UIView!
    
    @IBOutlet weak var retrybutton: UIButton!
    
    @IBAction func retrybutton(_ sender: UIButton) {
        self.viewDidLoad()
    }
    
    @IBOutlet weak var cheatlabel: UILabel!
    
    @IBAction func mainmenu(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }

    var reactiontimer = Timer()
    var reactiontime = 0.000
    var colorchanged = false
    var cheated = false
    
    override func viewDidLoad() {
    
        colorview.backgroundColor = .systemRed
        fixedlabel.isHidden = true
        cheatlabel.isHidden = true
        retrybutton.isHidden = true
        
        
        
        super.viewDidLoad()
        
        let randomTime = (arc4random() % 10) + 1
        
        reactiontimer = Timer.scheduledTimer(timeInterval: TimeInterval(randomTime), target: self, selector: #selector(checkviewtapped), userInfo: nil, repeats: false)
        
    }
    
    
    @objc func checkviewtapped() {
        
        if !cheated {
            
            colorview.backgroundColor = .systemGreen
            
            colorchanged = true
            
            reactiontimer = Timer.scheduledTimer(timeInterval: 0.001, target: self , selector: #selector(scorer), userInfo: nil , repeats: true)
            
            colorview.isUserInteractionEnabled = true
            
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewtapped))
            
            colorview.addGestureRecognizer(tapRecognizer)
           
        }
 
    }
    
    @objc func scorer() { reactiontime += 0.001 }
    
    
    @objc func viewtapped(sender: UIView) {
        
        if !colorchanged {
                   
                   if reactiontimer.isValid {
                       reactiontimer.invalidate()
                   }
             
            
            cheatlabel.text = String(format: "Reaktionszeit: %.3f", reactiontime)

            
        } else {
            
            cheatlabel.isHidden = false
                  cheated = true
                  
                  retrybutton.isHidden = false
                  
            
        }
    }


}

