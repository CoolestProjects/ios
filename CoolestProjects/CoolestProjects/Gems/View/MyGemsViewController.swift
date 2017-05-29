//
//  MyGemsViewController.swift
//  CoolestProjects
//
//  Created by Rich on 29/05/2017.
//  Copyright © 2017 coderdojo. All rights reserved.
//

import UIKit

class MyGemsViewController: UIViewController {
    
    @IBOutlet weak var tableView : UITableView?
    @IBOutlet weak var noGemsLabel : UILabel?
    
    let viewModel = MyGemsViewModel(beaconItems: [RegionMessageInteraction(json: ["regionId":"123", "messageVersionId":"1", "timestamp":TimeInterval(), "title":"test", "message":"Testing" ])!])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "MY GEMS"
        
        self.edgesForExtendedLayout = []
        
        self.navigationController?.isNavigationBarHidden = false
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(MapZoomViewController.donePressed)), animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.viewModel.shouldShowEmptyState() {
            self.tableView?.isHidden = true
        } else {
            self.tableView?.isHidden = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.noGemsLabel?.setTypedText("NO GEMS YET \n TIME TO FIND SOME \n 🤔")
    }
    
    func donePressed() {
        self.dismiss(animated: true, completion: nil)
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension MyGemsViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = viewModel.items[indexPath.row]
        
        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "cell")
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = UIColor.white
        cell.detailTextLabel?.textColor = UIColor.white
        cell.textLabel?.text = model.title
        cell.detailTextLabel?.text = model.message
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
}

extension UILabel {
    
    func setTypedText(_ text: String) {
    
        self.setTypedText(text, index: 1)
    }
    
    private func setTypedText(_ text: String, index: Int) {
        
        guard index <= text.characters.count && self.superview != nil else {return}
        
        let textToDisplay = text.substring(to: text.index(text.startIndex, offsetBy: index))
        
        self.text = textToDisplay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05, execute: {
            self.setTypedText(text, index: index + 1)
        })
    }
}
