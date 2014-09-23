//
//  ResultCell.swift
//  yelpapp
//
//  Created by Syed Salman Qadri on 9/22/14.
//  Copyright (c) 2014 Yahoo Inc. All rights reserved.
//

import UIKit

class ResultCell: UITableViewCell {

    @IBOutlet weak var lblCuisine: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblReviews: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var viewImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
