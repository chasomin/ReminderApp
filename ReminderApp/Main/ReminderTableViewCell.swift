//
//  ReminderTableViewCell.swift
//  ReminderApp
//
//  Created by 차소민 on 2/20/24.
//

import UIKit
import SnapKit

class ReminderTableViewCell: BaseTableViewCell {
    let title = UILabel()
    let count = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(title)
        contentView.addSubview(count)
    }
    
    override func configureLayout() {
        title.snp.makeConstraints { make in
            make.leading.verticalEdges.equalToSuperview().inset(15)
        }
        count.snp.makeConstraints { make in
            make.trailing.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(15)
            make.width.equalTo(20)
        }
    }
    
    override func configureView() {
        title.font = .systemFont(ofSize: 13)
        title.textColor = .white
        title.textAlignment = .left
        title.numberOfLines = 1
        
        count.font = .systemFont(ofSize: 13)
        count.textColor = .systemGray
        
        count.textAlignment = .right
        count.numberOfLines = 1
        
        
        accessoryType = .disclosureIndicator
        backgroundColor = .systemGray6
    }

}
