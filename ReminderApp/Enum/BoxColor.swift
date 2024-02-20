//
//  BoxColor.swift
//  ReminderApp
//
//  Created by 차소민 on 2/20/24.
//

import UIKit

enum BoxColor: CaseIterable {
    case red
    case orange
    case systemYellow
    case green
    case blue
    case systemPink
    
    var color: UIColor {
        switch self {
        case .red:
                .systemRed
        case .orange:
                .systemOrange
        case .systemYellow:
                .systemYellow
        case .green:
                .systemGreen
        case .blue:
                .systemBlue
        case .systemPink:
                .systemPink
        }
    }
}
