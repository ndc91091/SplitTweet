//
//  TikAssignmentTests.swift
//  TikAssignmentTests
//
//  Created by Cuong Nguyen on 10/5/19.
//  Copyright © 2019 Cuong Nguyen. All rights reserved.
//

import XCTest
@testable import TikAssignment

class TikAssignmentTests: XCTestCase {
    var tweetSplit: TweetSplit?
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        tweetSplit = TweetSplit()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testTwitMessageMoreThanLimitCharactersWithNoSpace() {
        let inputString = "Loremipsumdolorsiterelitlamet,consectetaurcilliumadipisicingpecuLoremipsumdolorsiterelitlamet,consectetaurcilliumadipisicingpecu"
        let expectResult = [String]()
        let output = tweetSplit?.splitMessage(inputString)
        XCTAssertEqual(output, expectResult)
    }

    func testTwitMessageWithSplit() {
        let inputString = "I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself."
        let expectResult = ["1/2 I can't believe Tweeter now supports chunking",
                            "2/2 my messages, so I don't have to do it myself."]
        let output = tweetSplit?.splitMessage(inputString)
        XCTAssertEqual(output, expectResult)
    }

    func testTwitMessageCanNotSpitWithMoreThanLimitCharacters() {
        let inputString = "Loremipsumdolorsiterelitlamet,consectetaurcilliumadipisicingpecu,sed doeiusmodtemporincididuntutlaboreetdoloremagnaaliqua.Utenimadminimveniam,quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
        let expectResult = [String]()
        let output = tweetSplit?.splitMessage(inputString)
        XCTAssertEqual(output, expectResult)
    }

    func testUserTwitMessageLessThanLimitCharacters() {
        let inputString = "Loremipsumdolorsiterelitlamet,consectetaurcilli sed doeiusmodtemporincididuntutlaboreetdo. Utenimadminimveniam,quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo"
        let expectResult = ["1/4 Loremipsumdolorsiterelitlamet,consectetaurcilli",
                            "2/4 sed doeiusmodtemporincididuntutlaboreetdo.",
                            "3/4 Utenimadminimveniam,quis nostrud exercitation",
                            "4/4 ullamco laboris nisi ut aliquip ex ea commodo"]
        let outputResult = tweetSplit?.splitMessage(inputString)
        XCTAssertEqual(outputResult, expectResult)
    }

    func testWithMessageHasOnlySpace() {
        let inputString = "I can'tbelieveTweeternowsupportschunkingmymessages,soIdon'thavetodoitmyself"
        let expectResult = [String]()
        let output = tweetSplit?.splitMessage(inputString)
        XCTAssertEqual(output, expectResult)
    }

    func testTweetWithTenSpace() {
        let inputString = "                                                       "
        let expectResult = [String]()
        let output = tweetSplit?.splitMessage(inputString);
        XCTAssertEqual(output, expectResult)
    }

    func testTweetWithMultiSpaceAndCharacters() {
        let inputString = "I can't      believeTweeternows      upportschunki    ngmymessages,so  I       don't have to do it                   myself"
        let expectResult = ["1/2 I can\'t believeTweeternows upportschunki",
                            "2/2 ngmymessages,so I don\'t have to do it myself"]
        let output = tweetSplit?.splitMessage(inputString)
        XCTAssertEqual(output, expectResult)
    }

    func testTweetMoreThan10Chunks() {
        let inputString = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        let expectResult = ["1/11 Lorem ipsum dolor sit er elit lamet,",
                            "2/11 consectetaur cillium adipisicing pecu, sed do",
                            "3/11 eiusmod tempor incididunt ut labore et dolore",
                            "4/11 magna aliqua. Ut enim ad minim veniam, quis",
                            "5/11 nostrud exercitation ullamco laboris nisi ut",
                            "6/11 aliquip ex ea commodo consequat. Duis aute",
                            "7/11 irure dolor in reprehenderit in voluptate",
                            "8/11 velit esse cillum dolore eu fugiat nulla",
                            "9/11 pariatur. Excepteur sint occaecat cupidatat",
                            "10/11 non proident, sunt in culpa qui officia",
                            "11/11 deserunt mollit anim id est laborum."]
        let output = tweetSplit?.splitMessage(inputString)
        XCTAssertEqual(output, expectResult)
    }

    func testTweetWithHTMLCharacterLessThan10Chunks() {
        let inputString = "<h1>Lorem ipsum dolor sit er elit lamet</h1> consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt <hr>ut labore et dolore magna</hr> aliqua. Ut enim ad minim <br>veniam, quis nostrud exercitation</br> ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in <p>reprehenderit in voluptate velit esse cillum dolore</p> eu fugiat nulla pariatur"
        let expectResult = ["1/9 <h1>Lorem ipsum dolor sit er elit lamet</h1>",
                            "2/9 consectetaur cillium adipisicing pecu, sed do",
                            "3/9 eiusmod tempor incididunt <hr>ut labore et",
                            "4/9 dolore magna</hr> aliqua. Ut enim ad minim",
                            "5/9 <br>veniam, quis nostrud exercitation</br>",
                            "6/9 ullamco laboris nisi ut aliquip ex ea commodo",
                            "7/9 consequat. Duis aute irure dolor in",
                            "8/9 <p>reprehenderit in voluptate velit esse",
                            "9/9 cillum dolore</p> eu fugiat nulla pariatur"]
        let output = tweetSplit?.splitMessage(inputString)
        XCTAssertEqual(output, expectResult)
    }

    func testTweetWithSpecialCharacter() {
        let inputString = "@#$&@)$& Lorem ipsum dolor sit er elit lamet, consectetaur $((&_!#!#$2"
        let expectResult = ["1/2 @#$&@)$& Lorem ipsum dolor sit er elit lamet,",
                            "2/2 consectetaur $((&_!#!#$2"]
        let output = tweetSplit?.splitMessage(inputString)
        XCTAssertEqual(output, expectResult)
    }

    func testTweetHasUnicodeCharacter() {
        let inputString = "🤓🤓🤓🤓🤓🤓 😜😜😜😜😜 Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu"
        let expectResult = ["1/2 🤓🤓🤓🤓🤓🤓 😜😜😜😜😜 Lorem ipsum dolor sit er elit",
                            "2/2 lamet, consectetaur cillium adipisicing pecu"]
        let output = tweetSplit?.splitMessage(inputString)
        XCTAssertEqual(output, expectResult)
    }
    
    func testLengthOfIndicator() {
        let partionIndex = 5
        let maximumPartion = 10
        let expectResult = 5 // Length text is 5 because that text included "/" character and white space at the end
        let output = tweetSplit?.lengthOfIndicator(partionIndex, andMaxNumberOfSubTweet: maximumPartion)
        XCTAssertEqual(output, expectResult)
    }

}
