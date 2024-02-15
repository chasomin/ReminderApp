//
//  ReminderListView.swift
//  ReminderApp
//
//  Created by 차소민 on 2/14/24.
//

import UIKit
import SnapKit

final class ReminderView: BaseView {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    let toolBar = UIToolbar()
    private let image = UIImage(systemName: "plus.circle.fill")
    private var button = UIButton()
    
    var toolbarAction: (() -> Void)?
    
    override func configureHierarchy() {
        addSubview(collectionView)
        addSubview(toolBar)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    
    override func configureView() {
        collectionView.backgroundColor = .clear
        
    }
    
    func setToolBar() -> [UIBarButtonItem] {
        button.setTitle("새로운 미리 알림", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(addReminderButtonTapped), for: .touchUpInside)
        let addReminder = UIBarButtonItem(customView: button)
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let addList = UIBarButtonItem(title: "목록 추가", style: .plain, target: self, action: #selector(addListButtonTapped))
        
        return [addReminder, space, addList]
    }
    
    @objc func addReminderButtonTapped() {
        print(#function)
        toolbarAction?()
    }
    
    @objc func addListButtonTapped() {
        print(#function)
    }
}

extension ReminderView {
    static func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - spacing * 3
        layout.itemSize = CGSize(width: width/2, height: 100)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
//        layout.scrollDirection = .horizontal
        return layout
    }
}
