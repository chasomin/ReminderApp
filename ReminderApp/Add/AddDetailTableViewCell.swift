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
    let image = UIImageView()
    
    let stackView = UIStackView()
    
    
    override func configureHierarchy() {
        contentView.addSubview(title)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(subTitle)
        stackView.addArrangedSubview(image)
    }
    
    override func configureLayout() {
        title.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(15)
            make.width.equalTo(80)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(title.snp.trailing).offset(5)
            make.verticalEdges.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(15)
        }
        
        image.snp.makeConstraints { make in
            make.width.equalTo(image.snp.height)
        }
    }

    override func configureView() {
        backgroundColor = .systemGray5
        accessoryType = .disclosureIndicator
        
        subTitle.font = .systemFont(ofSize: 13)
        subTitle.textColor = .lightGray
        subTitle.textAlignment = .right
        
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fill
        
        image.isHidden = true
    }
    
    func configureCell(cellList: AddReminderCellList, data: ReminderModel, boxData: ReminderBox, image: UIImage) {
        title.text = cellList.title
        subTitle.text = cellList.setSubTitle(data: data, boxData: boxData)
        self.image.image = image
    }
    
}
