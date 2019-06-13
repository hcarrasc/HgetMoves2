//
//  ViewController.swift
//  HgetMoves2
//
//  Created by Hector on 5/20/19.
//  Copyright © 2019 hcarrasco. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NetworkDelegate {
    
    // MARK : properties
    
    @IBOutlet weak var pendingGamesLabel: NSTextField!
    @IBOutlet weak var dailyEloLabel: NSTextField!
    @IBOutlet weak var bulletEloLabel: NSTextField!
    @IBOutlet weak var blitzEloLabel: NSTextField!
    @IBOutlet weak var blitzRapidEloLabel: NSTextField!
    @IBOutlet weak var statisticsLabel: NSTextField!
    @IBOutlet weak var totalGamesLabel: NSTextField!
    var pendingGames: Int = 0
    var lastRating:   Int = 0
    var appDelegate = NSApp.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webserviceHandler = WebserviceHandler()
        webserviceHandler.delegate = self
        webserviceHandler.getChessdotcomPendingGames()
        webserviceHandler.getStatisticData()
        
    }

    @IBAction func updateButton(_ sender: Any) {
        print ("actualizacion de data des...");
        let webserviceHandler = WebserviceHandler()
        webserviceHandler.delegate = self
        webserviceHandler.getStatisticData()
    }
    
    @IBAction func gotoChess(_ sender: Any) {
        NSWorkspace.shared.open(NSURL(string: "http://www.chess.com/daily")! as URL)
    }
    
    @IBAction func gotoLichess(_ sender: Any) {
        NSWorkspace.shared.open(NSURL(string: "http://www.lichess.org")! as URL)
    }
    
    @IBAction func gotoChessResultButton(_ sender: Any) {
        NSWorkspace.shared.open(NSURL(string: "http://www.chess-results.com/fed.aspx?lan=2&fed=CHI")! as URL)
    }
    
    @IBAction func gotoChess24Button(_ sender: Any) {
        NSWorkspace.shared.open(NSURL(string: "http://www.chess24.com/")! as URL)
    }
    
    @IBAction func gotoTournamentsButton(_ sender: Any) {
        NSWorkspace.shared.open(NSURL(string: "https://www.ajefech.cl/ENF/torneosENF.php")! as URL)
    }
    
    @IBAction func gotoGithubButton(_ sender: Any) {
        NSWorkspace.shared.open(NSURL(string: "https://github.com/hcarrasc/HgetMoves2")! as URL)
    }
    
    @IBAction func exitButton(_ sender: Any) {
        exit(0)
    }
    
    // MARK : NetworkDelegates
    
    func didFinishgetPendingGames(result: Data) {
        do {
            let parsingPendingGames  = try JSONDecoder().decode(ChessDataModel.ChessGames.self, from: result)
            self.pendingGames = parsingPendingGames.games.count
            
            DispatchQueue.main.async { // Correct
                self.pendingGamesLabel.stringValue = "Pending games:          \(self.pendingGames)"
            }
            
        } catch let jsonErr {
            print ("Error serializing ", jsonErr)
        }
    }
    
    func didFinishgetStatistic(result: Data) {
        
        do {
            let parsingModel  = try JSONDecoder().decode(ChessDataModel.Stats.self, from: result)
            print (" ===> \(parsingModel)")
            
            DispatchQueue.main.async { // Correct
                self.dailyEloLabel.stringValue = " \(parsingModel.chess_daily.last.rating)   [ \(parsingModel.chess_daily.record.win) - \(parsingModel.chess_daily.record.draw) - \(parsingModel.chess_daily.record.loss) ]"
                self.bulletEloLabel.stringValue = " \(parsingModel.chess_bullet.last.rating)   [ \(parsingModel.chess_bullet.record.win) - \(parsingModel.chess_bullet.record.draw) - \(parsingModel.chess_bullet.record.loss) ]"
                self.blitzEloLabel.stringValue = " \(parsingModel.chess_blitz.last.rating)   [ \(parsingModel.chess_blitz.record.win) - \(parsingModel.chess_blitz.record.draw) - \(parsingModel.chess_blitz.record.loss) ]"
                self.blitzRapidEloLabel.stringValue = " \(parsingModel.chess_rapid.last.rating)   [ \(parsingModel.chess_rapid.record.win) - \(parsingModel.chess_rapid.record.draw) - \(parsingModel.chess_rapid.record.loss) ]"
                
                //Getting statistics
                let victories = parsingModel.chess_daily.record.win + parsingModel.chess_bullet.record.win + parsingModel.chess_blitz.record.win + parsingModel.chess_rapid.record.win
                let draws = parsingModel.chess_daily.record.draw + parsingModel.chess_bullet.record.draw + parsingModel.chess_blitz.record.draw + parsingModel.chess_rapid.record.draw
                let losses = parsingModel.chess_daily.record.loss + parsingModel.chess_bullet.record.loss + parsingModel.chess_blitz.record.loss + parsingModel.chess_rapid.record.loss
                let totalPlayed = victories + draws + losses
                self.totalGamesLabel.stringValue = "\(totalPlayed)   [ \(victories) - \(draws) - \(losses) ]"
                self.statisticsLabel.stringValue = ""
                
                //Updating menu bar ELO
                let rating = UserDefaults.standard.value(forKey: "rating") as! Int
                
                if rating > parsingModel.chess_daily.last.rating {
                    self.appDelegate.statusItem.button?.title = "♘: ▽\(parsingModel.chess_daily.last.rating)"
                    UserDefaults.standard.setValue(parsingModel.chess_daily.last.rating, forKey: "rating") 
                } else if rating < parsingModel.chess_daily.last.rating {
                    self.appDelegate.statusItem.button?.title = "♘: △\(parsingModel.chess_daily.last.rating)"
                    UserDefaults.standard.setValue(parsingModel.chess_daily.last.rating, forKey: "rating")
                } else {
                    self.appDelegate.statusItem.button?.title = "♘: =\(parsingModel.chess_daily.last.rating)"
                    UserDefaults.standard.setValue(parsingModel.chess_daily.last.rating, forKey: "rating")
                }
                
                self.lastRating = parsingModel.chess_daily.last.rating
                
            }
            
        } catch let jsonErr {
            print ("Error serializing ", jsonErr)
        }
    }
    
}
