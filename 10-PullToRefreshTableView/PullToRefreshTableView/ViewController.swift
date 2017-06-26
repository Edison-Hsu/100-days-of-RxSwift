//
//  ViewController.swift
//  PullToRefreshTableView
//
//  Created by 徐栋栋 on 4/16/16.
//  Copyright © 2016 edison. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    fileprivate let disposeBag = DisposeBag()
    fileprivate let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items = Variable([
            "Mike",
            "Apples",
            "Ham",
            "Eggs"
            ])
        
        let items2 = [
            "Fish",
            "Carrots",
            "Mike",
            "Apples",
            "Ham",
            "Eggs",
            "Bread",
            "Chiken",
            "Water"
            ]
        
        
        items.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self), curriedArgument: { (row, element, cell) in
                cell.textLabel?.text = element
            }).addDisposableTo(disposeBag)
        
        refreshControl.rx.controlEvent(.valueChanged)
            .subscribe(onNext: {
                _ in
                items.value = items2
                self.refreshControl.endRefreshing()
            }).addDisposableTo(disposeBag)
        
        tableView.addSubview(refreshControl)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

