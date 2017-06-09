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

class HomeViewController : BaseViewController {

    @IBOutlet weak var statusBarBackgroundView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    // TODO: better nib loading
    let tableHeaderView = PageHeaderView.pageHeaderView()!
    let tableFooterView = HomeTableFooterView.footerView()!
    let viewModel = HomeViewModel()
    var beaconNotificationsManager: BeaconNotificationsManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beaconNotificationsManager = BeaconNotificationsManager.sharedInstance
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        updateTableviewIfBleNowEnabled()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        forceTableViewLayoutPhase()
        updateTableHeaderFrame()
        updateTableFooterFrame()
    }
    
    func updateTableviewIfBleNowEnabled() {
        if(isBleEnabledAndMonitoring() != viewModel.isBluetoothEnabled()) {
            viewModel.setBluetoothEnabled(bluetoothEnabled: isBleEnabledAndMonitoring())
            tableView.reloadData()
        }
    }
    
    func setupUI() {
        setupTable()
    }
    
    func isBleEnabledAndMonitoring() -> Bool {
        return !beaconNotificationsManager.isBLEPoweredOff && beaconNotificationsManager.isAuthorizedForMonitoring
    }
   
    func setupTable() {        
        tableView.tableHeaderView = tableHeaderView
        tableView.tableFooterView = tableFooterView
        tableView.estimatedRowHeight = 300.0;
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(PageHeaderTableViewCell.self, forCellReuseIdentifier: "pageHeader")
        registerTableViewCellNamed(nibName: "SponsorBoxTableViewCell", reuseIdentifier: "sponsorBox")
        registerTableViewCellNamed(nibName: "ContentTableViewCell", reuseIdentifier: "contentCell")
        registerTableViewCellNamed(nibName: "BlurbTableViewCell", reuseIdentifier: "blurbCell")
        registerTableViewCellNamed(nibName: "BluetoothBoxTableViewCell", reuseIdentifier: "bluetoothBox")
    }
    
    func registerTableViewCellNamed(nibName: String, reuseIdentifier: String) {
        tableView.register(UINib.init(nibName: nibName, bundle: Bundle.main), forCellReuseIdentifier: reuseIdentifier)
    }
    
    func forceTableViewLayoutPhase() {
        tableView.setNeedsLayout()
        tableView.layoutIfNeeded()
    }
    
    func updateTableHeaderFrame() {
        let minTableHeaderViewHeight = calculateMinTableHeaderViewHeight()
        tableHeaderView.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height:minTableHeaderViewHeight)
        tableView.tableHeaderView = tableHeaderView
    }
    
    func updateTableFooterFrame() {
        tableFooterView.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 100.0)
        tableView.tableFooterView = tableFooterView
    }
    
    func calculateMinTableHeaderViewHeight() -> CGFloat {
        tableHeaderView.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 1600.0)
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
        cell.selectionStyle = .none
        
        // TODO: try to improve using better generics or protocol oriented data sources
        
        if (component is BluetoothBox) {
            let bluetoothBoxCell = cell as! BluetoothBoxTableViewCell
            let content = component as! BluetoothBox
            bluetoothBoxCell.configure(with: content)
        }
        
        if (component is SponsorBox) {
            let sponsorBox = component as! SponsorBox
            let sponsorBoxCell = cell as! SponsorBoxTableViewCell
            sponsorBoxCell.configure(with: sponsorBox)
        }
        
        if (component is ContentViewModel) {
            let content = component as! ContentViewModel
            let contentCell = cell as! ContentTableViewCell
            contentCell.configure(with: content);
        }
        
        if (component is BlurbBox) {
            let blurbBox = component as! BlurbBox
            let contentCell = cell as! BlurbTableViewCell
            contentCell.configure(with: blurbBox);
        }

        return cell
    }
    
}

extension HomeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let component = viewModel.tableViewData[indexPath.row]
        
        if (component is BluetoothBox) {
            self.performSegue(withIdentifier: "showMyGems", sender: nil)
        }
        
        if (component is SponsorBox) {
            self.performSegue(withIdentifier: "showSponsors", sender: nil)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var adjustedOffset = scrollView.contentOffset.y
        adjustedOffset = max(0, adjustedOffset)
        adjustedOffset = min(adjustedOffset, 140)
        let alpha = adjustedOffset / 140
        statusBarBackgroundView.alpha = alpha
    }
}

