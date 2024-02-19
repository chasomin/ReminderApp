//
//  ReminderListView.swift
//  ReminderApp
//
//  Created by 차소민 on 2/15/24.
//

import UIKit
import SnapKit

final class ReminderListView: BaseView {
    let stackView = UIStackView()
    let searchBar = UISearchBar()
    let tableView = UITableView()
    // TODO: UISearchController
    
    override func configureHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubview(searchBar)
        stackView.addArrangedSubview(tableView)
    }
    
    override func configureLayout() {
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .fill
        
        searchBar.placeholder = "할 일 검색"
        searchBar.barTintColor = .black
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .black
    }
}
