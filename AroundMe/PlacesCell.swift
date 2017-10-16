//
//  PlacesCell.swift
//  AroundMe
//
//  Created by Aashana on 10/10/17.
//  Copyright © 2017 Aashana. All rights reserved.
//

import UIKit

class PlacesCell: UITableViewCell {
    @IBOutlet var name:UILabel!
    @IBOutlet var address:UILabel!
    @IBOutlet var background:UIImageView!
    @IBOutlet var rating:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
