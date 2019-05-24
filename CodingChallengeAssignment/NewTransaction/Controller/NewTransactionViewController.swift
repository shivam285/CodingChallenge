//
//  NewTransactionViewController.swift
//  CodingChallengeAssignment
//
//  Created by Shivam Seth on 5/24/19.
//  Copyright © 2019 Shivam Seth. All rights reserved.
//

import UIKit

class NewTransactionViewController: UIViewController {
    
    //MARK: - APP CYCLE METHODS
    internal class func newInstance() -> NewTransactionViewController {
        let viewController = NewTransactionViewController.init(nibName: "NewTransactionViewController", bundle: nil)
        return viewController
    }
    
    //MARK: - IBOutlet
    @IBOutlet var tfPersonAAmountTextField: UITextField!
    @IBOutlet var tfPersonBAmountTextField: UITextField!
    @IBOutlet var tfPersonCAmountTextField: UITextField!
    @IBOutlet var tfPersonDAmountTextField: UITextField!
    @IBOutlet var tfPersonEAmountTextField: UITextField!
    @IBOutlet var tfTransactionName: UITextField!
    @IBOutlet var vContainerView: UIView!
    
    //MARK: - Properties
    var viewModel:NewTransactionViewModel! {
        didSet {
            viewModel.viewDelegate = self
        }
    }
    
    //MARK: - App cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        configureView()
    }
    
    //MARK: - Private methods
    private func setupNavBar() {
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(image: UIImage(named:"back"), style: .plain, target: self, action: #selector(actionBackButton(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        title = viewModel.navBarTitle
    }
    
    private func configureView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction))
        vContainerView.addGestureRecognizer(tapGesture)
    }

    @objc func tapGestureAction() {
        tfPersonAAmountTextField.resignFirstResponder()
        tfPersonBAmountTextField.resignFirstResponder()
        tfPersonCAmountTextField.resignFirstResponder()
        tfPersonDAmountTextField.resignFirstResponder()
        tfPersonEAmountTextField.resignFirstResponder()
        tfTransactionName.resignFirstResponder()
    }
    
    @objc func actionBackButton(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionSaveButton() {
        
        var totalAmnt = 0
        if let personAAmount = tfPersonAAmountTextField.text {
            viewModel.personAAmount = Int(personAAmount)
            totalAmnt = totalAmnt + viewModel.personAAmount
        }
        
        if let personBAmount = tfPersonBAmountTextField.text {
            viewModel.personBAmount = Int(personBAmount)
            totalAmnt = totalAmnt + viewModel.personBAmount
        }
        
        if let personCAmount = tfPersonCAmountTextField.text {
            viewModel.personCAmount = Int(personCAmount)
            totalAmnt = totalAmnt + viewModel.personCAmount
        }
        
        if let personDAmount = tfPersonDAmountTextField.text {
            viewModel.personDAmount = Int(personDAmount)
            totalAmnt = totalAmnt + viewModel.personDAmount
        }
        
        
        if let personEAmount = tfPersonEAmountTextField.text {
            viewModel.personEAmount = Int(personEAmount)
            totalAmnt = totalAmnt + viewModel.personEAmount
        }
        
        if let name = tfTransactionName.text {
            viewModel.transactionName = name
        }
        
        if totalAmnt != 0, let name = tfTransactionName.text, name.count > 0 {
            viewModel.saveButtonPressed()
        }else {
            let alert = UIAlertController(title: "Please enter valid amount!", message: "Empty transaction cannot be saved", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: { (_) in

            }))
            self.present(alert, animated: true, completion: nil)
        }
    
    }
}

//MARK:- NewTransactionViewModelDelegate
extension NewTransactionViewController : NewTransactionViewModelDelegate {
    
    func transactionAddedSuccessfully() {
        self.navigationController?.popViewController(animated: true)
    }
}
