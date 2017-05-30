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
    
    let colorChoice = [UIColor.red, UIColor.blue, UIColor.green, UIColor.brown, UIColor.yellow]
    
    var viewModel = MyGemsViewModel(beaconItems : [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpNavigationBar()
        self.edgesForExtendedLayout = []
        
        let regionMessageInteractionStore = RegionMessageInteractionStoreImpl.init()
        
        viewModel = MyGemsViewModel(beaconItems: regionMessageInteractionStore.allInteractions())
        
        registerTableViewCellNamed(nibName: "GemTableViewCell", reuseIdentifier: "gemTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.viewModel.shouldShowEmptyState() {
            self.tableView?.isHidden = true
        } else {
            self.tableView?.isHidden = false
            self.noGemsLabel?.removeFromSuperview()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpNoGemsLabel()
    }
    
    func setUpNavigationBar() {
        self.title = "MY GEMS"
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(MapZoomViewController.donePressed)), animated: false)
    }
    
    func donePressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUpNoGemsLabel() {
        self.noGemsLabel?.setTypedText("NO GEMS YET \n TIME TO FIND SOME \n 🤔")
    }
}

extension MyGemsViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return cellForIndex(indexPath)
    }
    
    func cellForIndex(_ indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.items[indexPath.row]
        
        let cell = tableView?.dequeueReusableCell(withIdentifier: "gemTableViewCell") as! GemTableViewCell
        cell.titleLabel?.text = model.title
        cell.messageLabel?.text = model.message
        
        cell.setLabelTextColor(colorChoice[Int(arc4random())%colorChoice.endIndex])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func registerTableViewCellNamed(nibName: String, reuseIdentifier: String) {
        self.tableView?.register(UINib.init(nibName: nibName, bundle: Bundle.main), forCellReuseIdentifier: reuseIdentifier)
    }
}

extension MyGemsViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
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
