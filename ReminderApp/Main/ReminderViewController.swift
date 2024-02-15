//
//  ReminderListViewController.swift
//  ReminderApp
//
//  Created by 차소민 on 2/14/24.
//

import UIKit
import RealmSwift

protocol ReloadDelegate {
    func reload()
}

final class ReminderViewController: UIViewController, ReloadDelegate {

    let mainView = ReminderView()
    var data: Results<ReminderModel>!

    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle(title: "전체", isLarge: true)
        setToolbar(items: mainView.setToolBar())
    
        let collectionView = mainView.collectionView
        setCollectionView(collectionView: collectionView, delegate: self, dataSource: self, cell: ReminderCollectionViewCell.self, id: ReminderCollectionViewCell.id)
        
        mainView.toolbarAction = {
            let vc = AddReminderViewController()
            let nav = UINavigationController(rootViewController: vc)
            vc.delegate = self
            self.present(nav, animated: true)
        }
        receivedReminderData()
    }
    
    func receivedReminderData() {
        let realm = try! Realm()
        data = realm.objects(ReminderModel.self)
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
        
        cell.configureCell(index: indexPath.item)
        if indexPath.row == ReminderList.allCases.firstIndex(of: .all) {
            cell.reminderCount.text = "\(data.count)"
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item == ReminderList.allCases.firstIndex(of: .all) {
            let vc = ReminderListViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
