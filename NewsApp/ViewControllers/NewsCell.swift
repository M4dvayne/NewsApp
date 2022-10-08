//
//  NewsCell.swift
//  NewsApp
//
//  Created by Вячеслав Кремнев on 24.09.2022.
//

import UIKit

class NewsCell: UITableViewCell {
    
    private let newsImageView = NewsImageView()
    private let newsTitleLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViewAndConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Storyboard is not in use")
    }
    
    //MARK: Cell Fetch Data Methods
    func setNewsImage(url: String) {
        DispatchQueue.main.async {
            self.newsImageView.fetchImage(from: url)
            print("DONE")
        }
    }
    
    func setTitleText(url: String, titleIndex: Int) {
        NetworkManager.shared.fetchData(url) { news in
            DispatchQueue.main.async {
                self.newsTitleLabel.text = news.news[titleIndex].title
            }
        }
    }
    
    
    //MARK: Configure Cell And Constraints
    private func configureImageView() {
        newsImageView.layer.cornerRadius = 10
        newsImageView.clipsToBounds = true
    }
    
    private func configureTitleLabel() {
        newsTitleLabel.font = UIFont.systemFont(ofSize: 14)
        newsTitleLabel.numberOfLines = 0
    }
    
    private func setImageConstraints() {
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        newsImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        newsImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        newsImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        newsImageView.widthAnchor.constraint(equalTo: newsImageView.heightAnchor, multiplier: 16/9).isActive = true
        
    }
    
    private func setTitleConstraints() {
        newsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        newsTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        newsTitleLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 20).isActive = true
        newsTitleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        newsTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        
    }
    
    private func configureViewAndConstraints() {
        addSubview(newsImageView)
        addSubview(newsTitleLabel)
        configureImageView()
        configureTitleLabel()
        setImageConstraints()
        setTitleConstraints()
    }
}


