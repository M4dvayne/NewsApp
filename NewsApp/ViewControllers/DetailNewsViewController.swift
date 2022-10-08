//
//  DetailNewsViewController.swift
//  NewsApp
//
//  Created by Вячеслав Кремнев on 29.09.2022.
//

import UIKit

class DetailNewsViewController: UIViewController {
    
    private let newsImage = NewsImageView()
    var news: NewsElement!
    
    //MARK: ViewElements
    
    private lazy var detailNewsImageView: UIImageView = {
        let detailNewsImageView = UIImageView()
        detailNewsImageView.backgroundColor = UIColor.lightGray
        detailNewsImageView.layer.cornerRadius = 20
        detailNewsImageView.clipsToBounds = true
        loadMainImage(from: news.image)
        
        return detailNewsImageView
    }()
    
    private lazy var detailNewsTitleLabel: UILabel = {
        let detailNewsTitleLabel = UILabel()
        detailNewsTitleLabel.text = news.title
        detailNewsTitleLabel.textColor = .red
        detailNewsTitleLabel.font = UIFont.systemFont(ofSize: 16)
        detailNewsTitleLabel.numberOfLines = 0
        
        return detailNewsTitleLabel
    }()
    
    private lazy var detailNewsBodyLabel: UILabel = {
        let detailNewsBodyLabel = UILabel()
        detailNewsBodyLabel.text = news.newsDescription
        detailNewsBodyLabel.numberOfLines = 0
        detailNewsBodyLabel.font = UIFont.systemFont(ofSize: 14)
        
        return detailNewsBodyLabel
    }()
    
    
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        prepareSubviewsWithConstraints()
    }
    
    //MARK: SetupConstraints
    
    private func setDetailNewsImageViewConstraints() {
        detailNewsImageView.translatesAutoresizingMaskIntoConstraints                                                                             = false
        detailNewsImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive                                            = true
        detailNewsImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive                                          = true
        detailNewsImageView.heightAnchor.constraint(equalToConstant: 200).isActive                                                                = true
        detailNewsImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive                                       = true
    }
    
    private func setDetailNewsTitleConstraints() {
        detailNewsTitleLabel.translatesAutoresizingMaskIntoConstraints                                                                            = false
        detailNewsTitleLabel.topAnchor.constraint(equalTo: detailNewsImageView.bottomAnchor, constant: 20).isActive                               = true
        detailNewsTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive                                         = true
        detailNewsTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive                                      = true
    }
    
    private func setDetailNewsBodyLabelConstraints() {
        detailNewsBodyLabel.translatesAutoresizingMaskIntoConstraints                                                                             = false
        detailNewsBodyLabel.topAnchor.constraint(equalTo: detailNewsTitleLabel.bottomAnchor, constant: 15).isActive                               = true
        detailNewsBodyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive                                          = true
        detailNewsBodyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive                                       = true
    }
    
    private func prepareSubviewsWithConstraints() {
        view.addSubview(detailNewsTitleLabel)
        view.addSubview(detailNewsImageView)
        view.addSubview(detailNewsBodyLabel)
        setDetailNewsImageViewConstraints()
        setDetailNewsTitleConstraints()
        setDetailNewsBodyLabelConstraints()
    }
}


//MARK: Extension
extension DetailNewsViewController{
    
    private func loadMainImage(from url: String?){
        guard let stringURL = url else {return}
        guard let imageURL = URL(string: stringURL) else {return}
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else {return}
            let image = UIImage(data: imageData)
            
            DispatchQueue.main.async {
                self.detailNewsImageView.image = image
            }
        }
    }
}
