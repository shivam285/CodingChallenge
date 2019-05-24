//
//  HomeViewController.swift
//  CodingChallengeAssignment
//
//  Created by Shivam Seth on 5/24/19.
//  Copyright © 2019 Shivam Seth. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK: - APP CYCLE METHODS
    internal class func newInstance() -> HomeViewController {
        let viewController = HomeViewController.init(nibName: "HomeViewController", bundle: nil)
        return viewController
    }
    
    //MARK: - IBOutlets
    @IBOutlet var tvTableView: UITableView!
    
    //MARK: - Properties
    var viewModel:HomeViewModel! {
        didSet {
            viewModel.viewDelegate = self
        }
    }
    
    //MARK: - App cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
        configureView()
        viewModel.populateItemViewModels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.fetchAllResults()
    }
    
    //MARK: - Private methods
    private func setupNavBar() {
        let addButton = UIBarButtonItem(image: UIImage(named: "AddIcon"), style: .done, target: self, action: #selector(actionAddNewTransactionButton(sender:)))
        navigationItem.rightBarButtonItem = addButton
        
        let leftButton = UIBarButtonItem(title: "ALL TRX", style: .plain, target: self, action: #selector(actionSeeAllTransactions(sender:)))
        navigationItem.leftBarButtonItem = leftButton
        
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.backgroundColor = .black
    }
    
    private func configureView() {
        configureTableView()
    }
    
    private func configureTableView() {
        tvTableView.delegate = self
        tvTableView.dataSource = self
        
        tvTableView.tableFooterView = UIView()
    }
    
    //MARK: - Actions
    @objc func actionAddNewTransactionButton(sender: UIButton) {
        
        let viewController = NewTransactionViewController.newInstance()
        let params = NewTransactionViewModelInitParams(cdContext: viewModel.cdContext)
        let newTransactionViewModel = NewTransactionViewModel(params: params)
        viewController.viewModel = newTransactionViewModel
        self.show(viewController, sender: nil)
        
    }
    
    @objc func actionSeeAllTransactions(sender: UIButton) {
        
        let viewController = TransactionsHistoryViewController.newInstance()
        let params = TransactionsHistoryViewModelInitParams(cdContext: viewModel.cdContext)
        let transactionsHistoryViewModel = TransactionsHistoryViewModel(params:params)
        viewController.viewModel = transactionsHistoryViewModel
        self.show(viewController, sender: nil)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableView(tableView, numberOfRowsInSection:section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: viewModel.cellIdentifier)
            cell?.textLabel?.textColor = .white
            cell?.detailTextLabel?.textColor = .white
            cell?.selectionStyle = .none
        }
        
        let itemViewModel = viewModel.getItemViewModel(indexPath:indexPath)
        cell?.textLabel?.text = itemViewModel.personInfo.personName
        
        cell?.detailTextLabel?.text = "\(itemViewModel.amountDue!)"
        cell?.backgroundColor = viewModel.cellBackgroundColor(atIndexPath: indexPath)

        return cell!
    }
    
}

//MARK:- HomeViewModelDelegate
extension HomeViewController : HomeViewModelDelegate {
    
    func reloadTableView() {
        tvTableView.reloadData()
    }
}
