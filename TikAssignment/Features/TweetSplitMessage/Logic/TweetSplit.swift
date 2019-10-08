//
//  TweetSplit.swift
//  TikAssignment
//
//  Created by Cuong Nguyen on 10/5/19.
//  Copyright © 2019 Cuong Nguyen. All rights reserved.
//

import Foundation

struct Result {
    let subTweets: [String]
    let success: Bool
}

protocol TweetSplitType {
    /// Split tweet to parts
    /// - Parameter message: Tweet text
    func splitMessage(_ message: String) -> [String]
    
    /// Combine all sub tweet
    /// - Parameter messages: List of message
    /// - Parameter maxNumberSubTweet: maximum part of sub-tweet
    /// - Parameter maxTweetLength: maximum text's length in tweet
    func combineMessages(_ messages:[String], withMaxNumberSubTweet maxNumberSubTweet: Int, AndMaximumTweetLength maxTweetLength: Int) -> Result
    
    /// Caculate length of indicator
    /// - Parameter indexOfPartition: prefix number
    /// - Parameter number: suffix number
    func lengthOfIndicator(_ indexOfPartition: Int, andMaxNumberOfSubTweet number: Int) -> Int
}

class TweetSplit: TweetSplitType {
    
    private let TWEET_MAX_LENGTH = 50
    
    func splitMessage(_ message: String) -> [String] {
        let tweetString = message.standardizedWhitespace()
        //Check string empty
        if tweetString.count == 0 {
            return []
        }
        
        if tweetString.count <= TWEET_MAX_LENGTH {
            return([tweetString])
        }
        
        let parts = tweetString.components(separatedBy:" ")
        //Check string more than 50 chracters
        guard parts.first(where: { $0.count > TWEET_MAX_LENGTH }) == nil else {
            return []
        }
        
        var maxNumberSubTweet: Int = self.estimateNumberOfSubTweet(tweetString, maximumTweetLength: TWEET_MAX_LENGTH)
        var count: Int = String(maxNumberSubTweet).count
        while true {
            let result = combineMessages(parts, withMaxNumberSubTweet: maxNumberSubTweet, AndMaximumTweetLength: TWEET_MAX_LENGTH)
            if result.success {
                return result.subTweets
            } else {
                count = count + 1
                maxNumberSubTweet = Int(powf(10.0, Float(count))) - 1
            }
        }
        
    }
    
    func combineMessages(_ messages: [String], withMaxNumberSubTweet maxNumberSubTweet: Int, AndMaximumTweetLength maxTweetLength: Int) -> Result {
        var sentence: String = messages.first!
        var results: [String] = []
        var numberSubTweet = 1
        var maxSubTweetLength = maxTweetLength - lengthOfIndicator(numberSubTweet, andMaxNumberOfSubTweet: maxNumberSubTweet)
        
        if sentence.count > maxSubTweetLength {
            return Result(subTweets: [], success: true)
        }
        
        for index in 1..<(messages.count) {
            let message  = messages[index]
            
            if message.count > maxSubTweetLength {
               return Result(subTweets: [], success: true)
            }
            
            if (sentence.count + message.count + 1) <= maxSubTweetLength {
                sentence = "\(sentence) \(message)"
            } else {
                results.append(sentence)
                numberSubTweet = numberSubTweet + 1
                maxSubTweetLength = maxTweetLength - lengthOfIndicator(numberSubTweet, andMaxNumberOfSubTweet: maxNumberSubTweet)
                sentence = message
            }
            
            if numberSubTweet > maxNumberSubTweet {
                return Result(subTweets: [], success: false)
            }
        }
        
        results.append(sentence)
        
        // add indicator when number of sub tweet great than 1.
        for (i, sentence) in results.enumerated() {
            results[i] = "\(i+1)/\(numberSubTweet) \(sentence)"
        }
        return Result(subTweets:results, success: true)
    }
    
    func lengthOfIndicator(_ indexOfPartition: Int, andMaxNumberOfSubTweet number: Int) -> Int {
        return "\(indexOfPartition)/\(number) ".count
    }
    
    func estimateNumberOfSubTweet(_ inputString: String, maximumTweetLength: Int) -> Int {
        let estimateNumberOfSubTweet: Int = inputString.count / maximumTweetLength
        
        let estimateNumberOfSubTweetLength: Int = String(estimateNumberOfSubTweet).count
        
        // indicator: "index/numberOfSubTweet " for each line
        // calculate length of "/numberOfSubTweet "
        var estimateLengthOfIndicator: Int = (estimateNumberOfSubTweet + 2) * estimateNumberOfSubTweetLength
        if estimateNumberOfSubTweetLength > 9 {
            // calculate length of indexes
            for i in 1...(estimateNumberOfSubTweetLength - 1) {
                let numberOfNumbers = Int(powf(10, Float(i)))
                estimateLengthOfIndicator = estimateLengthOfIndicator + (numberOfNumbers - (numberOfNumbers / 10 - 1))
            }
            
            estimateLengthOfIndicator = estimateLengthOfIndicator + (estimateNumberOfSubTweet - (Int(powf(10, Float(estimateNumberOfSubTweetLength))) / 10 - 1))
        } else {
            estimateLengthOfIndicator = estimateNumberOfSubTweetLength
        }
        
        return (inputString.count + estimateLengthOfIndicator) / maximumTweetLength
    }
}
