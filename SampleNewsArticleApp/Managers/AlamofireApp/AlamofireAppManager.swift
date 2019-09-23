//
//  AlamofireAppManager.swift
//  SampleNewsArticleApp
//
//  Created by Nishan G. Prathima on 9/23/19.
//  Copyright © 2019 Nishan G. Prathima. All rights reserved.
//

import Foundation
import Alamofire

struct AlamofireAppManager {
    static let shared: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        return sessionManager
    }()
}
