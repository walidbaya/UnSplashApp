//
//  CustomCell.swift
//  SplashApp
//
//  Created by Baya Walid on 03/10/2022.
//

import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.text = ""
        self.descLabel.text = ""
        self.titleLabel.textColor = UIColor.init(named: "textColor")
        self.descLabel.textColor = UIColor.init(named: "textColor")
    }
}
