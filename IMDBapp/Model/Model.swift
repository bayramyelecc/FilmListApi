//
//  Model.swift
//  IMDBapp
//
//  Created by Bayram Yeleç on 27.09.2024.
//

import Foundation

struct Model : Codable {
    
    let title : String?
    let year : String?
    let imdbID : String?
    let type : String?
    let poster : String?
    
    enum CodingKeys:String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID = "imdbID"
        case type = "Type"
        case poster = "Poster"
    }
    
}

struct arama : Codable {
    
    let search : [Model]
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
    
}


