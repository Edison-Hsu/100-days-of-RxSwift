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
        
        let dataSource = setupDataSource()
        
        items
            .bindTo(tableview.rx_itemsWithDataSource(dataSource))
            .addDisposableTo(disposeBag)
        
        tableview.rx_setDelegate(self)
    }
    
    func setupDataSource() -> RxTableViewSectionedReloadDataSource<SectionModel<String, String>> {
        dataSource.configureCell = { (_, tv, indexPath, element) in
            let cell = tv.dequeueReusableCellWithIdentifier("Cell")!
            cell.textLabel?.text = element
            return cell
        }
        
        dataSource.sectionForSectionIndexTitle = { (datasource, title, index) -> Int in
            return index
        }
        
        dataSource.sectionIndexTitles = { ds -> [String]? in
            return ds.sectionModels.map { $0.model }
        }
        
        return dataSource
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableview.editing = editing
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCellWithIdentifier("header")
        cell!.textLabel?.text = dataSource.sectionAtIndex(section).model
        return cell
    }

}

