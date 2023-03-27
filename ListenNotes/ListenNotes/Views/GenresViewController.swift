//
//  GenresViewController.swift
//  ListenNotes
//
//  Created by Alexandr Chernets on 27.03.2023.
//

import UIKit


final class GenresViewController: UITableViewController {

    // MARK: Properties
    var models = [Genre]()
    var presenter = GenresPresenter()
    
    
    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.view  = self
        tableView.refreshControl = UIRefreshControl()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.refreshControl?.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        onRefresh()
    }
    
    // MARK: Private functions
    @objc private func onRefresh() {
        presenter.onRefresh()
    }
    
    // MARK: UITableViewDelegate & UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
        cell.textLabel?.text = models[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let genre = models[indexPath.row]
        presenter.onSelect(genre)
    }
}

extension GenresViewController: GenresView {
    
    func display(_ genres: [Genre]) {
        models = genres
        tableView.reloadData()
    }
    
    func display(isLoading: Bool) {
        
        if isLoading {
            tableView.refreshControl?.beginRefreshing()
        } else {
            tableView.refreshControl?.endRefreshing()
        }
    }
}
