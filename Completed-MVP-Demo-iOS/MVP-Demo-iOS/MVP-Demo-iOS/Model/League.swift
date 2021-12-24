//
//  League.swift
//  MVP-Demo-iOS
//
//  Created by Ikmal Azman on 24/12/2021.
// https://api-football-standings.azharimm.site/leagues

import Foundation

struct LeagueResponse : Decodable{
    let data : [League]
}
struct League : Decodable {
    let name : String
}


