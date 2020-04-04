//
//  BookTableViewCell.swift
//  demo_uitest
//
//  Created by Duckie N on 3/17/20.
//  Copyright © 2020 Nguyen Van Duc. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
