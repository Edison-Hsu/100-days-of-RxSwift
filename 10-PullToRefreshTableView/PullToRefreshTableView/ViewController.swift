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
    private let disposeBag = DisposeBag()
    private let refreshControl = UIRefreshControl()
    
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
        
        items
            .asObservable()
            .bindTo(tableView.rx_itemsWithCellIdentifier("Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = element
            }
            .addDisposableTo(disposeBag)
        
        refreshControl.rx_controlEvent(.ValueChanged)
            .subscribeNext { _ in
                items.value = items2
                self.refreshControl.endRefreshing()
                
            }.addDisposableTo(disposeBag)
        
        tableView.addSubview(refreshControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

