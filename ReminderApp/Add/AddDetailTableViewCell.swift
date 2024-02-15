//
//  AddDetailTableViewCell.swift
//  ReminderApp
//
//  Created by 차소민 on 2/14/24.
//

import UIKit
import SnapKit


class AddDetailTableViewCell: BaseTableViewCell {
    let title = UILabel()
    let subTitle = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(title)
        contentView.addSubview(subTitle)
    }
    
    override func configureLayout() {
        title.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(15)
            make.width.equalTo(80)
            
        }
        subTitle.snp.makeConstraints { make in
            make.leading.equalTo(title.snp.trailing).offset(5)
            make.verticalEdges.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(15)
        }
    }

    override func configureView() {
        backgroundColor = .systemGray5
        accessoryType = .disclosureIndicator
        selectionStyle = .none
        
        subTitle.font = .systemFont(ofSize: 13)
        subTitle.textColor = .lightGray
        subTitle.textAlignment = .right
    }
    
    func configureCell(index: Int, data: [String:String]) {
        title.text = AddReminderCellList.allCases[index-1].rawValue
        subTitle.text = data[AddReminderCellList.allCases[index-1].rawValue]
    }
    
}
