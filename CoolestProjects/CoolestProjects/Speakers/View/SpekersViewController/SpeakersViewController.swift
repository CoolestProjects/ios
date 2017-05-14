//
//  SpeakersViewController.swift
//  CoolestProjects
//
//  Created by BooRanger on 05/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import UIKit

class SpeakersViewController: BaseViewController {
    
    let deepLinkDataIdentifier = "identifier"
    
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
            
            self.handleDeepLink()
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
        if let deepLinkId = deeplinkData[deepLinkDataIdentifier] {
            
            if let deeplinkViewModel = findFirstModelForIdentifier(deepLinkId: deepLinkId) {
                
                if let index = findIndexForViewModel(viewModel: deeplinkViewModel) {
                    
                    let indexPath = IndexPath(item: index, section: 0)
                    self.tableView.scrollToRow(at: indexPath , at: UITableViewScrollPosition.middle, animated: true)
                }
            }
        }
    }
    
    func findFirstModelForIdentifier(deepLinkId: String) -> SpeakerViewModel? {
        return self.viewModel?.tableViewData?.filter({ (speaker) -> Bool in
            (speaker.name?.contains(deepLinkId.uppercased()))!
        }).first
    }
    
    func findIndexForViewModel(viewModel: SpeakerViewModel) -> Int? {
        return self.viewModel?.tableViewData?.index(where: { (model) -> Bool in
            model.name == viewModel.name
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
