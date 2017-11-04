//
//  TGPControls+Rx.swift
//  DynamicTypeShowcase
//
//  Created by abc on 2017/11/04.
//  Copyright © 2017 mshibanami. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import TGPControls

extension Reactive where Base: TGPDiscreteSlider {

    public var value: ControlProperty<CGFloat> {
        return base.rx.controlProperty(
            editingEvents: [.allEditingEvents, .valueChanged],
            getter: { $0.value },
            setter: { slider, value in
                slider.value = value
        })
    }
}
