//
//  ReplyTableViewCell.swift
//  Buyme
//
//  Created by Vinh LD on 12/21/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

protocol ReplyTableViewCellDelegate: class {
    func replyTableViewCell(_ cell: ReplyTableViewCell, like reply: ReplyComment)
}

class ReplyTableViewCell: UITableViewCell {
    
    var reply: ReplyComment?
    weak var delegate: ReplyTableViewCellDelegate?
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBAction func like(_ sender: UIButton) {
        if let reply = reply {
            delegate?.replyTableViewCell(self, like: reply)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(reply: ReplyComment) {
        self.reply = reply
        likeButton.isSelected = reply.isLiked
    }
    
}
