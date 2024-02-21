//
//  ReminderListView.swift
//  ReminderApp
//
//  Created by 차소민 on 2/14/24.
//

import UIKit
import SnapKit

final class ReminderView: BaseView, UINavigationControllerDelegate {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    let tableViewTitle = HeaderTitleView()
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    let toolBar = UIToolbar()
    lazy var toolBarLeftButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        let image = UIImage(systemName: "plus.circle.fill")
        config.image = image
        config.imagePadding = 5
        config.title = "새로운 미리 알림"
        button.configuration = config
        button.addTarget(self, action: #selector(addReminderButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    var addReminderAction: (() -> Void)?
    var addBoxButtonTapped: ((UINavigationController, AddBoxViewController) -> Void)?
    
    override func configureHierarchy() {
        addSubview(collectionView)
        addSubview(tableViewTitle)
        addSubview(tableView)
        addSubview(toolBar)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(300)
        }
        
        tableViewTitle.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(tableViewTitle.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        collectionView.backgroundColor = .clear
        tableView.backgroundColor = .clear
    }
    
    func setToolBar() -> [UIBarButtonItem] {
        let addReminder = UIBarButtonItem(customView: toolBarLeftButton)
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let addList = UIBarButtonItem(title: "목록 추가", style: .plain, target: self, action: #selector(addListButtonTapped))
        return [addReminder, space, addList]
    }
    
    @objc func addReminderButtonTapped() {
        addReminderAction?()
    }
    
    @objc func addListButtonTapped() {
        let vc = AddBoxViewController()
        let nav = UINavigationController(rootViewController: vc)
        addBoxButtonTapped?(nav, vc)
    }
}

extension ReminderView {
    static func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let width = UIScreen.main.bounds.width - spacing * 2 - 10
        layout.itemSize = CGSize(width: width/2, height: 90)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        return layout
    }
}
