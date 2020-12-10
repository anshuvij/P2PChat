//
//  ChatCell.swift
//  P2P
//
//  Created by Anshu Vij on 12/8/20.
//

import UIKit

class ChatCell: UITableViewCell {
    
    
    @IBOutlet weak var messageBubble: UIView!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var rightImageView: UIImageView!
    
    @IBOutlet weak var leftImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
