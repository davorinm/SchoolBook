//
//  SchoolMembersViewController.swift
//  SchoolBook
//
//  Created by Davorin Madaric on 17/07/2022.
//

import UIKit

class SchoolMembersViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: SchoolMembersViewModel!
    private var refreshControl: UIRefreshControl!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 30
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "SchoolMemberViewCell", bundle: nil), forCellReuseIdentifier: "schoolMemberCell")
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        viewModel.itemsUpdated = itemsUpdated
        viewModel.itemSelected = itemSelected
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.load()
    }
    
    // MARK: - Model
    
    private func itemsUpdated() {
        self.tableView.reloadData()
    }
    
    private func itemSelected(viewModel: SchoolMemberDetailsViewModel) {
        let vc = SchoolMemberDetailsViewController.create(viewModel: viewModel)
        self.show(vc, sender: nil)
    }
    
    // MARK: - Refresh
    
    @objc private func refresh(_ sender: Any) {
        refreshControl.endRefreshing()

        viewModel.reload()
    }
}

extension SchoolMembersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = viewModel.itemAtIndex(index: indexPath.row) else {
            assertionFailure("Data not found")
            return UITableViewCell()
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "schoolMemberCell") as? SchoolMemberViewCell else {
            assertionFailure("Cell not found")
            return UITableViewCell()
        }
        
        cell.setData(schoolMember: item)
            
        return cell
    }
}

extension SchoolMembersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SchoolMembersViewController {
    class func create(viewModel: SchoolMembersViewModel) -> SchoolMembersViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SchoolMembersViewController") as! SchoolMembersViewController
        vc.viewModel = viewModel
        return vc
    }
}
