//
//  TweetService.swift
//  RxFeedbackTableView
//
//  Created by luojie on 2017/12/23.
//  Copyright © 2017年 LuoJie. All rights reserved.
//

import Foundation
import RxSwift


enum TweetService {
    
    static func tweets() -> Single<[Tweet]> {
        return Single.just([
            Tweet(
                title: "Hallo Beeth0ven 0",
                content: "It's a long time since we last meet.",
                liked: false
            ),
            Tweet(
                title: "Hallo Beeth0ven 1",
                content: "It's a long time since we last meet.",
                liked: false
            ),
            Tweet(
                title: "Hallo Beeth0ven 2",
                content: "It's a long time since we last meet.",
                liked: false
            )
            ])
    }
}
