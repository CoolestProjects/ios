//
//  SpeakersViewController.swift
//  CoolestProjects
//
//  Created by BooRanger on 05/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import UIKit

class SpeakersViewController: UIViewController {
    var viewModel : SpeakersViewModel? { didSet {
            self.tableView.reloadData()
        }}
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getSpeakers()
        setupTableView()
        setupNavigationBar()
    }
    
    func getSpeakers() {
        let firbaseService = CPAFirebaseDefaultService()
        
        firbaseService.getSpeakersWithCompletionBlock { (speakers, error) in
            
            let speakersViewModel = SpeakersViewModel(speakers:speakers!)
            self.viewModel = speakersViewModel
            
        
        };
        
    }
    
    
    func setupTableView() {
        tableView.estimatedRowHeight = 400.0;
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.registerNib(UINib.init(nibName: "SpeakerTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "speakerCell")
        
    }
    
    func setupNavigationBar() {
        //TODO: Viewmodel
        navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        navigationController?.navigationBar.translucent = false
        navigationItem.title = NSLocalizedString("navbar.title",tableName: "Speakers", comment: "")
        navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: AppColors.yellowColor
        ]
        
    
    }

}


extension SpeakersViewController : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let viewModel = self.viewModel {
            return viewModel.tableViewData!.count

        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let component = viewModel!.tableViewData![indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(component.componentIdentifier, forIndexPath: indexPath)
        
       
        let speakerCell = cell as! SpeakerTableViewCell
        speakerCell.displayViewModel(component)
    
        
        return cell
    }
    
}
