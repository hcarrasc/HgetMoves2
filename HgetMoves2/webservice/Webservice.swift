//
//  Webservice.swift
//  HgetMoves2
//
//  Created by Hector on 5/21/19.
//  Copyright © 2019 hcarrasco. All rights reserved.
//

import Cocoa

protocol NetworkDelegate {
    func didFinishgetStatistic(result: Data)
    func didFinishgetPendingGames(result: Data)
}

class WebserviceHandler: NSObject {
    
    var delegate: NetworkDelegate? = nil
    
    func getChessdotcomPendingGames() {
        
        let user = "hectorcarrasco"
        let jsonUrlPendingGamesString="https://api.chess.com/pub/player/"+user+"/games/to-move"
        guard let url = URL(string: jsonUrlPendingGamesString) else {return}
        URLSession.shared.dataTask(with: url){ (data, response, err) in
            guard let data = data else {return}
            self.delegate?.didFinishgetPendingGames(result: data)
        }.resume()

    }
    
    func getStatisticData() {
        
        let user = "hectorcarrasco"
        let jsonUrlUserInfoString="https://api.chess.com/pub/player/"+user+"/stats"
        guard let url = URL(string: jsonUrlUserInfoString) else {return}
        URLSession.shared.dataTask(with: url){ (data, response, err) in
            guard let data = data else {return}
            self.delegate?.didFinishgetStatistic(result: data)
        }.resume()
    }
    
}
