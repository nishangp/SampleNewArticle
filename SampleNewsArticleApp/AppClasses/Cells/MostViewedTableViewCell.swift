//
//  MostViewedTableViewCell.swift
//  SampleNewsArticleApp
//
//  Created by Nishan G. Prathima on 9/23/19.
//  Copyright © 2019 Nishan G. Prathima. All rights reserved.
//

import UIKit
import Foundation

class MostViewedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgArticle: UIImageView!
    @IBOutlet weak var lblArticleTitle: UILabel!
    @IBOutlet weak var lblArticleBy: UILabel!
    @IBOutlet weak var lblArticlePublishDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
