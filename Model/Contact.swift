//
//  Contact.swift
//  ChineseApp
//
//  Created by 玉井　勝也 on 2021/12/22.
//

import Foundation

struct ExpandableNames {
    var isExpanded: Bool
    var names: [Contact]
}
    
struct Contact {
    let name : String
    var hasFavorited: Bool
    
}
