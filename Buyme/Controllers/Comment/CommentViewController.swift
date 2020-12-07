//
//  CommentViewController.swift
//  Buyme
//
//  Created by Vinh LD on 12/7/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class CommentViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!

    override func back(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func viewRating(_ sender: UIButton) {
        let vc = RatingViewController()
        present(vc, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        CommentTableViewCell.register(tableView)
    }
    
    override func initViews() {
        
    }

}

extension CommentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension CommentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = CommentTableViewCell.cell(for: tableView, at: indexPath) {
            return cell
        }
        
        return .init()
    }
}
