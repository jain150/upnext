//
//  TableViewCell.swift
//  UpNext
//
//  Created by Shivan Desai on 3/23/17.
//  Copyright © 2017 Shivan Desai. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var CoverImage: UIImageView!
    @IBOutlet weak var Song: UILabel!
    @IBOutlet weak var Description: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
