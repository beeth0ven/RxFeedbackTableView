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
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = nil
        tableView.delegate = nil
        
        Observable.just([0, 1, 2, 4])
            .bind(to: tableView.rx.items(cellIdentifier: "UITableViewCell")) { element, index, cell  in
                cell.textLabel?.text = element.description
            }
            .disposed(by: disposeBag)
    }
}

