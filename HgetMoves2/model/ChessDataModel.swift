//
//  ChessDataModel.swift
//  HgetMoves2
//
//  Created by Hector on 5/29/19.
//  Copyright © 2019 hcarrasco. All rights reserved.
//

import Cocoa

class ChessDataModel: NSObject {
    
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
        //var tournament: Tournament
    }
    struct Chess960Daily : Decodable{
        var last: Last
        var best: Best
        var record: Record
        //var tournament: Tournament
    }
    struct ChessRapid : Decodable{
        var last: Last
        var best: Best
        var record: Record
        //var tournament: Tournament
    }
    struct ChessBullet : Decodable{
        var last: Last
        var best: Best
        var record: Record
        //var tournament: Tournament
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

}
