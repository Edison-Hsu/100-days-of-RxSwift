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
import RxDataSources

class ViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!

    let disposeBag = DisposeBag()
    
    let items = Observable.just([
        SectionModel(model: "B", items: [
            "Barbara Cole",
            "Barbara Cooper",
            "Barbara Diaz",
            "Barbara Edwards",
            "Barbara Garcia",
            "Barbara Gray",
            "Barbara Griffin",
            "Barbara Hill",
            "Barbara Howard",
            "Barbara Hughes"
            ]),
        SectionModel(model: "C", items: [
            "Carol Lopez", "Carol Lopez"
            ]),
        SectionModel(model: "E", items: [
            "Elizabeth Jenkins", "Elizabeth Kelly"
            ]),
        SectionModel(model: "H", items: ["Helen Anderson", "Helen Bailey", "Helen Cole", "Helen Cox"]),
        SectionModel(model: "J", items: ["James Anderson", "James Barnes", "James Bell"]),
        SectionModel(model: "K", items: ["Karen Green", "Karen Jenkins", "Karen Jones", "Karen Jordan"]),
        SectionModel(model: "L", items: ["Linda Taylor", "Linda Taylor", "Linda Torres", "Linda West", "Lisa Brooks"]),
        SectionModel(model: "M", items: ["Margaret Bell", "Margaret Coleman", "Margaret Cox", "Margaret Foster"]),
        SectionModel(model: "R", items: ["Robert Clark", "Robert Coleman", "Robert Cook", "Robert Cook"]),
        SectionModel(model: "S", items: ["Susan Fisher", "Susan Ford", "Susan Ford", "Susan Hernandez", "Susan Howard"]),
        ])
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataSource = self.dataSource
        
        dataSource.configureCell = { (_, tv, indexPath, element) in
            let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = element
            return cell
        }
        
        items.bind(to: tableview.rx.items(dataSource: dataSource))
            .addDisposableTo(disposeBag)
        
        _ = tableview.rx.setDelegate(self)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableview.isEditing = editing
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "header")
        cell!.textLabel?.text = dataSource[section].model
        return cell
    }

}
