//
//  MediaMetaDataInfoModel.swift
//  SampleNewsArticleApp
//
//  Created by Nishan G. Prathima on 9/23/19.
//  Copyright © 2019 Nishan G. Prathima. All rights reserved.
//

import Foundation

struct MediaMetaDataInfoModel {
    
    var imageURL : String!
    var imageFormat : String!
    
    init(fromDictionary dictionary: [String:Any]){
        imageURL = dictionary[AppConstants.ViewedArticleKeys.url] as? String
        imageFormat = dictionary[AppConstants.ViewedArticleKeys.format] as? String
    }
    
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if imageURL != nil{
            dictionary[AppConstants.ViewedArticleKeys.url] = imageURL
        }
        if imageFormat != nil{
            dictionary[AppConstants.ViewedArticleKeys.format] = imageFormat
        }
        return dictionary
    }
    
}
