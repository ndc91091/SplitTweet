//
//  TweetTableViewCell.swift
//  TikAssignment
//
//  Created by Cuong Nguyen on 10/6/19.
//  Copyright © 2019 Cuong Nguyen. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    lazy var tweetLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        self.addSubview(tweetLabel)
        self.tweetLabel.font = UIFont.systemFont(ofSize: 20)
        tweetLabel.numberOfLines = 0
        tweetLabel.lineBreakMode = .byWordWrapping
        self.tweetLabel.textColor = .black
        
        tweetLabel.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = tweetLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        let leadingConstraint = tweetLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let trailingConstraint = tweetLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        let bottomConstraint = tweetLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        
        NSLayoutConstraint.activate([topConstraint, leadingConstraint, trailingConstraint, bottomConstraint])
    }
}
