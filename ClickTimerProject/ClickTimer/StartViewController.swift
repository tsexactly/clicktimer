//
//  StartViewController.swift
//  ClickTimer
//
//  Created by Tim Strobl on 07.04.20.
//  Copyright © 2020 Tim Strobl. All rights reserved.
//

import UIKit
import Foundation

class StartViewController: UIViewController {
    
    @IBOutlet weak var fixedlabel: UILabel!
    
    @IBOutlet weak var highscorelabel: UILabel!
    
    @IBOutlet weak var startbutton: UIButton!
    
    var highscore: Double = 1.0
    
    override func viewDidLoad() {
        
        highscorelabel.text = String(format: "%.3fs", highscore)

        super.viewDidLoad()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotogame" {
            
            if let gameview = segue.destination as? GameViewController {
            
                gameview.oldscore = highscore
                
                } else { return }

        }
    }
    
    
    
    
}
