//
//  ProjectsFilterOptionsViewController.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 06/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation
import UIKit

class ProjectsFilterOptionsViewController : UITableViewController {
    
    @IBOutlet weak var resetButton: UIBarButtonItem!
    @IBOutlet weak var applyButton: UIBarButtonItem!
    
    var filterOptions = [FilterOptionGroup]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attributes = [
            NSFontAttributeName: AppFonts.navigationBarTitle,
            NSForegroundColorAttributeName: AppColors.yellowColor]
        
        resetButton.setTitleTextAttributes(attributes, forState: .Normal)
        applyButton.setTitleTextAttributes(attributes, forState: .Normal)
        
        tableView.tableFooterView = UIView()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return filterOptions.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterOptions[section].options.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("filterOptionCell", forIndexPath: indexPath)
        let option = filterOptions[indexPath.section].options[indexPath.row]
        
        cell.textLabel?.text = NSLocalizedString(option.name, tableName: "Projects", comment: "")
        cell.accessoryType = option.selected ? .Checkmark : .None
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let currentValue = filterOptions[indexPath.section].options[indexPath.row].selected
        filterOptions[indexPath.section].options[indexPath.row].selected = !currentValue
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NSLocalizedString(filterOptions[section].category, tableName: "Projects", comment: "")
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = AppFonts.tableHeaderTitle
    }
    
    @IBAction func reset(sender: AnyObject) {
        // TODO: mutable??
        filterOptions = filterOptions.map({ (filterOptionGroup) -> FilterOptionGroup in
            FilterOptionGroup(category: filterOptionGroup.category, options: filterOptionGroup.options.map({ (filterOption) -> FilterOption in
                FilterOption(name: filterOption.name, selected: true)
            }))
        })
        
        tableView.reloadData()
        
        performSegueWithIdentifier("dismissFilterOptions", sender: self)
    }
    
    @IBAction func apply(sender: AnyObject) {
        performSegueWithIdentifier("dismissFilterOptions", sender: self)
    }
    
}
