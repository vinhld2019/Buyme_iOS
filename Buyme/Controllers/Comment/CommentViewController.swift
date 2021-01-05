//
//  CommentViewController.swift
//  Buyme
//
//  Created by Vinh LD on 12/21/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        CommentTableViewCell.register(tableView)
    }

    var comments: [Comment] = [.init(), .init(), .init(), .init(), .init(), .init(), .init(), .init(), .init(), .init(), .init(), .init(), .init(), .init(), .init(), .init(), .init(), .init(), .init(), .init()]
}

extension CommentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height = comments[indexPath.row].repliesHeight {
            return height
        }
        return UITableView.automaticDimension
    }
}

extension CommentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = CommentTableViewCell.cell(for: tableView, at: indexPath) {
            cell.setup(comment: comments[indexPath.row])
            cell.delegate = self
            return cell
        }
        
        return .init()
    }
}

extension CommentViewController: CommentTableViewCellDelegate {
    func commentTableViewCell(_ cell: CommentTableViewCell, like comment: Comment) {
        if let index = tableView.indexPath(for: cell) {
            comments[index.row].isLiked = !comments[index.row].isLiked
            tableView.reloadRows(at: [index], with: .automatic)
        }
    }
    
    func commentTableViewCell(_ cell: CommentTableViewCell, expand height: CGFloat?) {
        if let index = tableView.indexPath(for: cell) {
            let comment = comments[index.row]
            let isExpand = comment.isExpand
            comments[index.row].isExpand = !isExpand
            comments[index.row].repliesHeight = height
            tableView.reloadRows(at: [index], with: .automatic)
        }
    }
}
