//
//  NewsCell.swift
//  NewsApp
//
//  Created by Вячеслав Кремнев on 24.09.2022.
//

import UIKit

class NewsCell: UITableViewCell {

     let newsImageView = NewsImageView()
     let newsTitleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(newsImageView)
        addSubview(newsTitleLabel)
        configureImageView()
        configureTitleLabel()
        setImageConstraints()
        setTitleConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setNewsImage(url: String) {
        DispatchQueue.main.async {
            self.newsImageView.fetchImage(from: url)
            print("DONE")
        }
    }
    
    func setTitleText(url: String, titleIndex: Int) {
            NetworkManager.shared.fetchData(url, completion: { result in
                switch result {
                case .success(let title):
                    DispatchQueue.main.async {
                        self.newsTitleLabel.text = title.news[titleIndex].title
                    }
                case .failure(let error):
                    print("error is \(error)")
                }
            })
    }
    
    func configureImageView() {
        newsImageView.layer.cornerRadius = 10
        newsImageView.clipsToBounds = true
    }

    func configureTitleLabel() {
        newsTitleLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setImageConstraints() {
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        newsImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        newsImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        newsImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        newsImageView.widthAnchor.constraint(equalTo: newsImageView.heightAnchor, multiplier: 16/9).isActive = true
        
    }
    
    func setTitleConstraints() {
        newsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        newsTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        newsTitleLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 20).isActive = true
        newsTitleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        newsTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        
    }
}


