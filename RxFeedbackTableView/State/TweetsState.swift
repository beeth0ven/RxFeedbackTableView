//
//  TweetsState.swift
//  RxFeedbackTableView
//
//  Created by luojie on 2017/12/23.
//  Copyright © 2017年 LuoJie. All rights reserved.
//

import Foundation

struct TweetsState {
    typealias TweetStates = (tweet: Tweet, isToogleLiking: Bool)
    var tweetStates: [TweetStates]
    var getTweetsError: Error?
    var toogleLikeTweetError: Error?
    
    static var empty: TweetsState {
        return TweetsState(
            tweetStates: [],
            getTweetsError: nil,
            toogleLikeTweetError: nil
        )
    }
    
    static func reduce(state: TweetsState, event: TweetsState.Event) -> TweetsState {
        switch event {
        case .onGetTweets(let tweets):
            let tweetStates: [TweetStates] = tweets.map { (tweet: $0, isToogleLiking: false) }
            return TweetsState(
                tweetStates: tweetStates,
                getTweetsError: nil,
                toogleLikeTweetError: nil
            )
        case .onGetTweetsError(let error):
            return TweetsState(
                tweetStates: state.tweetStates,
                getTweetsError: error,
                toogleLikeTweetError: nil
            )
        case .onTooglingLikeTweet(let index):
            var newState = state
            newState.tweetStates[index].isToogleLiking = true
            return newState
        case .onToogledLikeTweet(let index):
            var newState = state
            var tweetState = newState.tweetStates[index]
            tweetState.isToogleLiking = false
            tweetState.tweet.liked = !tweetState.tweet.liked
            newState.tweetStates[index] = tweetState
            return newState
        case .onToogleLikeTweetError(let index, let error):
            var newState = state
            newState.tweetStates[index].isToogleLiking = true
            newState.toogleLikeTweetError = error
            return newState
        }
    }
}
