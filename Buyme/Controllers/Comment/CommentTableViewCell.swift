//
//  CommentTableViewCell.swift
//  Buyme
//
//  Created by Vinh LD on 12/21/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

protocol CommentTableViewCellDelegate: class {
    func commentTableViewCell(_ cell: CommentTableViewCell, like comment: Comment)
    func commentTableViewCell(_ cell: CommentTableViewCell, expand height: CGFloat?)
}

class CommentTableViewCell: UITableViewCell {
    
    var comment: Comment?
    weak var delegate: CommentTableViewCellDelegate?
    
    @IBOutlet weak var totalRepliesLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var repliesView: UIView!
    @IBOutlet weak var totalRepliesView: UIView!
    
    @IBAction func like(_ sender: UIButton) {
        if let comment = comment {
            delegate?.commentTableViewCell(self, like: comment)
        }
    }
    
    @IBAction func expand(_ sender: UIButton) {
        tableView.layoutIfNeeded()
        tableView.invalidateIntrinsicContentSize()
        var height: CGFloat?
        if !(comment?.isExpand ?? false) {
            height = tableView.contentSize.height + frame.size.height
        }
        self.delegate?.commentTableViewCell(self, expand: height)
    }
    
    func setup(comment: Comment) {
        self.comment = comment
        likeButton.isSelected = comment.isLiked
        let isExpand = comment.isExpand
        repliesView.isHidden = !isExpand
        totalRepliesView.isHidden = isExpand
        totalRepliesLabel.text = "| \(comment.replies.count) Phản hồi"
        tableView.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ReplyTableViewCell.register(tableView)
    }
}

extension CommentTableViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension CommentTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comment?.replies.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = ReplyTableViewCell.cell(for: tableView, at: indexPath) {
            if let reply = comment?.replies[indexPath.row] {
                cell.setup(reply: reply)
            }
            cell.delegate = self
            return cell
        }
        
        return .init()
    }
}

extension CommentTableViewCell: ReplyTableViewCellDelegate {
    func replyTableViewCell(_ cell: ReplyTableViewCell, like reply: ReplyComment) {
        if let index = tableView.indexPath(for: cell), let comment = comment {
            comment.replies[index.row].isLiked = !comment.replies[index.row].isLiked
            tableView.reloadRows(at: [index], with: .automatic)
        }
    }
}
