//
//  UIViewController+Extension.swift
//  ReminderApp
//
//  Created by 차소민 on 2/14/24.
//

import UIKit

extension UIViewController {
    func setNavigationTitle(title: String, isLarge: Bool) {
        navigationItem.title = title
        navigationController?.navigationBar.prefersLargeTitles = isLarge
        
    }
    func setToolbar(items: [UIBarButtonItem]) {
        navigationController?.isToolbarHidden = false
        toolbarItems = items
        navigationController?.toolbar.barTintColor = .white
    }
    func setCollectionView(collectionView: UICollectionView, delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource, cell: AnyClass, id: String) {
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
        collectionView.register(cell, forCellWithReuseIdentifier: id)
    }

    func setTableView(tableView: UITableView, delegate: UITableViewDelegate, dataSource: UITableViewDataSource, cell: AnyClass, id: String) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
        tableView.register(cell, forCellReuseIdentifier: id)
    }
    
    func setNavigationRightBarButton(title: String, action: Selector?) {
        let barButton = UIBarButtonItem(title: title, style: .plain, target: self, action: action)
        navigationItem.rightBarButtonItem = barButton
    }
    
    func setNavigationLeftBarButton(title: String, action: Selector?) {
        let barButton = UIBarButtonItem(title: title, style: .plain, target: self, action: action)
        navigationItem.leftBarButtonItem = barButton
    }
}
