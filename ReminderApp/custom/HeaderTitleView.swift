//
//  HeaderTitleView.swift
//  ReminderApp
//
//  Created by 차소민 on 2/20/24.
//

import UIKit
import SnapKit

class HeaderTitleView: UIView {

    let title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .heavy)
        label.text = "나의 목록"
        label.textColor = .white
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(title)
        title.snp.makeConstraints { make in
            make.leading.verticalEdges.equalToSuperview().inset(5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
