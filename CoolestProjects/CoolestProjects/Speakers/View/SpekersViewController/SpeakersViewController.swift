//
//  SpeakersViewController.swift
//  CoolestProjects
//
//  Created by BooRanger on 05/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import UIKit

class SpeakersViewController: BaseViewController {
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
            
            let speakersViewModel = SpeakersViewModel(speakers:speakers! as NSArray)
            self.viewModel = speakersViewModel
            
        
        };
    }
    
    
    func setupTableView() {
        tableView.estimatedRowHeight = 400.0;
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.register(UINib.init(nibName: "SpeakerTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "speakerCell")
        
    }
    
    override func setupNavigationBar() {
        navigationItem.title = NSLocalizedString("navbar.title",tableName: "Speakers", comment: "")
     
        super.setupNavigationBar()
    }

}


extension SpeakersViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let viewModel = self.viewModel {
            return viewModel.tableViewData!.count

        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let component = viewModel!.tableViewData![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: component.componentIdentifier, for: indexPath)
        
       
        let speakerCell = cell as! SpeakerTableViewCell
        speakerCell.displayViewModel(component)
    
        
        return cell
    }
    
}
