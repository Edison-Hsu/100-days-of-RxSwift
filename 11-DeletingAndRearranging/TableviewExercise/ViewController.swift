//
//  ViewController.swift
//  TableviewExercise
//
//  Created by 徐 栋栋 on 4/28/16.
//  Copyright © 2016 EdisonHsu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        let items = Variable([
            "Mike",
            "Apples",
            "Ham",
            "Eggs"
        ])
        
        
        items
            .asObservable()
            .bindTo(tableview.rx_itemsWithCellIdentifier("Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = element
            }
            .addDisposableTo(disposeBag)
        
        tableview
            .rx_itemDeleted
            .subscribeNext { indexPath in
                items.value.removeAtIndex(indexPath.row)
            }
            .addDisposableTo(disposeBag)
        
        tableview
            .rx_itemMoved
            .subscribeNext { fromIndexPath, toIndexPath in
                let ele = items.value.removeAtIndex(fromIndexPath.row)
                items.value.insert(ele, atIndex: toIndexPath.row)
            }
            .addDisposableTo(disposeBag)
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableview.editing = editing
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

