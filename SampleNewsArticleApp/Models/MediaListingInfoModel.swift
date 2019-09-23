//
//  MediaListingInfoModel.swift
//  SampleNewsArticleApp
//
//  Created by Nishan G. Prathima on 9/23/19.
//  Copyright © 2019 Nishan G. Prathima. All rights reserved.
//

import Foundation

struct MediaListingInfoModel {
    
    var mediaMetaDataList : [MediaMetaDataInfoModel]!
    var copyright : String!
    var caption : String!
    
    init(fromDictionary dictionary: [String:Any]){
        copyright = dictionary[AppConstants.ViewedArticleKeys.copyright] as? String
        caption = dictionary[AppConstants.ViewedArticleKeys.caption] as? String
        mediaMetaDataList = [MediaMetaDataInfoModel]()
        if let mediaMetaDataListArray = dictionary[AppConstants.ViewedArticleKeys.mediaMetaData] as? [[String:Any]]{
            let dic = mediaMetaDataListArray[0]
            let value = MediaMetaDataInfoModel(fromDictionary: dic)
            mediaMetaDataList.append(value)
        }
    }
    
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        
        if copyright != nil{
            dictionary[AppConstants.ViewedArticleKeys.copyright] = copyright
        }
        if caption != nil{
            dictionary[AppConstants.ViewedArticleKeys.caption] = caption
        }
        
        if mediaMetaDataList != nil{
            var dictionaryElements = [[String:Any]]()
            for mediaMetaDataListElement in mediaMetaDataList {
                dictionaryElements.append(mediaMetaDataListElement.toDictionary())
            }
            dictionary[AppConstants.ViewedArticleKeys.mediaMetaData] = dictionaryElements
        }
        return dictionary
    }
}
