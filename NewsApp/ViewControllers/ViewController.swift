//
//  ViewController.swift
//  NewsApp
//
//  Created by Вячеслав Кремнев on 18.09.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var news: News!
    let tableView = UITableView()
    
    struct Cells {
        static let newsCell = "NewsCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setUpTableView()
        fetchNews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
    //MARK: TableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news?.news.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.newsCell, for: indexPath) as! NewsCell
        let newImage = news.news[indexPath.row].image
        cell.setNewsImage(url: newImage)
        cell.setTitleText(url: Link.requestURL.rawValue, titleIndex: indexPath.row)
        
        
        return cell
    }
    
    
    //MARK: TableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("cell tapped at \(indexPath.row)")
        
    }
    
    private func setUpTableView() {
        view.addSubview(tableView)
        tableView.register(NewsCell.self, forCellReuseIdentifier: Cells.newsCell)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
    }
    
    private func setupNavigationController() {
        title = "News"
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navBarBackground"), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        }
    }
}
extension ViewController {
    private func fetchNews() {
        NetworkManager.shared.fetchData(Link.requestURL.rawValue) { result in
            switch result {
            case .success(let news):
                self.news = news
                self.tableView.reloadData()
                print(news)
            case .failure(let error):
                print("here should be alert\(error)")
            }
        }
    }
}









