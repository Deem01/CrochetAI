//
//  Item.swift
//  CrochetAI
//
//  Created by Deem Ibrahim on 27/02/2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
