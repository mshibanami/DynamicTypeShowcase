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
                self?.sizesSlider.value =
                    CGFloat(UIContentSizeCategory.validSizes
                        .index(where: { $0.value == size })
                        ?? -1)

                UIView.animate(
                    withDuration: 0.2,
                    animations: { [weak self] in
                        self?.sizesSlider.alpha = (size != nil)
                            ? 1.0
                            : 0
                })
            })
            .disposed(by: self.disposeBag)

        self.useSizeForSceneSwitch.rx.isOn
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.contentSizeCategory.value = $0
                    ? nil
                    : .large
            })
            .disposed(by: self.disposeBag)

        self.sizesSlider.rx.value
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in
                self?.contentSizeCategory.value
                    = UIContentSizeCategory
                        .validSizes[optional: Int($0)]?
                        .value

                print("\($0): \(self?.contentSizeCategory.value?.name ?? "") ")
            })
            .disposed(by: self.disposeBag)
    }
}

extension TextStylesSettingPopoverViewController: KUIPopOverUsable {
    var contentSize: CGSize {
        return self.view.subviews.first?.bounds.size
            ?? CGSize(width: 300, height: 100)
    }
}
