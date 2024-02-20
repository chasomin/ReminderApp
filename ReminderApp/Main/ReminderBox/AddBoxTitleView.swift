//
//  AddBoxTitleView.swift
//  ReminderApp
//
//  Created by 차소민 on 2/20/24.
//

import UIKit
import SnapKit

final class AddBoxTitleView: BaseView {

    let iconImage = CircleImageView()
    let textField = UITextField()

    override func configureHierarchy() {
        addSubview(iconImage)
        addSubview(textField)
    }
    
    override func configureLayout() {
        iconImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(90)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(iconImage.snp.bottom).offset(15)
            make.horizontalEdges.bottom.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
    }
    
    override func configureView() {
        iconImage.contentMode = .scaleAspectFit
        
        textField.placeholder = "목록 이름"
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.backgroundColor = .systemGray3
        
        iconImage.backgroundColor = .systemPink
        iconImage.image.image = UIImage(systemName: "flame.fill")
    }
}
