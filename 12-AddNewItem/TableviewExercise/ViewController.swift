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

class ViewController: UIViewController, DataEnteredDelegate {
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!

    let disposeBag = DisposeBag()
    
    let items = Variable([
        "Mike",
        "Apples",
        "Ham",
        "Eggs"
        ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        items.asObservable().bind(to: tableview.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self), curriedArgument: { (row, element, cell) in
            cell.textLabel?.text = element
        }).addDisposableTo(disposeBag)
        
        tableview.rx.itemDeleted.subscribe(onNext: {
            indexPath in
            self.items.value.remove(at: indexPath.row)
        }).addDisposableTo(disposeBag)
        
        tableview.rx.itemMoved.subscribe(onNext: {
             fromIndexPath, toIndexPath in
            let ele = self.items.value.remove(at: fromIndexPath.row)
            self.items.value.insert(ele, at: toIndexPath.row)
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondViewController = segue.destination as! SecondViewController
        secondViewController.delegate = self
    }
    
    func userDidEnterInformation(_ info: String) {
        items.value.append(info)
    }

}

