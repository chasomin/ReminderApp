//
//  ReminderListViewController.swift
//  ReminderApp
//
//  Created by 차소민 on 2/14/24.
//

import UIKit
import RealmSwift

final class ReminderViewController: UIViewController, ReloadDelegate, UINavigationControllerDelegate {

    private let mainView = ReminderView()
    private var data: Results<ReminderModel>!
    private let repository = ReminderModelRepository()
    private var boxData: Results<ReminderBox>!
    let realm = try! Realm()

    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle(title: "Reminder", isLarge: true)
        setToolbar(items: mainView.setToolBar())
    
        let collectionView = mainView.collectionView
        setCollectionView(collectionView: collectionView, delegate: self, dataSource: self, cell: ReminderCollectionViewCell.self, id: ReminderCollectionViewCell.id)
        let tableView = mainView.tableView
        setTableView(tableView: tableView, delegate: self, dataSource: self, cell: ReminderTableViewCell.self, id: ReminderTableViewCell.id)
        
        mainView.toolbarAction = {
            let vc = AddReminderViewController(navigationTitle: "새로운 할 일", navigationRigthButtonTitle: "추가", barButtonIsEnabled: false, id: nil, deleteButtonIsHidden: true)
            let nav = UINavigationController(rootViewController: vc)
            vc.delegate = self
            self.present(nav, animated: true)
        }
        data = repository.read()
        boxData = realm.objects(ReminderBox.self)
        
        mainView.addBoxButtonTapped = { (nav, vc) in
            self.present(nav, animated: true)
            vc.delegate = self
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.collectionView.reloadData()
    }
    func reload() {
        mainView.collectionView.reloadData()
        mainView.tableView.reloadData()
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
        let vc = ReminderListViewController()
        vc.data = repository.read(filter: ReminderList.allCases[indexPath.item])
        if indexPath.item != ReminderList.allCases.firstIndex(of: .all) {
            vc.mainView.searchBar.isHidden = true
        }
        vc.navigationItem.title = ReminderList.allCases[indexPath.item].rawValue
        navigationController?.pushViewController(vc, animated: true)
        
    }
}


extension ReminderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        boxData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReminderTableViewCell.id, for: indexPath) as! ReminderTableViewCell
        
        cell.configureCell(data: boxData[indexPath.row])
        
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let view = HeaderTitleView()
        
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ReminderListViewController()
        vc.data = realm.objects(ReminderModel.self).where {
            $0.box == boxData[indexPath.row]
        }
            vc.mainView.searchBar.isHidden = true
        
        vc.navigationItem.title = boxData[indexPath.row].title
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
