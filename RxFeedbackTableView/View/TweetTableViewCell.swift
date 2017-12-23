//
//  TweetTableViewCell.swift
//  RxFeedbackTableView
//
//  Created by luojie on 2017/12/23.
//  Copyright © 2017年 LuoJie. All rights reserved.
//

import UIKit
import RxSwift

class TweetTableViewCell: UITableViewCell {

    var disposeBag = DisposeBag()

    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}
