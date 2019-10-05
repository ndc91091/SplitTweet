//
//  ListTweetsViewController.swift
//  TikAssignment
//
//  Created by Cuong Nguyen on 10/5/19.
//  Copyright © 2019 Cuong Nguyen. All rights reserved.
//

import UIKit

class ListTweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let ESTIMATE_ROW_HEIGHT = 100
    var tableView = UITableView()
    var listTweets: [String]?
    
    let tweetCell = TweetTableViewCell.self
    var cellIdentifier: String { return String(describing: tweetCell) }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        setupTableView()
        setupConstraint()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(tweetCell, forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = CGFloat(ESTIMATE_ROW_HEIGHT)
    }
    
    private func setupConstraint() {
        tableView.translatesAutoresizingMaskIntoConstraints = false 
        let topConstraint = tableView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let leadingConstraint = tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingConstraint = tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottomConstraint = tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        NSLayoutConstraint.activate([topConstraint, leadingConstraint, trailingConstraint, bottomConstraint])
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTweets?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TweetTableViewCell else {
            return UITableViewCell()
        }
        guard let listTweets = listTweets else { return cell}
        cell.tweetLabel.text = listTweets[indexPath.row]
        return cell
    }
}

