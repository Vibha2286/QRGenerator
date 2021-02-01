//
//  HistoryViewController.swift
//  QRGenerator
//
//  Created by Mangrulkar on 01/02/21.
//  Copyright © 2021 Vibha. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchContact: UISearchBar!
    
    private lazy var viewModel = HistoryViewModel(view: self)
    private var searchText: String = ""
    private var isFilter: Bool = false
    private var filterData = [UserDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.tableFooterView = UIView()
        searchContact.setSearchFieldBackgroundImage(UIImage(), for: .normal)
        searchContact.delegate = self
        bindData()
    }
    
    func bindData() {
        viewModel.configureView()
    }
    
    @IBAction func ActionToPopController(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK:- Tableview delegate and datasource
extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFilter {
            return filterData.count
        }
        return UserDefault.getUserContactDetails().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ContactDetailsCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        
        if isFilter {
            let details = filterData[indexPath.row]
            cell.updateUI(data: details)
        }else {
            let details = UserDefault.getUserContactDetails()[indexPath.row]
            cell.updateUI(data: details)
        }
        
        return cell
    }
    
}

extension HistoryViewController: HistoryView {
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func showAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "alert.button.title".localized(), style: .default, handler: { (_) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension HistoryViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if self.searchText != "" {
            reloadTableView()
        }
        self.view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        filterContentForSearchText(self.searchText)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filterData = UserDefault.getUserContactDetails().filter { (details: UserDetails) -> Bool in
            return details.name.lowercased().contains(searchText.lowercased())
        }
        
        if filterData.count > 0 {
            isFilter = true
        }else {
            isFilter = false
        }
        
        reloadTableView()
    }
    
}

extension HistoryViewController: ContactDetailsCellDelegate {
    
    func deleteActionToController(cell: ContactDetailsCell) {
        if let indexPath = self.tableView.indexPath(for: cell) {
            if isFilter {
                if let index = UserDefault.getUserContactDetails().firstIndex(where: { (item) -> Bool in
                    item.name == filterData[indexPath.row].name
                }) {
                    UserDefault.userDetailRemoveAt(index: index)
                }
                filterData.remove(at: indexPath.row)
            }else {
                UserDefault.userDetailRemoveAt(index: indexPath.row)
            }
            reloadTableView()
        }
    }
    
    func shareActionToController(cell: ContactDetailsCell) {
        if let indexPath = self.tableView.indexPath(for: cell) {
            if isFilter {
                let details = filterData[indexPath.row]
                
                guard let image = UIImage(data: details.imageData) else {
                    return
                }
                
                let shareData = UIActivityViewController(activityItems: [details.name, details.number, image], applicationActivities: [])
                shareData.popoverPresentationController?.sourceView = self.view
                present(shareData, animated: true)
            }else {
                let details = UserDefault.getUserContactDetails()[indexPath.row]
                
                guard let image = UIImage(data: details.imageData) else {
                    return
                }
                
                let shareData = UIActivityViewController(activityItems: [details.name, details.number, image], applicationActivities: [])
                shareData.popoverPresentationController?.sourceView = self.view
                present(shareData, animated: true)
                
            }
            reloadTableView()
        }
    }
    
}
