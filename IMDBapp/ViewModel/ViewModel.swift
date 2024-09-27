//
//  ViewModel.swift
//  IMDBapp
//
//  Created by Bayram Yeleç on 27.09.2024.
//

import Foundation


class ViewModel {
    
    var models : [Model] = []
    var detayModels : [DetayModel] = []
    
    func fetchFilmler(search: String, completion: @escaping () -> Void){
        
        guard let url = URL(string: "https://www.omdbapi.com/?s=\(search)&apikey=341e71dc") else {
            print("url hatası")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("data hatası")
                return
            }
            
            do{
                let model = try JSONDecoder().decode(arama.self, from: data)
                DispatchQueue.main.async {
                    self?.models = model.search
                    completion()
                }
            } catch {
                print("decode hatası")
            }
            
        }
        task.resume()
        
    }
    
    func fetchDetay(imdbId: String, completion: @escaping () -> Void){
        
        guard let url = URL(string: "https://www.omdbapi.com/?i=\(imdbId)&apikey=341e71dc") else {
            print("url hatası")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("data hatası")
                return
            }
            
            do{
                let model = try JSONDecoder().decode(DetayModel.self, from: data)
                DispatchQueue.main.async {
                    self?.detayModels = [model]
                    completion()
                }
            } catch {
                print("decode hatası")
            }
            
        }
        task.resume()
        
    }
    
}


