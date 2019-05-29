//
//  Webservice.swift
//  HgetMoves2
//
//  Created by Hector on 5/21/19.
//  Copyright © 2019 hcarrasco. All rights reserved.
//

import Cocoa

class WebserviceHandler: NSObject {
    
    var json : [String: Any] = [:]
    
    func getChessdotcomStats() {
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let user = "hectorcarrasco"
        
        let url = URL(string: "https://api.chess.com/pub/player/"+user+"/stats")!
        let task = session.dataTask(with: url) { data, response, error in
            
            // ensure there is no error for this HTTP response
            guard error == nil else {
                print ("error: \(error!)")
                return
            }
            
            // ensure there is data returned from this HTTP response
            guard let content = data else {
                print("No data")
                return
            }
            
            // serialise the data / NSData object into Dictionary [String : Any]
            guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                print("Not containing JSON")
                return
            }
            
            print("stats:::::: is \n \(json)")
            // update UI using the response here
        }
        
        // execute the HTTP request
        task.resume()
        
    }
    
    func getChessdotcomPendingGames() {
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let user = "hectorcarrasco"
        
        let url = URL(string: "https://api.chess.com/pub/player/"+user+"/games/to-move")!
        let task = session.dataTask(with: url) { data, response, error in
            
            // ensure there is no error for this HTTP response
            guard error == nil else {
                print ("error: \(error!)")
                return
            }
            
            // ensure there is data returned from this HTTP response
            guard let content = data else {
                print("No data")
                return
            }
            
            print ("row content:=> \(content)")
            
            // serialise the data / NSData object into Dictionary [String : Any]
            guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                print("Not containing JSON")
                return
            }
            
            print ("json dict: => \(json)")
            // update UI using the response here
        }
        
        task.resume()
    }


}
