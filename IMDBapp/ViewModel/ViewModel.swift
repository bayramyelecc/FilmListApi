//
//  ViewModel.swift
//  IMDBapp
//
//  Created by Bayram Yeleç on 27.09.2024.
//

import Foundation


class ViewModel {
    
    var models : [Model] = []
    
    func fetchFilmler(search: String, completion: @escaping () -> Void){
        
        guard let url = URL(string: "http://www.omdbapi.com/?s=\(search)&apikey=341e71dc") else {
            print("url hatası")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                print("data hatası")
                return
            }
        }
        
    }
    
}
