//
//  CircleImageView.swift
//  ReminderApp
//
//  Created by 차소민 on 2/14/24.
//

import UIKit
import SnapKit

class CircleImageView: UIView {
    let image = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(image)
        image.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(7)
        }
        image.tintColor = .white
        
    }
    override func layoutSubviews() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
