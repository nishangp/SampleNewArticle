//
//  MostViewedModel.swift
//  SampleNewsArticleApp
//
//  Created by Nishan G. Prathima on 9/23/19.
//  Copyright © 2019 Nishan G. Prathima. All rights reserved.
//

import Foundation
import SwiftyJSON

struct MostViewedModel {
    
    private(set) var titleId: String = ""
    private(set) var titleName: String = ""
    private(set) var byLine: String = ""
    private(set) var publishedDate: String = ""
    private(set) var copyright: String = ""
    private(set) var caption: String = ""
    private(set) var abstract: String = ""
    var mediaResults : MediaListingInfoModel!
    
    init(mostViewedArticles: JSON) {
        
        if let titleId = mostViewedArticles[AppConstants.ViewedArticleKeys.titleId].number {
            self.titleId = titleId.stringValue
        }
        
        if let titleName = mostViewedArticles[AppConstants.ViewedArticleKeys.titleName].string {
            self.titleName = titleName
        }
        
        if let byline = mostViewedArticles[AppConstants.ViewedArticleKeys.byLine].string {
            self.byLine = byline
        }
        
        if let publishDate = mostViewedArticles[AppConstants.ViewedArticleKeys.publishedDate].string {
            self.publishedDate = publishDate
        }
        
        if let resultData = mostViewedArticles[AppConstants.ViewedArticleKeys.media].arrayObject {
            self.mediaResults = MediaListingInfoModel(fromDictionary: resultData[0] as! [String : Any])
        }
        
        if let abstractStr = mostViewedArticles[AppConstants.ViewedArticleKeys.abstract].string {
            self.abstract = abstractStr
        }
    }
}
