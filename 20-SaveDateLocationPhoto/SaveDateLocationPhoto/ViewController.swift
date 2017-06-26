//
//  ViewController.swift
//  SaveDateLocationPhoto
//
//  Created by 徐 栋栋 on 08/10/2016.
//  Copyright © 2016 EdisonHsu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class Item {
    let image:UIImage
    let date:String
    let content:String
    let location:String
    
    init(image: UIImage, date: String, content: String, location: String) {
        self.image = image
        self.date = date
        self.content = content
        self.location = location
    }
}

protocol TableViewDelegate: class {
    func addItem(item: Item)
}

class ViewController: UIViewController, TableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    let items = Variable(Array<Item>())
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: TableViewCell.self)) { (row, element, cell) in
                cell.picView.image = element.image
                cell.dateLabel.text = element.date
                cell.contentText.text = element.content
                cell.locationLabel.text = element.location
            }
            .addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination
        let vc:AddPostViewController = navigationController as! AddPostViewController
        vc.delegate = self
    }

    func addItem(item: Item) {
        self.items.value.insert(item, at: 0)
    }

}

