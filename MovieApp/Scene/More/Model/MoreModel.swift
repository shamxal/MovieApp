//
//  MoreModel.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 19.10.22.
//

import Foundation

enum MoreItemType {
    case darkMode
    case subscription
    case aboutUs
    case privacyPolicy
    case termsOfUse
}

struct MoreModel {
    let title: String
    let type: MoreItemType
}
