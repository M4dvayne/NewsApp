//
//  DetailNewsViewController.swift
//  NewsApp
//
//  Created by Вячеслав Кремнев on 29.09.2022.
//

import UIKit

class DetailNewsViewController: UIViewController {
    
    var news: NewsElement!
    
    private lazy var detailNewsImageView: UIImageView = {
        let detailNewsImageView = UIImageView()
        detailNewsImageView.backgroundColor = UIColor.orange
        detailNewsImageView.layer.cornerRadius = 20
        
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
        detailNewsBodyLabel.text = "Here should be the body of the text!"
        detailNewsBodyLabel.font = UIFont.systemFont(ofSize: 14)
        
        return detailNewsBodyLabel
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        prepareSubviewsWithConstraints()
        
    }
    
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
        detailNewsTitleLabel.heightAnchor.constraint(equalToConstant: 25).isActive                                                                = true
    }
    
    private func setDetailNewsBodyLabelConstraints() {
        detailNewsBodyLabel.translatesAutoresizingMaskIntoConstraints = false
        detailNewsBodyLabel.topAnchor.constraint(equalTo: detailNewsTitleLabel.bottomAnchor, constant: 15).isActive = true
        detailNewsBodyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        detailNewsBodyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 15).isActive = true
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
