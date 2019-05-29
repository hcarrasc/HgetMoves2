//
//  ViewController.swift
//  HgetMoves2
//
//  Created by Hector on 5/20/19.
//  Copyright © 2019 hcarrasco. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var pendingGamesLabel: NSTextField!
    @IBOutlet weak var dailyEloLabel: NSTextField!
    @IBOutlet weak var bulletEloLabel: NSTextField!
    @IBOutlet weak var blitzEloLabel: NSTextField!
    @IBOutlet weak var blitzRapidEloLabel: NSTextField!
    @IBOutlet weak var statisticsLabel: NSTextField!
    @IBOutlet weak var totalGamesLabel: NSTextField!
    @IBOutlet var baseView: NSView!
    
    var pendingGames: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSApp.setActivationPolicy(.accessory)
        let user = "hectorcarrasco"
        let jsonUrlPendingGamesString="https://api.chess.com/pub/player/"+user+"/games/to-move"
        guard let url = URL(string: jsonUrlPendingGamesString) else {return}
        URLSession.shared.dataTask(with: url){ (data, response, err) in
            
            guard let data = data else {return}
            
            do {
                
                let parsing  = try JSONDecoder().decode(ChessDataModel.ChessGames.self, from: data)
                self.pendingGames = parsing.games.count
                
                DispatchQueue.main.async { // Correct
                    self.pendingGamesLabel.stringValue = "Pending games:          \(self.pendingGames)"
                }
                
            } catch let jsonErr {
                print ("Error serializing ", jsonErr)
            }
            
        }.resume()
        
        
        
        let jsonUrlUserInfoString="https://api.chess.com/pub/player/"+user+"/stats"
        guard let url2 = URL(string: jsonUrlUserInfoString) else {return}
        URLSession.shared.dataTask(with: url2){ (data2, response2, err) in
            
            guard let data2 = data2 else {return}
            
            do {
                
                let parsing2  = try JSONDecoder().decode(ChessDataModel.Stats.self, from: data2)
                print (" ===> \(parsing2)")
                
                DispatchQueue.main.async { // Correct
                    self.dailyEloLabel.stringValue = " \(parsing2.chess_daily.last.rating)   [ \(parsing2.chess_daily.record.win) - \(parsing2.chess_daily.record.draw) - \(parsing2.chess_daily.record.loss) ]"
                    self.bulletEloLabel.stringValue = " \(parsing2.chess_bullet.last.rating)   [ \(parsing2.chess_bullet.record.win) - \(parsing2.chess_bullet.record.draw) - \(parsing2.chess_bullet.record.loss) ]"
                    self.blitzEloLabel.stringValue = " \(parsing2.chess_blitz.last.rating)   [ \(parsing2.chess_blitz.record.win) - \(parsing2.chess_blitz.record.draw) - \(parsing2.chess_blitz.record.loss) ]"
                    self.blitzRapidEloLabel.stringValue = " \(parsing2.chess_rapid.last.rating)   [ \(parsing2.chess_rapid.record.win) - \(parsing2.chess_rapid.record.draw) - \(parsing2.chess_rapid.record.loss) ]"
                    
                    let victories = parsing2.chess_daily.record.win + parsing2.chess_bullet.record.win + parsing2.chess_blitz.record.win + parsing2.chess_rapid.record.win
                    let draws = parsing2.chess_daily.record.draw + parsing2.chess_bullet.record.draw + parsing2.chess_blitz.record.draw + parsing2.chess_rapid.record.draw
                    let losses = parsing2.chess_daily.record.loss + parsing2.chess_bullet.record.loss + parsing2.chess_blitz.record.loss + parsing2.chess_rapid.record.loss
                    let totalPlayed = victories + draws + losses
                    
                    self.totalGamesLabel.stringValue = "\(totalPlayed)   [ \(victories) - \(draws) - \(losses) ]"
                    
                    let appDelegate = NSApp.delegate as! AppDelegate
                    appDelegate.statusItem.button?.title = "ELO: \(parsing2.chess_daily.last.rating)"
                }
                                
            } catch let jsonErr {
                print ("Error serializing ", jsonErr)
            }
            
            }.resume()
        
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }

    @IBAction func updateButton(_ sender: Any) {
        print ("actualizacion de data des...");
        
    }
    
    @IBAction func gotoChess(_ sender: Any) {
        print ("chesscom");
        NSWorkspace.shared.open(NSURL(string: "http://www.chess.com/daily")! as URL)

    }
    
    @IBAction func gotoLichess(_ sender: Any) {
        print ("lichess");
        NSWorkspace.shared.open(NSURL(string: "http://www.lichess.org")! as URL)
    }
    
    @IBAction func gotoChessResultButton(_ sender: Any) {
        print ("lichess");
        NSWorkspace.shared.open(NSURL(string: "http://www.chess-results.com/fed.aspx?lan=2&fed=CHI")! as URL)
    }
    
    @IBAction func gotoChess24Button(_ sender: Any) {
        NSWorkspace.shared.open(NSURL(string: "http://www.chess24.com/")! as URL)
    }
    
    @IBAction func gotoTournamentsButton(_ sender: Any) {
        NSWorkspace.shared.open(NSURL(string: "https://www.ajefech.cl/ENF/torneosENF.php")! as URL)
    }
    @IBAction func exitButton(_ sender: Any) {
        exit(0)
    }
    
}
