//
//  ReminderListTableViewCell.swift
//  ReminderApp
//
//  Created by 차소민 on 2/15/24.
//

import UIKit
import SnapKit

class ReminderListTableViewCell: BaseTableViewCell {
    let title = UILabel()
    let deadline = UILabel()
    let priority = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(title)
        contentView.addSubview(deadline)
        contentView.addSubview(priority)
    }

    override func configureLayout() {
        title.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(10)
            make.height.equalTo(20)
        }
        
        deadline.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(5)
            make.trailing.equalTo(title.snp.trailing)
            make.leading.bottom.equalToSuperview().inset(10)
            make.height.equalTo(14)
        }
        
        priority.snp.makeConstraints { make in
            make.leading.equalTo(title.snp.trailing)
            make.trailing.verticalEdges.equalToSuperview().inset(10)
            make.height.width.equalTo(40)
        }
    }
    
    override func configureView() {
        backgroundColor = .black
        title.font = .boldSystemFont(ofSize: 17)
        title.textColor = .white
        title.textAlignment = .left
        
        deadline.font = .systemFont(ofSize: 13)
        deadline.textColor = .darkGray
        deadline.textAlignment = .left
        
        priority.font = .systemFont(ofSize: 15)
        priority.textColor = .white
        priority.textAlignment = .right
    }
}
