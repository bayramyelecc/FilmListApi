//
//  ViewController.swift
//  IMDBapp
//
//  Created by Bayram Yeleç on 27.09.2024.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    let searchBar = UISearchBar()
    var isSearching = false
    var viewModel = ViewModel()
    var items : [Model] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        searchBar.placeholder = "Search here..."
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
        } else {
            isSearching = true
            
            viewModel.fetchFilmler(search: searchText) {
                self.tableView.reloadData()
            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let model = viewModel.models[indexPath.row]
        
        
        let imageView = cell.viewWithTag(1) as? UIImageView
        let titleLbl = cell.viewWithTag(2) as? UILabel
        let yearLbl = cell.viewWithTag(3) as? UILabel
        let tipLbl = cell.viewWithTag(4) as? UILabel
        
        titleLbl?.text =  model.title
        yearLbl?.text = model.year
        tipLbl?.text = model.type
        
        if let imageUrl = model.poster, let url = URL(string: imageUrl) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data , error == nil, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageView?.image = image
                    }
                }
            }.resume()
        } else {
            imageView?.image = UIImage(named: "placeholder")
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detayViewController = DetayViewController()
        detayViewController.model = viewModel.models[indexPath.row]
        navigationController?.pushViewController(detayViewController, animated: true)
    }
    
    
}


