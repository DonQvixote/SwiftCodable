//
//  ViewController.swift
//  LuggageScanner
//
//  Created by 夏语诚 on 2018/7/10.
//  Copyright © 2018年 Banana. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    
    lazy var fetchedReultsController: NSFetchedResultsController<NSFetchRequestResult> = {
       let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Passenger")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "familyName", ascending: true), NSSortDescriptor(key: "givenName", ascending: true)]
        fetchRequest.relationshipKeyPathsForPrefetching = ["Luggage"]
        
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: mainContext(), sectionNameKeyPath: nil, cacheName: nil)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Passenger"
        
        do {
            try self.fetchedReultsController.performFetch()
        } catch {
            print(error)
        }
        
        self.tableView.reloadData()
        self.tableView.tableFooterView = UIView(frame: .zero)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.fetchedReultsController.sections!.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedReultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let passenger = self.fetchedReultsController.object(at: indexPath) as! Passenger
        
        cell.textLabel?.text = "\(passenger.givenName)\(passenger.familyName)"
        cell.detailTextLabel?.text = "Bags: \(passenger.luggage?.count ?? 0)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.fetchedReultsController.sections![section].name
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.fetchedReultsController.sectionIndexTitles
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return self.fetchedReultsController.section(forSectionIndexTitle: title, at: index)
    }

}

