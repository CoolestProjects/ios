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
    var aboutContentURL: URL
  
    init(title: String, aboutContentURL: URL) {
      self.title = title
      self.aboutContentURL = aboutContentURL
    }
}

class AboutViewModel {
    
    var tableViewData = [Component]()
    let title: String
    
    init() {
      title = NSLocalizedString("title", tableName: "About", comment: "")
      tableViewData = [
        BlurbBox(title: NSLocalizedString("date.tilte", tableName: "Home", comment: "")),
        AboutModel(title: NSLocalizedString("title", tableName: "About", comment: ""), aboutContentURL: loadAboutContent())
        ]
    }

    func loadAboutContent() -> URL {
      let aboutURL = Bundle.main.url(forResource: "about", withExtension: "html")
      return aboutURL!
    }
  
}
