//
//  DetayViewController.swift
//  IMDBapp
//
//  Created by Bayram Yeleç on 27.09.2024.
//

import UIKit

class DetayViewController: UIViewController {

    var model: Model?
    var viewModel = ViewModel()
    var detayModel: DetayModel?

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLbl: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let aciklamaLbl: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let releasedLbl: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    private let runTimeLbl: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    private let actorsLbl: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    private let awardsLbl: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)

        setupUI()
        loadImage()

        if let imdbID = model?.imdbID {
            viewModel.fetchDetay(imdbId: imdbID) {
                self.detayModel = self.viewModel.detayModels.first
                self.loadData()
            }
        }
    }

    private func setupUI() {
        view.addSubview(imageView)
        view.addSubview(titleLbl)
        view.addSubview(aciklamaLbl)
        view.addSubview(releasedLbl)
        view.addSubview(runTimeLbl)
        view.addSubview(actorsLbl)
        view.addSubview(awardsLbl)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),

            titleLbl.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            aciklamaLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 10),
            aciklamaLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            aciklamaLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            releasedLbl.topAnchor.constraint(equalTo: aciklamaLbl.bottomAnchor, constant: 10),
            releasedLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            releasedLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            runTimeLbl.topAnchor.constraint(equalTo: releasedLbl.bottomAnchor, constant: 10),
            runTimeLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            runTimeLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            actorsLbl.topAnchor.constraint(equalTo: runTimeLbl.bottomAnchor, constant: 10),
            actorsLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            actorsLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            awardsLbl.topAnchor.constraint(equalTo: actorsLbl.bottomAnchor, constant: 10),
            awardsLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            awardsLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }

    private func loadImage() {
        guard let imageUrl = model?.poster, let url = URL(string: imageUrl) else {
            imageView.image = UIImage(named: "placeholder")
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let data = data, error == nil, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(named: "placeholder")
                }
            }
        }.resume()
    }

    private func loadData() {
        titleLbl.text = model?.title
        aciklamaLbl.text = detayModel?.plot
        releasedLbl.text = "Released: \(detayModel?.released ?? "N/A")"
        runTimeLbl.text = "Runtime: \(detayModel?.runTime ?? "N/A")"
        actorsLbl.text = "Actors: \(detayModel?.actors ?? "N/A")"
        awardsLbl.text = "Awards: \(detayModel?.awards ?? "N/A")"
    }
}
