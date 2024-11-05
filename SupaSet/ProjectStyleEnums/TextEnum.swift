//
//  TextEnum.swift
//  FinalProject
//
//  Created by Rishi Garg on 2/22/24.
//

import SwiftUI

enum FontSize {
    case title
    case headline
    case subHeading
    case body
    case setBody
    var value: Font {
        switch self {
        case .title:
            return Font.title // Or your specific font for title
        case .headline:
            return Font.headline // Or your specific font for heading
        case .subHeading:
            return Font.subheadline // Or your specific font for subheading
        case .body:
            return Font.body // Or your specific font for body
        case .setBody:
            return Font.footnote
        }
    }
}
enum AppInfo {
    case appName
    var value: String {
        switch self {
        case .appName:
            return "SupaSet"
        }
    }
}

