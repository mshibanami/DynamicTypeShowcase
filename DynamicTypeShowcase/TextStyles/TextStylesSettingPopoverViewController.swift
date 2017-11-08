//
//  TextStylesSettingPopoverViewController.swift
//  DynamicTypeShowcase
//
//  Created by abc on 2017/11/03.
//  Copyright © 2017 mshibanami. All rights reserved.
//

import Foundation
import KUIPopOver
import TGPControls
import RxSwift
import RxCocoa

class TextStylesSettingPopoverViewController: UIViewController {
    @IBOutlet private weak var useSizeForSceneSwitch: UISwitch!
    @IBOutlet private weak var sizesSlider: TGPDiscreteSlider!
    @IBOutlet weak var sizesSliderStackView: UIStackView!

    let contentSizeCategory = Variable<UIContentSizeCategory?>(nil)

    lazy private var sizeSliderIndex: Observable<Int?> = {
        contentSizeCategory.asObservable()
            .map { size -> Int? in
                return UIContentSizeCategory.validSizes
                    .index(where: { $0.0 == size })
        }}()

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        sizesSlider.tickCount
            = UIContentSizeCategory.validSizes.count

        self.contentSizeCategory
            .asObservable()
            .observeOn(MainScheduler.instance)
            .map({ $0 != nil })
            .bind(to: self.useSizeForSceneSwitch.rx.isOn)
            .disposed(by: self.disposeBag)

        self.contentSizeCategory
            .asDriver()
            .drive(onNext: { [weak self] size in
                guard let `self` = self else {
                    return
                }

                self.sizesSlider.value =
                    CGFloat(UIContentSizeCategory.validSizes
                        .index(where: { $0.value == size })
                        ?? -1)

                self.sizesSliderStackView.isHidden = (size == nil)
            })
            .disposed(by: self.disposeBag)

        self.useSizeForSceneSwitch.rx.isOn
            .asDriver()
            .skip(1)
            .drive(onNext: { [weak self] in
                self?.contentSizeCategory.value = $0
                    ? .large
                    : nil
            })
            .disposed(by: self.disposeBag)

        self.sizesSlider.rx.value
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in
                self?.contentSizeCategory.value
                    = UIContentSizeCategory
                        .validSizes[optional: Int($0)]?
                        .value
            })
            .disposed(by: self.disposeBag)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.preferredContentSize = self.contentSize
    }

    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        super.willRotate(to: toInterfaceOrientation, duration: duration)
        // Solution for a popover's crash bug after rotating
        self.dismissPopover(animated: true)
    }
}

extension TextStylesSettingPopoverViewController: KUIPopOverUsable {
    var contentSize: CGSize {
        return self.view.subviews.first?.bounds.size
            ?? CGSize(width: 300, height: 100)
    }
}
