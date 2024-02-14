//
//  AddDetailTableViewCell.swift
//  ReminderApp
//
//  Created by 차소민 on 2/14/24.
//

import UIKit

class AddDetailTableViewCell: BaseTableViewCell {

    override func configureView() {
        backgroundColor = .systemGray5
        accessoryType = .disclosureIndicator
        selectionStyle = .none
        detailTextLabel?.textAlignment = .right
    }
    
    func configureCell(index: Int) {
        textLabel?.text = AddReminderCellList.allCases[index-1].rawValue
    }
}
