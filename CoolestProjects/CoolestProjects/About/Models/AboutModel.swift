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
    var aboutContentURL: String
  
    init(title: String, aboutContentURL: String) {
      self.title = title
      self.aboutContentURL = aboutContentURL
    }
}

class AboutViewModel {
    
    var tableViewData = [Component]()
    let title: String
    
    init() {
      title = "About"
      tableViewData = [
        BlurbBox(title: NSLocalizedString("date.tilte", tableName: "Home", comment: "")),
        AboutModel(title: NSLocalizedString("About", tableName: "About", comment: ""), aboutContentURL: loadAboutContent())
        ]
    }

    func loadAboutContent() -> String {
      if let aboutURL = Bundle.main.url(forResource: "about", withExtension: "html") {
      let path:String = aboutURL.path
        return path
      }
      //TO DO: Add default.
      return ""
    }
}
