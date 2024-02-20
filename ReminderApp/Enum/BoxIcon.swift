//
//  BoxIcon.swift
//  ReminderApp
//
//  Created by 차소민 on 2/20/24.
//

import UIKit

enum BoxIcon: CaseIterable {
    case bookmark
    case flag
    case building
    case gift
    case pills
    case flame
    
    var icon: UIImage? {
        switch self {
        case .bookmark:
            UIImage(systemName: "bookmark.fill")
        case .flag:
            UIImage(systemName: "flag.checkered")
        case .building:
            UIImage(systemName: "building.2.fill")
        case .gift:
            UIImage(systemName: "gift.fill")
        case .pills:
            UIImage(systemName: "pills.fill")
        case .flame:
            UIImage(systemName: "flame.fill")
        }
    }
}

