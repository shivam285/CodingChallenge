//
//  TransactionsHistoryViewController.swift
//  CodingChallengeAssignment
//
//  Created by Shivam Seth on 5/24/19.
//  Copyright © 2019 Shivam Seth. All rights reserved.
//

import UIKit

class TransactionsHistoryViewController: UIViewController {
    
    //MARK: - APP CYCLE METHODS
    internal class func newInstance() -> TransactionsHistoryViewController {
        let viewController = TransactionsHistoryViewController.init(nibName: "TransactionsHistoryViewController", bundle: nil)
        return viewController
    }
    
    //MARK: - IBOutlet
    @IBOutlet var tvTableView: UITableView!
    
    //MARK: - Properties
    var viewModel:TransactionsHistoryViewModel! {
        didSet {
            viewModel.viewDelegate = self
        }
    }
    
    //MARK: - App cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        configureView()
        
        viewModel.fetchAllTransactions()
    }
    
    //MARK: - Private methods
    private func setupNavBar() {
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(image: UIImage(named:"back"), style: .plain, target: self, action: #selector(actionBackButton(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        title = viewModel.navBarTitle
    }
    
    private func configureView() {
        configureTableView()
    }
    
    private func configureTableView() {
        tvTableView.delegate = self
        tvTableView.dataSource = self
        tvTableView.tableFooterView = UIView()
    }
    
    @objc func actionBackButton(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension TransactionsHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableView(tableView, numberOfRowsInSection:section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: viewModel.cellIdentifier)
            cell?.backgroundColor = .black
            cell?.textLabel?.textColor = .white
            cell?.detailTextLabel?.textColor = .white
        }
        
        let itemViewModel = viewModel.itemViewModels![indexPath.row]
        cell?.textLabel?.text = itemViewModel.transaction.name
        
        cell?.detailTextLabel?.text = ""
        
        return cell!
        
    }
    
}

//MARK: - TransactionsHistoryViewModelDelegate
extension TransactionsHistoryViewController : TransactionsHistoryViewModelDelegate {

    func reloadTableView()  {
        tvTableView.reloadData()
    }
}

