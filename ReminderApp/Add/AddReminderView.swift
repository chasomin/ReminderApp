//
//  AddReminderView.swift
//  ReminderApp
//
//  Created by 차소민 on 2/14/24.
//

import UIKit
import SnapKit

final class AddReminderView: BaseView {
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    let deleteButton = UIButton()

    
    override func configureHierarchy() {
        addSubview(tableView)
        addSubview(deleteButton)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        deleteButton.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(40)
            make.height.equalTo(40)
        }
    }
    
    override func configureView() {
        tableView.backgroundColor = .black
        tableView.separatorStyle = .singleLine
        

        deleteButton.setTitle("삭제", for: .normal)
        deleteButton.layer.cornerRadius = 10
        deleteButton.layer.borderColor = UIColor.white.cgColor
        deleteButton.layer.borderWidth = 1

    }
}
