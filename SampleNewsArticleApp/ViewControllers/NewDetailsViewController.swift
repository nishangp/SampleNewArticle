//
//  NewDetailsViewController.swift
//  SampleNewsArticleApp
//
//  Created by Nishan G. Prathima on 9/23/19.
//  Copyright © 2019 Nishan G. Prathima. All rights reserved.
//

import UIKit
import Foundation
import Kingfisher

class NewDetailsViewController: UIViewController {

    fileprivate var arrayMostViewArticles = [MostViewedModel]()
    fileprivate var selectedIndexPath: IndexPath? = nil
    
    @IBOutlet weak var lblArticleTitle: UILabel!
    @IBOutlet weak var lblArticleBy: UILabel!
    @IBOutlet weak var lblPublishedDate: UILabel!
    @IBOutlet weak var imgArticle: UIImageView!
    @IBOutlet weak var lblCaption: UILabel!
    @IBOutlet weak var lblCopyright: UILabel!
    @IBOutlet weak var lblAbstract: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Most Popular"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationItem.title = " "
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Setter
    internal func setCurrentArticle(selectedArticle: [MostViewedModel], selectedIndex: IndexPath) {
        self.arrayMostViewArticles = selectedArticle
        self.selectedIndexPath = selectedIndex
    }
    
    //MARK: Setup
    fileprivate func setupUI() {
        let request = self.arrayMostViewArticles[(self.selectedIndexPath?.row)!]
        self.lblArticleTitle.text = request.titleName
        self.lblArticleBy.text = request.byLine
        self.lblPublishedDate.text = request.publishedDate
        self.lblCaption.text = request.mediaResults.caption
        self.lblCopyright.text = request.mediaResults.copyright
        self.lblAbstract.text = request.abstract
        
        let imageURL = request.mediaResults.mediaMetaDataList[0].imageURL!
        let replacedImageURL = imageURL.replacingOccurrences(of: "square320", with: "jumbo", options: NSString.CompareOptions.literal, range: nil)
        if !replacedImageURL.isEmpty {
            if let url = URL.init(string: replacedImageURL) {
                let resource = ImageResource.init(downloadURL: url)
                self.imgArticle.kf.indicatorType = .activity
                self.imgArticle.kf.setImage(with: resource, placeholder: #imageLiteral(resourceName: "no_article_image"), options: nil, progressBlock: nil, completionHandler: { (image, error, ctype, url) in
                    self.imgArticle.image = image
                })
            }
        }
    }


}
