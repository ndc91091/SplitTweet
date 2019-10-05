//
//  ViewController.swift
//  TikAssignment
//
//  Created by Cuong Nguyen on 10/5/19.
//  Copyright © 2019 Cuong Nguyen. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    lazy var messageTweet = String()
    lazy var tweets = [String]()
    var tweetSplit: TweetSplit?
    
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Send Tweet"
        setupView()
        tweetSplit = TweetSplit()
    }
    
    private func setupView() {
        self.messageTextView.font = UIFont.systemFont(ofSize: 20)
    }
    
    @IBAction func sendTweetClicked(_ sender: Any) {
        let listTweetsViewController = ListTweetsViewController()
        self.messageTweet = messageTextView.text
        guard let tweetSplit = self.tweetSplit else { return }
        self.tweets = tweetSplit.splitMessage(self.messageTweet)
        listTweetsViewController.listTweets = self.tweets
        self.navigationController?.pushViewController(listTweetsViewController, animated: true)
    }
}

extension TweetViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
         let text = (self.messageTextView.text! as NSString).replacingCharacters(in: range, with: text)
               if text.isEmpty {
                   sendButton.isEnabled = false
                   sendButton.alpha = 0.5
               } else {
                   sendButton.isEnabled = true
                   sendButton.alpha = 1.0
               }
               return true
    }
    
}

