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
    fileprivate let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        let items = Variable([
            "Mike",
            "Apples",
            "Ham",
            "Eggs"
        ])

        items.asObservable()
            .bind(to: tableview.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self), curriedArgument: { (row, element, cell) in
                cell.textLabel?.text = element
            }).addDisposableTo(disposeBag)
        
        tableview.rx.itemDeleted.subscribe(onNext: {
            indexPath in
            items.value.remove(at: indexPath.row)
        }).addDisposableTo(disposeBag)
        
        tableview.rx.itemMoved.subscribe(onNext: {
            fromIndexPath, toIndexPath in
            let ele = items.value.remove(at: fromIndexPath.row)
            items.value.insert(ele, at: toIndexPath.row)
        }).addDisposableTo(disposeBag)
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableview.isEditing = editing
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

