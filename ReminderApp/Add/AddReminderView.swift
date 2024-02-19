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
    let stackView = UIStackView()
    
    override func configureHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubview(tableView)
        stackView.addArrangedSubview(deleteButton)
    }
    
    override func configureLayout() {
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
    }
    
    override func configureView() {
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fill
        stackView.alignment = .fill
        
        tableView.backgroundColor = .black
        tableView.separatorStyle = .singleLine
        
        deleteButton.setTitle("삭제", for: .normal)
        deleteButton.layer.cornerRadius = 10
        deleteButton.layer.borderColor = UIColor.white.cgColor
        deleteButton.layer.borderWidth = 1
    }
}
