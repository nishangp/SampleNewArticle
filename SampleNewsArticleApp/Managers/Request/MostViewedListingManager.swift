//
//  MostViewedListingManager.swift
//  SampleNewsArticleApp
//
//  Created by Nishan G. Prathima on 9/23/19.
//  Copyright © 2019 Nishan G. Prathima. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct MostViewedListingManager {
    
    static func getListing(fromPeriod: String, onCompletion: @escaping (_ success: Bool, _ error: Error?, _ requests: [MostViewedModel])->()) {
        
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        let serverURL = EndPoints.shared.getMostViewedAPI() + "\(fromPeriod).json?api-key=\(AppConstants.APIKey.apikey)"
        
        AlamofireAppManager.shared.request(serverURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            
            if !response.result.isSuccess {
                onCompletion(false, response.error, [])
            }
            
            let result = JSON(response.data as Any)
            if let data = result.dictionary, let status = data[AppConstants.ResponseKeys.status]?.string, let arrayArticlesInResponse = data[AppConstants.ResponseKeys.results]?.array, status == "OK" {
                var arrayArticles = [MostViewedModel]()
                arrayArticles.append(contentsOf: arrayArticlesInResponse.map{ MostViewedModel.init(mostViewedArticles: $0) })
                onCompletion(true, nil, arrayArticles)
            } else {
                onCompletion(false, response.error, [])
            }
        }
    }
}
