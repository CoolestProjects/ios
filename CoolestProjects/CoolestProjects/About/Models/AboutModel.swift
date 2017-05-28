//
//  AboutModel.swift
//  CoolestProjects
//
//  Created by Natasha Cole on 28/05/2017.
//  Copyright © 2016 coderdojo. All rights reserved.
//

import Foundation

struct AboutModel: Component {
  
    var componentIdentifier: String = "AboutViewCell"
    var title: String
    var mapUrl: String
    init(title: String, mapUrl: String) {
        self.title = title
        self.mapUrl = mapUrl
    }
}

class AboutViewModel {
    
    var tableViewData = [Component]()
    let title: String
    
    init() {

        title = "About"
        loadAboutContent()
        tableViewData = [
            BlurbBox(title: NSLocalizedString("date.tilte", tableName: "Home", comment: "")),
            AboutModel(title: NSLocalizedString("About", tableName: "Maps", comment: ""), mapUrl: "https://firebasestorage.googleapis.com/v0/b/coolestprojectsapp.appspot.com/o/Maps%2Fcoolestprojectsmap.png?alt=media&token=cf6515dd-9947-4595-a203-422c6427a2ca")
        ]
    }
  
    func loadAboutContent() {
      if let aboutURL = Bundle.main.url(forResource: "about", withExtension: "html") {
        let request = URLRequest(url: aboutURL)
       // webView.loadRequest(request)
      }
    }
}
