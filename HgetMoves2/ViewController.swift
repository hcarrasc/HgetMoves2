//
//  ViewController.swift
//  HgetMoves2
//
//  Created by Hector on 5/20/19.
//  Copyright © 2019 hcarrasco. All rights reserved.
//

import Cocoa

struct ChessGames: Decodable{
    let games : [Games]
}

struct Games: Decodable {
    let url: String
    let move_by : Int32
    let last_activity : Int32
}

struct Stats: Decodable {
    let chess_daily: ChessDaily
    let chess960_daily: Chess960Daily
    let chess_rapid: ChessRapid
    let chess_bullet: ChessBullet
    let chess_blitz: ChessBlitz
    let tactics: Tactics
    let lessons: Lessons
}

struct ChessDaily : Decodable {
    var last: Last
    var best: Best
    var record: Record
    var tournament: Tournament
}
struct Chess960Daily : Decodable{
    var last: Last
    var best: Best
    var record: Record
    var tournament: Tournament
}
struct ChessRapid : Decodable{
    var last: Last
    var best: Best
    var record: Record
}
struct ChessBullet : Decodable{
    var last: Last
    var best: Best
    var record: Record
}
struct ChessBlitz : Decodable{
    var last: Last
    var best: Best
    var record: Record
}
struct Tactics : Decodable{
    var highest : Highest
    var lowest : Lowest
}
struct Lessons : Decodable{
    var highest : Highest
    var lowest : Lowest
}
struct Highest : Decodable {
    var rating: Int
    var date: CLong
}
struct Lowest : Decodable {
    var rating: Int
    var date: CLong
}
struct Last : Decodable {
    var rating: Int
    var date: CLong
    var rd: Int
}
struct Best : Decodable {
    var rating : Int
    var date : CLong
    var game: String
}
struct Record : Decodable {
    var win: Int
    var loss: Int
    var draw: Int
    var time_per_move: Int?
    var timeout_percent: Float?
}
struct Tournament : Decodable {
    var points: Int
    var withdraw: Int
    var count: Int
    var highest_finish: Int
}

class ViewController: NSViewController, NSApplicationDelegate {
    
    @IBOutlet weak var pendingGamesLabel: NSTextField!
    @IBOutlet weak var dailyEloLabel: NSTextField!
    @IBOutlet weak var bulletEloLabel: NSTextField!
    @IBOutlet weak var blitzEloLabel: NSTextField!
    @IBOutlet weak var blitzRapidEloLabel: NSTextField!
    @IBOutlet weak var statisticsLabel: NSTextField!
    @IBOutlet weak var totalGamesLabel: NSTextField!
    
    var pendingGames: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = "hectorcarrasco"
        let jsonUrlPendingGamesString="https://api.chess.com/pub/player/"+user+"/games/to-move"
        guard let url = URL(string: jsonUrlPendingGamesString) else {return}
        URLSession.shared.dataTask(with: url){ (data, response, err) in
            
            guard let data = data else {return}
            
            do {
                
                let parsing  = try JSONDecoder().decode(ChessGames.self, from: data)
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
                
                let parsing2  = try JSONDecoder().decode(Stats.self, from: data2)
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
                    
                    AppDelegate().changeAppTitle(title: "ELO: \(parsing2.chess_daily.last.rating)")
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
    
    @IBAction func exitButton(_ sender: Any) {
        exit(0)
    }
    
}
