//
//  ReminderListViewController.swift
//  ReminderApp
//
//  Created by 차소민 on 2/14/24.
//

import UIKit
import RealmSwift

final class ReminderViewController: UIViewController, ReloadDelegate {

    private let mainView = ReminderView()
    private var data: Results<ReminderModel>!
    private let repository = ReminderModelRepository()

    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle(title: "Reminder", isLarge: true)
        setToolbar(items: mainView.setToolBar())
    
        let collectionView = mainView.collectionView
        setCollectionView(collectionView: collectionView, delegate: self, dataSource: self, cell: ReminderCollectionViewCell.self, id: ReminderCollectionViewCell.id)
        
        mainView.toolbarAction = {
            let vc = AddReminderViewController()
            let nav = UINavigationController(rootViewController: vc)
            vc.delegate = self
            self.present(nav, animated: true)
        }
        data = repository.read()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.collectionView.reloadData()
    }
    func reload() {
        mainView.collectionView.reloadData()
    }
}


extension ReminderViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ReminderList.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReminderCollectionViewCell.id, for: indexPath) as! ReminderCollectionViewCell
        
        cell.configureCell(index: indexPath.item, data: data)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: 각각 조건에 맞는 할일들 필터링해서 목록 보여주기

//        if indexPath.item == ReminderList.allCases.firstIndex(of: .all) {
            let vc = ReminderListViewController()
        vc.data = repository.read(filter: ReminderList.allCases[indexPath.item])
            vc.navigationItem.title = ReminderList.allCases[indexPath.item].rawValue
            navigationController?.pushViewController(vc, animated: true)
//        }
    }
}
