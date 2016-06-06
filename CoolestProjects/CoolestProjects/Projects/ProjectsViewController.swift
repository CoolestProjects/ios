//
//  ProjectsViewController.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 06/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation
import UIKit

struct Project {
    var name = ""
    var category = ""
    var projectDescription = ""
    var photoUrl: String?
    var projectUrl: String?
}

class ProjectsViewController : BaseViewController {
    
    @IBOutlet weak var projectsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var projects = [Project]()
    var filteredProjects = [Project]()
    
    var filterOptions = [FilterOptionGroup(
        category: "project-categories",
        options: [
            FilterOption(name: "scratch-red", selected: true),
            FilterOption(name: "scratch-green", selected: true),
            FilterOption(name: "websites", selected: true),
            FilterOption(name: "games", selected: true),
            FilterOption(name: "hardware", selected: true),
            FilterOption(name: "evolution", selected: true)
        ])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = .None
        
        setupNavigationBar()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ProjectsViewController.dismissKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    func setupNavigationBar() {
        title = NSLocalizedString("title", tableName: "Projects", comment: "")
        
        navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        navigationController?.navigationBar.translucent = false
        navigationController?.navigationBar.titleTextAttributes = [
            NSFontAttributeName: AppFonts.navigationBarTitle,
            NSForegroundColorAttributeName: AppColors.yellowColor
        ]
        
        searchBar.placeholder = NSLocalizedString("searchBar.placeholder", tableName: "Projects", comment: "")
    }
    
    @IBAction func showFilterOptions(sender: UIButton) {
        performSegueWithIdentifier("showFilterOptions", sender: self)
    }
    
    @IBAction func unwindFromFilterOptions(segue:UIStoryboardSegue) {
        if segue.identifier == "dismissFilterOptions" {
            if let filterViewController = segue.sourceViewController as? ProjectsFilterOptionsViewController {
                filterOptions = filterViewController.filterOptions
                // TODO: filter and reload
            }
        }        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showFilterOptions" {
            if let nc = segue.destinationViewController as? UINavigationController {
                if let filterViewController = nc.viewControllers.first as? ProjectsFilterOptionsViewController {
                    filterViewController.filterOptions = filterOptions
                }
            }
        }
    }
        
    func filterContentForSearchText(searchText: String?) {
        if let searchText = searchText {
            filteredProjects = projects.filter({( project : Project) -> Bool in
                return project.name.lowercaseString.containsString(searchText.lowercaseString)
            })
        } else {
            filteredProjects = projects
        }
        
        projectsTableView.reloadData()
    }
    
    func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    
}

extension ProjectsViewController : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProjects.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell() //tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let project = filteredProjects[indexPath.row]
        return cell
    }
    
}

extension ProjectsViewController: UISearchBarDelegate {
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filterContentForSearchText(searchBar.text)
    }
}

