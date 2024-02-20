//
//  AddBoxView.swift
//  ReminderApp
//
//  Created by 차소민 on 2/20/24.
//

import UIKit
import SnapKit

final class AddBoxView: BaseView {
    
    let titleView = AddBoxTitleView()
    let colorView = AddBoxColorView()
    let iconView = AddBoxIconView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        colorView.selectedColorButton = { index in
            self.titleView.iconImage.backgroundColor = BoxColor.allCases[index].color
        }
        
        iconView.seletedIcon = { index in
            self.titleView.iconImage.image.image = BoxIcon.allCases[index].icon
        }
    }
    
    override func configureHierarchy() {
        addSubview(titleView)
        addSubview(colorView)
        addSubview(iconView)
    }
    
    override func configureLayout() {
        titleView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(15)
        }
        
        colorView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(15)
        }
        
        iconView.snp.makeConstraints { make in
            make.top.equalTo(colorView.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(15)
            ///bottom?
        }
    }
    
    override func configureView() {
        titleView.layer.cornerRadius = 15
        titleView.backgroundColor = .systemGray5
        
        colorView.layer.cornerRadius = 15
        colorView.backgroundColor = .systemGray5

        iconView.layer.cornerRadius = 15
        iconView.backgroundColor = .systemGray5

    }
}
