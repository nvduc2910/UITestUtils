//
//  SecondViewController.swift
//  demo_uitest
//
//  Created by Duckie N on 3/16/20.
//  Copyright © 2020 Nguyen Van Duc. All rights reserved.
//

import UIKit
import MBProgressHUD

class BooksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var books: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Books"
        configureView()
        getData()
    }
    
    func configureView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "BookTableViewCell", bundle: nil), forCellReuseIdentifier: "BookTableViewCell")
    }
    
    func getData() {
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        ServicesAPI.shared.getBooks { [weak self] books in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
                self.books = books
                self.tableView.reloadData()
            }
        }
    }
}

extension BooksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell") as! BookTableViewCell
        cell.titleLabel.text = books[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            
            let alert = UIAlertController(title: "Delete Confirm", message: "Do you want to delete this item?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
                
            }))
            alert.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: { action in
                
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
