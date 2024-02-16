//
//  AddDetailTableViewCell.swift
//  ReminderApp
//
//  Created by 차소민 on 2/14/24.
//

import UIKit
import SnapKit

final class AddDetailTableViewCell: BaseTableViewCell {
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
        
        subTitle.font = .systemFont(ofSize: 13)
        subTitle.textColor = .lightGray
        subTitle.textAlignment = .right
    }
    
    func configureCell(index: Int, data: ReminderModel) {
        title.text = AddReminderCellList.allCases[index].rawValue
        var priorityString = ""
        switch data.priority {
        case 0 :
            priorityString = "없음"
        case 1:
            priorityString = "낮음"
        case 2:
            priorityString = "중간"
        case 3:
            priorityString = "높음"
        default:
            break
        }
        let dataList = [data.deadline, data.tag, priorityString]
        subTitle.text = dataList[index]
    }
    
}
