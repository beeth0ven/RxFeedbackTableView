//
//  ViewController.swift
//  RxFeedbackTableView
//
//  Created by luojie on 2017/12/23.
//  Copyright © 2017年 LuoJie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TableViewController: UITableViewController {
    
    private typealias AsyncEvent = TweetsState.Event.Async<TweetService>
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = nil
        tableView.delegate = nil
        
        let _state = ReplaySubject<TweetsState>.create(bufferSize: 1)
        
        let toogleLikeTweetTrigger = PublishRelay<Int>()
        
        let toogleLikeTweetEvents = toogleLikeTweetTrigger
            .withLatestFrom(_state) { ($0, $1) }
            .flatMap { (params) -> Observable<TweetsState.Event> in
                let (index, state) = params
                let tweetState = state.tweetStates[index]
                if tweetState.isToogleLiking {
                    return .empty()
                }
                return AsyncEvent.toogleLikeTweet(id: tweetState.tweet.id, index: index)
        }
        
        let getTweetsEvent = AsyncEvent.getTweets()
        
        let events = Observable.merge(
            getTweetsEvent,
            toogleLikeTweetEvents
        )
        
        let state = events
            .scan(TweetsState.empty, accumulator: TweetsState.reduce)
            .startWith(.empty)
            .do(onNext: _state.onNext)
            .asDriver(onErrorJustReturn: .empty)
            .debug("TweetsState")
        
        state.map { $0.tweetStates }
            .drive(tableView.rx.items(cellIdentifier: "TweetTableViewCell")) { (index, tweetState, cell: TweetTableViewCell)  in
                let (tweet, isToogleLiking) = tweetState
                cell.headlineLabel.text = tweet.title
                cell.bodyLabel.text = tweet.content
                let buttonTitle = isToogleLiking ? "..." : tweet.liked.description
                cell.likeButton.setTitle(buttonTitle, for: .normal)
                
                cell.likeButton.rx.tap
                    .subscribe(onNext: {
                        toogleLikeTweetTrigger.accept(index)
                    })
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
    }
}

