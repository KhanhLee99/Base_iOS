//
//  DemoCell.swift
//  NewApp
//
//  Created by apple on 5/11/21.
//

import UIKit

class DemoCell: UITableViewCell {
    @IBOutlet weak var lbTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
