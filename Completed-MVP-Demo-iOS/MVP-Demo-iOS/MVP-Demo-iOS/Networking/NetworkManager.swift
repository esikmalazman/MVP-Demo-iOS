//
//  NetworkManager.swift
//  MVP-Demo-iOS
//
//  Created by Ikmal Azman on 24/12/2021.
//

import Foundation

final class NetworkManager {
    private let baseUrl = "https://api-football-standings.azharimm.site/leagues"
    
     func requestLeague(completion : @escaping (([League])->Void)) {
        guard let baseUrl = URL(string: baseUrl) else {return}
        
        let task = URLSession.shared.dataTask(with: baseUrl) { data, _, _ in
            guard let data = data else {
                return
            }

            do {
                let decodedObject = try JSONDecoder().decode(LeagueResponse.self, from: data)
                print(decodedObject.data)
                completion(decodedObject.data)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
