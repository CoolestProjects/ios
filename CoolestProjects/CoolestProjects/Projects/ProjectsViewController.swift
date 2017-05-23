//
//  ProjectsViewController.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 06/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation
import UIKit

class ProjectsViewController : BaseViewController {
    
    @IBOutlet weak var categoriesButton: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var projectsTableView: UITableView!
    
    
    var projects = [Project]()
    
//    var projects = [
//        Project(name: "Lightbulb", category: "null", projectDescription: "Get ideas, use ideas, show your ideas! We provide science orientated idea starters, which the user builds on to develop their own project. They can then share a video or picture of their project to the app, so that they can inspire more users.", coderdojo: "", deskNumber: ""),
//        Project(name: "ESC", category: "Scratch", projectDescription: "A story based superhero scroller.", coderdojo: "", deskNumber: ""),
//        Project(name: "Verbos en español - Spanish Verb Quiz", category: "Mobile", projectDescription: "Verbos en español is a simple quiz game that tests your knowledge of over 200 (and counting!) Spanish verbs. It picks a random question, and you simply tap on the correct answer out of four possible answers. You must answer 15 questions correctly to finish the quiz, and the number of questions that you have gotten wrong is displayed on the screen as well as the amount that you have gotten correct.", coderdojo: "", deskNumber: ""),
//        Project(name: "startups.coderdojo.xyz", category: "Websites", projectDescription: "Startups.coderdojo.xyz is a website which allows kids in coderdojo to get a website going for free. It lets them get a domain name ending in .coderdojo.xyz (It could be expanded to fit any domain). They can also write html with my online editor which makes it easy for beginners and they can have a  pre-programmed placeholder on their domain until they write a website.", coderdojo: "", deskNumber: ""),
//        Project(name: "Global Warming Quiz", category: "Games + Web Games", projectDescription: "The Global Warming Quiz is a game that explains children in the elementary school what global warming is, and what they can do to help the earth", coderdojo: "", deskNumber: ""),
//        Project(name: "Pi Connect", category: "Hardware", projectDescription: "this is a tabletop device with a 7@ touchscreen to teach kids to code with hardware and software in one package.", coderdojo: "", deskNumber: ""),
//        Project(name: "The Maze Game", category: "Evolution", projectDescription: "This is a game where you cannot touch the walls of the maze or else you will have to start the whole game again.", coderdojo: "", deskNumber: "")
//    ]
    
    var filteredProjectsByCategory = [Project]()
    
    var filteredProjects = [Project]()
    
    var filterOptions = [
            FilterOption(key: "scratch", value: "Scratch", selected: true),
            //FilterOption(key: "scratch-red", value: "Scratch Red", selected: true),
            //FilterOption(key: "scratch-green", value: "Scratch Green", selected: true),
            FilterOption(key: "mobile", value: "Mobile", selected: true),
            FilterOption(key: "websites", value: "Websites", selected: true),
            FilterOption(key: "games", value: "Games + Web Games", selected: true),
            FilterOption(key: "hardware", value: "Hardware", selected: true),
            FilterOption(key: "evolution", value: "Evolution", selected: true)
    ]
    
    let service = ProjectsService()
    
    let store = ProjectsStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupProjectsTableView()
        setupDismissKeyboardGestureRecognizer()
        
        loadProjectsFromStore()
        updateProjectsIfNeeded()
    }
    
    override func setupNavigationBar() {
        title = NSLocalizedString("title", tableName: "Projects", comment: "")
        
        searchBar.placeholder = NSLocalizedString("searchBar.placeholder", tableName: "Projects", comment: "")
        
        let buttonAttributes = [
            NSFontAttributeName: AppFonts.navigationBarButton,
            NSForegroundColorAttributeName: AppColors.darkTextColor
        ]
        
        categoriesButton.setTitleTextAttributes(buttonAttributes, for: .normal)
        
        super.setupNavigationBar()
    }
    
    func loadProjectsFromStore() {
        projects = store.readProjects()
        filteredProjectsByCategory = projects
        filteredProjects = filteredProjectsByCategory
    }
    
    func updateProjectsIfNeeded() {
        
        if store.cacheExpired() {
            print("fetching projects...")
            
            service.fetchProjects { [weak self] (result) in
                switch(result) {
                case .success:
                    // TODO: mhe
                    print("project fetch completed")
                    if let fetchedProjects = result.data() {
                        self?.projects = fetchedProjects
                        self?.filterProjectsBySelectedCategories()
                        self?.filterContentForSearchText(self?.searchBar.text)
                        self?.store.saveProjects(fetchedProjects)
                    }
                    
                case .failure:
                    print("project fetch failed: \(String(describing: result.error()))")
                }
                
            }
        } else {
            print("Skip projects update, using cached data...")
        }

    }
    
    func setupProjectsTableView() {
        projectsTableView.estimatedRowHeight = 180.0;
        projectsTableView.rowHeight = UITableViewAutomaticDimension;
    }
    
    func setupDismissKeyboardGestureRecognizer () {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ProjectsViewController.dismissKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
    }
        
    @IBAction func showFilterOptions(_ sender: AnyObject) {
        performSegue(withIdentifier: "showFilterOptions", sender: self)
    }
    
    @IBAction func unwindFromFilterOptions(_ segue:UIStoryboardSegue) {
        if segue.identifier == "dismissFilterOptions" {
            if let filterViewController = segue.source as? ProjectsFilterOptionsViewController {
                filterOptions = filterViewController.filterOptions
                filterProjectsBySelectedCategories()
                filterContentForSearchText(searchBar.text)
            }
        }        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFilterOptions" {
            if let nc = segue.destination as? UINavigationController {
                if let filterViewController = nc.viewControllers.first as? ProjectsFilterOptionsViewController {
                    filterViewController.filterOptions = filterOptions
                }
            }
        }
    }
    
    func filterProjectsBySelectedCategories() {
        let selectedCategories = filterOptions
            .filter({ (filterOption) -> Bool in
                filterOption.selected == true
            })
            .map { (filterOption) -> String in
                return filterOption.value
        }
        
        filteredProjectsByCategory = projects.filter({ (project) -> Bool in
            selectedCategories.contains(project.category)
        })
        
    }
        
    func filterContentForSearchText(_ searchText: String?) {
    
        if let searchText = searchText {
            if !searchText.isEmpty {
                filteredProjects = filteredProjectsByCategory.filter({ matchesQuery($0, query: searchText)})
            } else {
                filteredProjects = filteredProjectsByCategory
            }
        } else {
            filteredProjects = filteredProjectsByCategory
        }
        
        
        projectsTableView.reloadData()
    }
    
    func matchesQuery(_ project: Project, query: String) -> Bool {
        return project.name.localizedCaseInsensitiveContains(query) ||
            project.projectDescription.localizedCaseInsensitiveContains(query) ||
            project.coderdojo.localizedCaseInsensitiveContains(query)
    }
    
    func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    
}

extension ProjectsViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath) as! ProjectTableViewCell
        cell.configure(with: filteredProjects[indexPath.row])
        return cell
    }
    
}

extension ProjectsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContentForSearchText(searchBar.text)
    }
}

