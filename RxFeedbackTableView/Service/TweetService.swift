//
//  TweetService.swift
//  RxFeedbackTableView
//
//  Created by luojie on 2017/12/23.
//  Copyright © 2017年 LuoJie. All rights reserved.
//

import Foundation
import RxSwift

protocol TweetServiceProtocol {
    static func tweets() -> Single<[Tweet]>
    static func toogleLikeTweet(id: String) -> Single<Void>
}

enum TweetService: TweetServiceProtocol {
    
    static func tweets() -> Single<[Tweet]> {
        return Single.just([
            Tweet(
                id: "000",
                title: "Hallo Beeth0ven 0",
                content: "It's a long time since we last meet.",
                liked: false
            ),
            Tweet(
                id: "001",
                title: "Hallo Beeth0ven 1",
                content: "It's a long time since we last meet.",
                liked: false
            ),
            Tweet(
                id: "002",
                title: "Hallo Beeth0ven 2",
                content: "It's a long time since we last meet.",
                liked: false
            )
            ])
            .delay(2, scheduler: MainScheduler.instance)
    }
    
    static func toogleLikeTweet(id: String) -> Single<Void> {
        return Single.just(())
            .delay(2, scheduler: MainScheduler.instance)
    }
}
