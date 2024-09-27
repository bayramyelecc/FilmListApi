//
//  DetayModel.swift
//  IMDBapp
//
//  Created by Bayram Yeleç on 27.09.2024.
//

import Foundation


struct DetayModel : Codable {
    
    let released : String?
    let runTime : String?
    let plot : String?
    let actors : String?
    let awards : String?
    
    enum CodingKeys: String, CodingKey {
        case released = "Released"
        case runTime = "Runtime"
        case plot = "Plot"
        case actors = "Actors"
        case awards = "Awards"
    }
    
}
