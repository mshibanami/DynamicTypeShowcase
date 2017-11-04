//
//  Collection+Util.swift
//  DynamicTypeShowcase
//
//  Created by abc on 2017/11/04.
//  Copyright © 2017 mshibanami. All rights reserved.
//

import Foundation

extension Collection {
    subscript(optional i: Index) -> Iterator.Element? {
        return self.indices.contains(i) ? self[i] : nil
    }
}
