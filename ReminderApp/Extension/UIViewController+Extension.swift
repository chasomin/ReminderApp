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
    
    func setNavigationRightBarButton(button: inout UIBarButtonItem ,title: String, action: Selector?) {
        button = UIBarButtonItem(title: title, style: .plain, target: self, action: action)
        navigationItem.rightBarButtonItem = button
    }
    
    func setNavigationLeftBarButton(title: String, action: Selector?) {
        let barButton = UIBarButtonItem(title: title, style: .plain, target: self, action: action)
        navigationItem.leftBarButtonItem = barButton
    }
    
    func showAlert(style: UIAlertController.Style, title: String?, message: String?, buttons: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)

        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(cancel)
        buttons.forEach {
            alert.addAction($0)
        }

        present(alert, animated: true)
    }
}
