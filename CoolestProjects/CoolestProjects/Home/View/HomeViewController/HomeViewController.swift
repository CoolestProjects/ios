//
//  HomeViewController.swift
//  CoolestProjects
//
//  Created by Valentino Gattuso on 02/06/2016.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

let SponsorBoxHeight: CGFloat = 300.0

class HomeViewController : BaseViewController, CLLocationManagerDelegate {
    let locMgr = CLLocationManager()
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
        locMgr.desiredAccuracy = kCLLocationAccuracyBest
        
        locMgr.requestAlwaysAuthorization()
        
        locMgr.startUpdatingLocation()
        
        locMgr.delegate = self
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
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.titleView = UIImageView(image: UIImage(named: "coolest-project-logo"))
    }
    
    func setupTable() {
        tableHeaderView.configure(with: (viewModel.headerTitle, viewModel.headerBody))
        tableView.tableHeaderView = tableHeaderView
        tableView.tableFooterView = tableFooterView
        tableView.estimatedRowHeight = 300.0;
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.register(UINib.init(nibName: "InfoBoxTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "infoBox")
        tableView.register(UINib.init(nibName: "SponsorBoxTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "sponsorBox")
    }
    
    func createViewMask(_ size: CGSize, startGradientAt start: Float, endGradientAt end: Float) -> CALayer {
        let mask = CAGradientLayer()
        mask.anchorPoint = CGPoint.zero
        mask.startPoint = CGPoint(x: 0.5, y: 0.0)
        mask.endPoint = CGPoint(x: 0.5, y: 1.0)
        mask.colors = [UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.white.cgColor]
        mask.locations = [NSNumber(value: 0.0 as Float), NSNumber(value: start/Float(size.height) as Float), NSNumber(value: end/Float(size.height) as Float), NSNumber(value: 1.0 as Float)]
        mask.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height);
        return mask
    }
    
    func forceTableViewLayoutPhase() {
        tableView.setNeedsLayout()
        tableView.layoutIfNeeded()
    }
    
    func updateTableHeaderFrame() {
        let minTableHeaderViewHeight = calculateMinTableHeaderViewHeight()
        let availableSpace = tableView.bounds.height - SponsorBoxHeight
        tableHeaderView.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: max(minTableHeaderViewHeight, availableSpace))
        tableView.tableHeaderView = tableHeaderView
    }
    
    func updateTableFooterFrame() {
        tableFooterView.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 100.0)
        tableView.tableFooterView = tableFooterView
    }
    
    func calculateMinTableHeaderViewHeight() -> CGFloat {
        tableHeaderView.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 2000.0)
        tableHeaderView.setNeedsLayout()
        tableHeaderView.layoutIfNeeded()
        return tableHeaderView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
    }
    
}

extension HomeViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let component = viewModel.tableViewData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: component.componentIdentifier, for: indexPath)
        
        // TODO: try to improve using better generics or protocol oriented data sources
        if (component is InfoBox) {
            let infoBox = component as! InfoBox
            let infoBoxCell = cell as! InfoBoxTableViewCell
            infoBoxCell.configure(with: infoBox)
        }
        
        if (component is SponsorBox) {
            let sponsorBox = component as! SponsorBox
            let sponsorBoxCell = cell as! SponsorBoxTableViewCell
            sponsorBoxCell.configure(with: sponsorBox)
        }
        
        return cell
    }
    
}

