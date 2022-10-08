//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Вячеслав Кремнев on 18.09.2022.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var news: [News] = []
    private let tableView = UITableView()
    
    struct Cells {
        static let newsCell = "NewsCell"
    }
    
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setUpTableView()
        fetchNews()
    }
    
    //MARK: ViewDidLayoutSubviews
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
    //MARK: TableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.first?.news.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.newsCell, for: indexPath) as! NewsCell
        if let newImage = news.first?.news[indexPath.row].image {
            cell.setNewsImage(url: newImage)
        }
        
        cell.setTitleText(url: Link.requestURL.rawValue, titleIndex: indexPath.row)
        
        return cell
    }
    
    
    //MARK: TableViewDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        getDetailNewsInfo(of: indexPath.row)
        print("cell tapped at \(indexPath.row)")
    }
    
    //MARK: Setup TableView
    private func setUpTableView() {
        view.addSubview(tableView)
        tableView.register(NewsCell.self, forCellReuseIdentifier: Cells.newsCell)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
    }
    
    //MARK: Setup NavigationController
    private func setupNavigationController() {
        title = "Fresh News"
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    
    //MARK: Navigation
    @objc private func getDetailNewsInfo(of tappedCell: Int) {
        let detailVC = DetailNewsViewController()
        detailVC.news = news.first?.news[tappedCell]
      DispatchQueue.main.async {
           self.navigationController?.pushViewController(detailVC, animated: true)
       }
    }
}

//MARK: Extension
extension NewsViewController {
    private func fetchNews() {
        NetworkManager.shared.fetchData(Link.requestURL.rawValue) { news  in
            self.news.append(news)
            self.tableView.reloadData()
            print(news)
        }
    }
}










