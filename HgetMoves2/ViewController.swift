//
//  ViewController.swift
//  HgetMoves2
//
//  Created by Hector on 5/20/19.
//  Copyright © 2019 hcarrasco. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }

    @IBAction func updateButton(_ sender: Any) {
        print ("actualizacion de data des...");
        
        let ws = WebserviceHandler()
        ws.getChessdotcomStats()
        ws.getChessdotcomPendingGames()
        
    }
    
    @IBAction func gotoChess(_ sender: Any) {
        print ("chesscom");
        NSWorkspace.shared.open(NSURL(string: "http://www.chess.com/daily")! as URL)

    }
    
    @IBAction func gotoLichess(_ sender: Any) {
        print ("lichess");
        NSWorkspace.shared.open(NSURL(string: "http://www.lichess.org")! as URL)
    }
    
    
    
}
