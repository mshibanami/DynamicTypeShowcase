//
//  OperatingSystemVersion+Util.swift
//  DynamicTypeShowcase
//
//  Created by abc on 2017/11/13.
//  Copyright © 2017 mshibanami. All rights reserved.
//

import UIKit

extension OperatingSystemVersion: Equatable, Comparable {
    public static func == (lhs: OperatingSystemVersion, rhs: OperatingSystemVersion) -> Bool {
        return lhs.majorVersion == rhs.majorVersion &&
            lhs.minorVersion == rhs.minorVersion &&
            lhs.patchVersion == rhs.patchVersion
    }

    public static func < (lhs: OperatingSystemVersion, rhs: OperatingSystemVersion) -> Bool {
        return lhs.majorVersion < rhs.majorVersion ||
            (lhs.majorVersion == rhs.majorVersion &&
                lhs.minorVersion < rhs.minorVersion) ||
            (lhs.majorVersion == rhs.majorVersion &&
                lhs.minorVersion == rhs.minorVersion &&
                lhs.patchVersion == rhs.patchVersion)
    }

    var string: String {
        return "\(self.majorVersion).\(self.minorVersion).\(self.patchVersion)"
    }
}
