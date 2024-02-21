//
//  BoxTableViewCell.swift
//  ReminderApp
//
//  Created by 차소민 on 2/20/24.
//

import UIKit
import SnapKit

final class BoxTableViewCell: BaseTableViewCell {
    let icon = CircleImageView()
    let title = UILabel()

    override func prepareForReuse() {
        accessoryType = .none
    }
    
    override func configureHierarchy() {
        contentView.addSubview(icon)
        contentView.addSubview(title)
    }
    
    override func configureLayout() {
        icon.snp.makeConstraints { make in
            make.leading.verticalEdges.equalToSuperview().inset(15)
            make.width.equalTo(icon.snp.height)
        }
        title.snp.makeConstraints { make in
            make.leading.equalTo(icon.snp.trailing).offset(15)
            make.verticalEdges.equalToSuperview().inset(15)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
//        accessoryType = .checkmark
    }
    
    
    func configureCell(data: ReminderBox) {
        title.text = data.boxTitle
        
        icon.backgroundColor = BoxColor.allCases[data.color].color
        icon.image.image = BoxIcon.allCases[data.icon].icon
    }
 
}
