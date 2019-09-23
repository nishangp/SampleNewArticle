//
//  EndPoints.swift
//  SampleNewsArticleApp
//
//  Created by Nishan G. Prathima on 9/23/19.
//  Copyright © 2019 Nishan G. Prathima. All rights reserved.
//

import Foundation

public class EndPoints {
    
    static let shared = EndPoints()
    
    fileprivate let serverURL: String = "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/"
    
    fileprivate func chooseDomainURL() -> String {
        return self.serverURL
    }
    
    internal func getMostViewedAPI() -> String {
        return self.chooseDomainURL()
    }
}
