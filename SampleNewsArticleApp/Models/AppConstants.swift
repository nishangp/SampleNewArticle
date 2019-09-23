//
//  AppConstants.swift
//  SampleNewsArticleApp
//
//  Created by Nishan G. Prathima on 9/23/19.
//  Copyright © 2019 Nishan G. Prathima. All rights reserved.
//

import Foundation

struct AppConstants {
    
    struct ViewedArticleKeys {
        static let titleId = "id"
        static let titleName = "title"
        static let byLine = "byline"
        static let publishedDate = "published_date"
        static let media = "media"
        static let mediaMetaData = "media-metadata"
        static let url = "url"
        static let format = "format"
        static let copyright = "copyright"
        static let caption = "caption"
        static let abstract = "abstract"
    }
    
    struct ResponseKeys {
        static let status = "status"
        static let error = "Error"
        static let results = "results"
        static let message = "Message"
    }
    
    struct APIKey {
        static let apikey = "13mXkuTMGxlAzw6XaG2mrOeFtqscPFpz"
    }
}
