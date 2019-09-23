//
//  MostPopularViewController.swift
//  SampleNewsArticleApp
//
//  Created by Nishan G. Prathima on 9/23/19.
//  Copyright © 2019 Nishan G. Prathima. All rights reserved.
//

import UIKit
import Foundation
import Kingfisher
import DZNEmptyDataSet

class MostPopularViewController: UIViewController {

    fileprivate var arrayMostViewArticles = [MostViewedModel]()
    var mySensitiveArea: CGRect?
    var sideMenuPeriodArray: [String] = []
    
    @IBOutlet weak var tblMostViewedArticles: UITableView!
    @IBOutlet weak var sideMenuBar: UIView!
    @IBOutlet weak var btnExtraSideMenuSpaceView: UIButton!
    @IBOutlet weak var sideMenuBarTblView: UITableView!
    @IBOutlet weak var leadingSpaceSideMenuConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadinfSpaceArticlesTbl: NSLayoutConstraint!
    
    let hud = LottieHUD("new-loading")
    
    var statusofswitch:Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftImage = #imageLiteral(resourceName: "icon_menu")
        let someButton = UIBarButtonItem(image: leftImage,  style: .plain, target: self, action: #selector(someButtonTapped(sender:)))
        self.navigationItem.leftBarButtonItem = someButton
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        self.navigationController?.navigationBar.barTintColor = UIColor.RGB(r: 80, g: 227, b: 194)
        
        let rightImage = #imageLiteral(resourceName: "icon_search")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image:rightImage , style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "NY Times Most Popular"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationItem.title = " "
    }
    
    //MARK: Setup
    fileprivate func setupUI() {
        self.configEmptyDataset()
        self.getMostViewedArticlesAPI()
        self.setUpSideMenu()
    }
    
    fileprivate func setUpSideMenu() {
        let screenHeight = UIScreen.main.bounds.size.height
        mySensitiveArea = CGRect(x:0, y:0, width:50, height:screenHeight)
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(_:)))
        swipeGesture.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeGesture)
        
        self.btnExtraSideMenuSpaceView.isHidden = true
        
        self.tblMostViewedArticles.tableFooterView = UIView()
        self.tblMostViewedArticles.backgroundColor = .clear
        self.tblMostViewedArticles.allowsMultipleSelection = false
        
        self.statusofswitch = false
        
        self.sideMenuPeriodArray = ["1 Day","7 Days","30 Days"]
        
        self.tblMostViewedArticles.reloadData()
    }
    
    fileprivate func configEmptyDataset() {
        self.tblMostViewedArticles.emptyDataSetSource = self
        self.tblMostViewedArticles.emptyDataSetDelegate = self
        self.tblMostViewedArticles.tableFooterView = UIView()
    }
    
    fileprivate func getMostViewedArticlesAPI() {
        if !isInternetConnected() {
            self.showAlert(withMessage: "Application requires Internet Connection. Please connect to a data network or a Wifi and try again later.",withCompletionHandler: {
            })
            return
        }
        self.actionGetMostViewedAPICall(fromPeriod: "7") //By Default
    }
    
    
    @objc func handleGesture(_ gestureRecognizer: UIGestureRecognizer) {
        let p = gestureRecognizer.location(in: self.view)
        if mySensitiveArea!.contains(p) {
        } else {
        }
    }
    
    @objc func someButtonTapped(sender: UIBarButtonItem) {
        if statusofswitch == true {
            statusofswitch = false
            self.hideSideMenuView()
        } else if statusofswitch == false {
            statusofswitch = true
            self.showSideMenuView()
        }
    }
    
    @IBAction func extraSpaceViewClicked(_ sender: Any) {
        self.hideSideMenuView()
    }
    
    func showSideMenuView () {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5, animations: {() -> Void in
            self.btnExtraSideMenuSpaceView.isHidden = false
            self.leadingSpaceSideMenuConstraint.constant = 0
            self.leadinfSpaceArticlesTbl.constant = 140
            self.view.layoutIfNeeded()
        })
    }
    
    func hideSideMenuView () {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5, animations: {() -> Void in
            self.btnExtraSideMenuSpaceView.isHidden = true
            self.leadingSpaceSideMenuConstraint.constant = -140
            self.leadinfSpaceArticlesTbl.constant = 0
            self.statusofswitch = false
            self.view.layoutIfNeeded()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: API Calls
    fileprivate func actionGetMostViewedAPICall(fromPeriod: String) {
        hud.showHUD()
        MostViewedListingManager.getListing(fromPeriod: fromPeriod) { (success, error, mostViewedArticles) in
            
            if success {
                self.arrayMostViewArticles.removeAll()
                self.arrayMostViewArticles.append(contentsOf: mostViewedArticles)
                self.hud.stopHUD()
            } else {
                self.showAlert(withMessage: "Sorry, we are unable to process your request. Please try later",withCompletionHandler: {
                })
                print(error?.localizedDescription ?? "Articles not available.")
            }
            self.tblMostViewedArticles.reloadData()
        }
    }
}

extension MostPopularViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tblMostViewedArticles {
            return self.arrayMostViewArticles.count
        } else {
            return self.sideMenuPeriodArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.tblMostViewedArticles {
            return 140.0
        } else {
            return 40.0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.tblMostViewedArticles {
            let request = self.arrayMostViewArticles[indexPath.row]
            
            let cell = (tableView.dequeueReusableCell(withIdentifier: "MostViewedTableViewCellID") as! MostViewedTableViewCell)
            
            cell.lblArticleTitle.text = request.titleName
            cell.lblArticleBy.text = request.byLine
            cell.lblArticlePublishDate.text = request.publishedDate
            
            let imageURL = request.mediaResults.mediaMetaDataList[0].imageURL!
            if !imageURL.isEmpty {
                if let url = URL.init(string: imageURL) {
                    let resource = ImageResource.init(downloadURL: url)
                    cell.imgArticle.kf.indicatorType = .activity
                    cell.imgArticle.kf.setImage(with: resource, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, ctype, url) in
                        cell.imgArticle.image = image
                        cell.imgArticle.contentMode = .scaleAspectFit
                        cell.imgArticle.setRounded()
                    })
                }
            }
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCellID") as! SideMenuTableViewCell
            
            cell.lblSideMenu.text = self.sideMenuPeriodArray[indexPath.row]
            cell.selectionStyle = .none
            
            return cell
        }
    }
}

extension MostPopularViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.tblMostViewedArticles {
            let detailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewDetailsViewControllerID") as! NewDetailsViewController
            detailsViewController.setCurrentArticle(selectedArticle: self.arrayMostViewArticles, selectedIndex: indexPath)
            self.navigationController?.navigationBar.tintColor = UIColor.white
            self.navigationController?.pushViewController(detailsViewController, animated: true)
            
        } else {
            if indexPath.row == 0 {
                self.actionGetMostViewedAPICall(fromPeriod: "1")
            } else if indexPath.row == 1 {
                self.actionGetMostViewedAPICall(fromPeriod: "7")
            } else if indexPath.row == 2 {
                self.actionGetMostViewedAPICall(fromPeriod: "30")
            }
            self.hideSideMenuView()
        }
    }
}

extension MostPopularViewController: DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        
        let myString = "Currently No Articles"
        let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.black ]
        let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
        
        let attributedString = myAttrString
        return attributedString
    }
}

extension MostPopularViewController: DZNEmptyDataSetDelegate {
    
}
