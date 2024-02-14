//
//  ReminderListViewController.swift
//  ReminderApp
//
//  Created by 차소민 on 2/14/24.
//

import UIKit

final class ReminderListViewController: UIViewController {

    let mainView = ReminderListView()
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle(title: "전체", isLarge: true)
        setToolbar(items: mainView.setToolBar())
    
        let collectionView = mainView.collectionView
        setCollectionView(collectionView: collectionView, delegate: self, dataSource: self, cell: ReminderListCollectionViewCell.self, id: ReminderListCollectionViewCell.id)
        
        mainView.toolbarAction = {
            let vc = UINavigationController(rootViewController: AddReminderViewController())
            self.present(vc, animated: true)
        }
    }

}
extension ReminderListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ReminderList.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReminderListCollectionViewCell.id, for: indexPath) as! ReminderListCollectionViewCell
        
        cell.configureCell(index: indexPath.item)
        return cell
    }
}
