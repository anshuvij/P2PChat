//
//  DiscoveryCell.swift
//  P2P
//
//  Created by Anshu Vij on 12/8/20.
//

import UIKit

class DiscoveryCell: UITableViewCell {

    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
