//
//  HomeViewController.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 02/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation
import UIKit

let SponsorBoxHeight: CGFloat = 300.0

class HomeViewController : BaseViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    // TODO: better nib loading
    let tableHeaderView = HomeTableHeaderView.headerView()!
    let tableFooterView = HomeTableFooterView.footerView()!
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupMask()
        forceTableViewLayoutPhase()
        updateTableHeaderFrame()
        updateTableFooterFrame()
    }
    
    func setupUI() {
        setupBackgroundImage()
        setupNavigationBar()
        setupTable()
    }
    
    func setupBackgroundImage() {
        backgroundImage.image = UIImage(named: "home-bg")
        overlayView.backgroundColor = AppColors.lightOverlayColor
    }
    
    func setupMask() {
        wrapperView.layer.mask = createViewMask(wrapperView.frame.size, startGradientAt:68.0, endGradientAt:72.0)
    }
    
    override func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.titleView = UIImageView(image: UIImage(named: "coolest-project-logo"))
    }
    
    func setupTable() {
        tableHeaderView.configure(withItem: (viewModel.headerTitle, viewModel.headerBody))
        tableView.tableHeaderView = tableHeaderView
        tableView.tableFooterView = tableFooterView
        tableView.estimatedRowHeight = 300.0;
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.registerNib(UINib.init(nibName: "InfoBoxTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "infoBox")
        tableView.registerNib(UINib.init(nibName: "SponsorBoxTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "sponsorBox")
    }
    
    func createViewMask(size: CGSize, startGradientAt start: Float, endGradientAt end: Float) -> CALayer {
        let mask = CAGradientLayer()
        mask.anchorPoint = CGPointZero
        mask.startPoint = CGPointMake(0.5, 0.0)
        mask.endPoint = CGPointMake(0.5, 1.0)
        mask.colors = [UIColor.clearColor().CGColor, UIColor.clearColor().CGColor, UIColor.whiteColor().CGColor, UIColor.whiteColor().CGColor]
        mask.locations = [NSNumber(float: 0.0), NSNumber(float: start/Float(size.height)), NSNumber(float: end/Float(size.height)), NSNumber(float: 1.0)]
        mask.frame = CGRectMake(0, 0, size.width, size.height);
        return mask
    }
    
    func forceTableViewLayoutPhase() {
        tableView.setNeedsLayout()
        tableView.layoutIfNeeded()
    }
    
    func updateTableHeaderFrame() {
        let minTableHeaderViewHeight = calculateMinTableHeaderViewHeight()
        let availableSpace = CGRectGetHeight(tableView.bounds) - SponsorBoxHeight
        tableHeaderView.frame = CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), max(minTableHeaderViewHeight, availableSpace))
        tableView.tableHeaderView = tableHeaderView
    }
    
    func updateTableFooterFrame() {
        tableFooterView.frame = CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), CGRectGetHeight(tableFooterView.frame))
        tableView.tableFooterView = tableFooterView
    }
    
    func calculateMinTableHeaderViewHeight() -> CGFloat {
        tableHeaderView.frame = CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), 2000.0)
        tableHeaderView.setNeedsLayout()
        tableHeaderView.layoutIfNeeded()
        return tableHeaderView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
    }
    
}

extension HomeViewController : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableViewData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let component = viewModel.tableViewData[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(component.componentIdentifier, forIndexPath: indexPath)
        
        // TODO: try to improve using better generics or protocol oriented data sources
        if (component is InfoBox) {
            let infoBox = component as! InfoBox
            let infoBoxCell = cell as! InfoBoxTableViewCell
            infoBoxCell.configure(withItem: infoBox)
        }
        
        if (component is SponsorBox) {
            let sponsorBox = component as! SponsorBox
            let sponsorBoxCell = cell as! SponsorBoxTableViewCell
            sponsorBoxCell.configure(withItem: sponsorBox)
        }
        
        return cell
    }
    
}

