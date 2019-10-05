# SplitTweet
![](https://img.shields.io/badge/Supported-iOS9.0-4BC51D.svg?style=flat)
![](https://img.shields.io/badge/Swift5.1-compatible-4BC51D.svg?style=flat)

SplitTweet allow users to post short message limited to 50 characters. 

## Enviroment

- iOS 13.0
- Xcode 11
- Swift 5.1

## What I've done

- Logic for split message tweet
- TweetSplit application
- Unit test

## Steps to SplitTweet works

- **Step 1:** Standard input tweet.
```swift
extension String { 
    public func standardizedWhitespace() -> String {
        let components = self.components(separatedBy: .whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
}
```
- **Step 2:** Check a tweet is empty
```swift
if tweetString.count == 0 {
  return []
}
```
- **Step 3:** Check a tweet has number of characters smaller or equal 50. Return message. 
```swift
if tweetString.count <= TWEET_MAX_LENGTH {
   return([tweetString])
}
```
- **Step 4:** Check if a tweet contains a word which has more than 50 characters.
```swift
let parts = tweetString.components(separatedBy:" ")
//Check string more than 50 chracters
for item in parts {
    if item.count > TWEET_MAX_LENGTH {
       return []
    }
}
```
- **Step 5:** Implement `SplitTweet` logic

Dividing the assuming number of subtweets to different ranges. 
(1-9, 10-99, 100-999...) Why should we do that?
For example, if the number of subtweets is from 1-9, all the indicator is in form of "x/x " which needs 4 characters to present.
If the number of subtweets if from 10-99, the indicators are in form of "x/yy "(5 characters) or "xx/yy " (6 characters).

```swift
var maxNumberSubTweet = 1
var count = 0
while true {
      let result = combineMessages(parts, withMaxNumberSubTweet: maxNumberSubTweet, AndMaximumTweetLength: TWEET_MAX_LENGTH)
      if result.success {
         return result.subTweets
      } else {
        count = count + 1
        maxNumberSubTweet = Int(powf(10.0, Float(count))) - 1;
      }
}
```

We will run into many ranges until we find the suitable results.
In each range, 
- Create a new sentence with a first word in the tweet.
- We will loop all words in a tweet
    + Calculate the index of the subtweet.
    ```swift
    var numberSubTweet = 1
    ```
    + Calculate the number of characters that the indicators need.
    ```swift
    var maxSubTweetLength = maxTweetLength - lengthOfIndicator(numberSubTweet, andMaxNumberOfSubTweet: maxNumberSubTweet)
    ```
    + Try to append a word into a sentence if there is a space. If not, create a new subtweet and append a proccessing word to subtweet.
    ```swift         
    for index in 1..<(messages.count) {
        let message  = messages[index]

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
    ```
    + If the number of subtweets is out of the defined range, we will try to increase the assuming number of subtweets to the next range.
      ```swift
      if numberSubTweet > maxNumberSubTweet {
          return Result(subTweets: [], success: false)
      }
      ```
- Loop to all subtweets, append the indicator and return the result.
     ```swift
    for (i, sentence) in results.enumerated() {
        results[i] = "\(i+1)/\(numberSubTweet) \(sentence)"
    }
    return Result(subTweets:results, success: true)
    ```
## License

SplitTweet is released under the MIT license. See LICENSE for details.
