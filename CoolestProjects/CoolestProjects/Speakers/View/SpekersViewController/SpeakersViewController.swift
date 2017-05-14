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
            if let speakers = speakers {
                self.viewModel = SpeakersViewModel(speakers: speakers)
                self.handleDeepLink()
            }        
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
    
    func handleDeepLink() {
        guard let deepLinkId = deeplinkData[deepLinkDataIdentifier],
            let index = findIndexOfFirstModelForIdentifier(deepLinkId) else {
            return
        }

        let indexPath = IndexPath(item: index, section: 0)
        tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.middle, animated: true)
    }
    
    func findIndexOfFirstModelForIdentifier(_ deepLinkId: String) -> Int? {
        return viewModel?.tableViewData?.index(where: { (vm) -> Bool in
            if let name = vm.name {
                return name.contains(deepLinkId.uppercased())
            } else {
                return false
            }
        })
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
