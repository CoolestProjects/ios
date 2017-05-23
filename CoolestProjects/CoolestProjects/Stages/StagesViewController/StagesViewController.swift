//
//  StagesViewController.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 05/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation
import UIKit

class StagesViewController : BaseViewController {
    
    @IBOutlet weak var speakersTableView: UITableView!
    @IBOutlet weak var summitCategoriesContainerView: UIView!
    
    let deepLinkStageIdentifier = "stage"
    
    var summitCategoriesSegmentedControl: UISegmentedControl!
    
    var firebaseService: CPAFirebaseDefaultService?
    
    var allSummits = [CPASummit]()
    
    var selectedSummitIndex = 0
    var selectedSpeakes = [CPASpeaker]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadContent()
    }
    
    func setupUI() {
        setupEdges()
        setupNavigationBar()
        setupTableView()
    }
    
    func loadContent() {
        firebaseService = CPAFirebaseDefaultService()
        firebaseService?.getSummitsWithCompletionBlock { [weak self] (summitList, error) in
            if let summitList = summitList {
                self?.allSummits = summitList
                self?.setupTabBarButtons()
                self?.selectSummit(atIndex: 0)
                self?.updateUI()
                self?.handleDeepLink()
            }
        }
    }
    
    func handleDeepLink() {
        guard let deepLinkStageId = deeplinkData[deepLinkStageIdentifier],
            let deepLinkId = deeplinkData[deepLinkDataIdentifier],
            let stageIndex = findIndexOfFirstStageForIdentifier(deepLinkStageId),
            let modelIndex = findIndexOfFirstModel(deepLinkId: deepLinkId, stageIndex: stageIndex)
            else {
                return
        }
        
        self.selectSummit(atIndex: stageIndex)
        self.updateUI()
        let indexPath = IndexPath(item: modelIndex, section: 0)
        speakersTableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.middle, animated: true)
    }
    
    func findIndexOfFirstModel(deepLinkId: String, stageIndex: Int) -> Int? {
        guard let speakers = allSummits[stageIndex].speakers as? [CPASpeaker]
            else {
                return nil
        }
        
        return speakers.index(where: { (speakerVm) -> Bool in
            if let name = speakerVm.name {
                return name.uppercased().contains(deepLinkId.uppercased())
            } else {
                return false
            }
        })
    }
    
    func findIndexOfFirstStageForIdentifier(_ deepLinkId: String) -> Int? {
        return allSummits.index(where: { (vm) -> Bool in
            if let name = vm.name {
                return name.uppercased().contains(deepLinkId.uppercased())
            } else {
                return false
            }
        })
    }
    
    func selectSummit(atIndex index: Int) {
        guard index < allSummits.count else { return }
        
        selectedSummitIndex = index
        summitCategoriesSegmentedControl.selectedSegmentIndex = index
        selectedSpeakes = allSummits[index].speakers as! [CPASpeaker]
    }
    
    func setupTabBarButtons() {
        
        let summitCategories = allSummits.map { (summit) -> String in
            summit.name
        }
                
        let style = NSMutableParagraphStyle()
        style.lineBreakMode = .byWordWrapping
        style.alignment = .center
        
        let normalStateAttributes = [
            NSFontAttributeName: AppFonts.tabBarFontSelected,
            NSForegroundColorAttributeName: AppColors.darkTextColor,
            NSParagraphStyleAttributeName: style
        ]
        
        let selectedStateAttributes = [
            NSFontAttributeName: AppFonts.tabBarFontSelected,
            NSForegroundColorAttributeName: AppColors.darkTextColor,
            NSParagraphStyleAttributeName: style
        ]
        
        UILabel.appearance(whenContainedInInstancesOf: [UISegmentedControl.self]).numberOfLines = 0
        
        summitCategoriesSegmentedControl = UISegmentedControl(items: summitCategories)
        summitCategoriesSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        summitCategoriesSegmentedControl.addTarget(self, action: #selector(StagesViewController.changeSummitCategory(_:)), for: .valueChanged);
        
        summitCategoriesSegmentedControl.setTitleTextAttributes(normalStateAttributes, for: .normal)
        summitCategoriesSegmentedControl.setTitleTextAttributes(selectedStateAttributes, for: .selected)
        
        summitCategoriesSegmentedControl.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        summitCategoriesSegmentedControl.setDividerImage(UIImage(), forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        summitCategoriesSegmentedControl.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .selected, barMetrics: .default)
        summitCategoriesSegmentedControl.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        summitCategoriesSegmentedControl.setBackgroundImage(UIImage(), for: .selected, barMetrics: .default)
        
        summitCategoriesContainerView.addSubview(summitCategoriesSegmentedControl)
        summitCategoriesContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[control]|",
            options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["control": summitCategoriesSegmentedControl]))
        summitCategoriesContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[control]|",
            options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["control": summitCategoriesSegmentedControl]))
    }
    
    func changeSummitCategory(_ sender: UISegmentedControl) {
        selectSummit(atIndex: summitCategoriesSegmentedControl.selectedSegmentIndex)
        updateUI()
    }
    
    func updateUI() {
        speakersTableView.reloadData()
    }
    
    func setupEdges() {
        edgesForExtendedLayout = []
    }
    
    override func setupNavigationBar() {
        title = NSLocalizedString("title", tableName: "Stages", comment: "")
        
        super.setupNavigationBar()
    }
    
    func setupTableView() {
        speakersTableView.estimatedRowHeight = 300.0;
        speakersTableView.rowHeight = UITableViewAutomaticDimension;
        speakersTableView.register(UINib.init(nibName: "StagesTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "speaker")
    }
}

extension StagesViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedSpeakes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = selectedSpeakes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "speaker", for: indexPath) as! StagesTableViewCell
        // TODO: better layout process
        cell.frame = CGRect(x: cell.frame.origin.x, y: cell.frame.origin.y, width: view.frame.width, height: cell.frame.height)
        cell.configure(with: item)
        return cell        
    }
    
}
