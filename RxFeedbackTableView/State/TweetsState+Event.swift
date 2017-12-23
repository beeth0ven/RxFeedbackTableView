//
//  TweetsState+Event.swift
//  RxFeedbackTableView
//
//  Created by luojie on 2017/12/23.
//  Copyright © 2017年 LuoJie. All rights reserved.
//

import Foundation
import RxSwift

extension TweetsState {
    
    enum Event {
        case onGetTweets([Tweet])
        case onGetTweetsError(Error)
        case onTooglingLikeTweet(Int)
        case onToogledLikeTweet(Int)
        case onToogleLikeTweetError(Int, Error)
    }
}

extension TweetsState.Event {
    
    enum Async<TweetServiceType: TweetServiceProtocol> {
        
        static func getTweets() -> Observable<TweetsState.Event> {
            return TweetServiceType.tweets()
                .map(TweetsState.Event.onGetTweets)
                .catchError { error in .just(.onGetTweetsError(error)) }
                .asObservable()
        }
        
        static func toogleLikeTweet(id: String, index: Int) -> Observable<TweetsState.Event> {
            return TweetServiceType.toogleLikeTweet(id: id)
                .asObservable()
                .map { .onToogledLikeTweet(index) }
                .catchError { error in .just(.onToogleLikeTweetError(index, error)) }
                .startWith(.onTooglingLikeTweet(index))
        }
    }
}
