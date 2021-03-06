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
import Reusable

class SizesSettingPopoverViewController: UIViewController, StoryboardBased {
    @IBOutlet private weak var useSizeForSceneSwitch: UISwitch!
    @IBOutlet private weak var sizesSlider: TGPDiscreteSlider!
    @IBOutlet private weak var sizesSliderStackView: UIStackView!

    weak var adjustableViewController: DynamicTypeAdjustable!

    let usesSizeForScene = Variable<Bool>(false)
    let contentSizeCategory = Variable<UIContentSizeCategory>(.large)

    lazy private var sizeSliderIndex: Observable<Int?> = {
        contentSizeCategory.asObservable()
            .map { size -> Int? in
                return UIContentSizeCategory.validSizes
                    .index(where: { $0.0 == size })
        }}()

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        guard self.adjustableViewController != nil else {
            fatalError("SizesSettingPopover should be present by a view controller which implements DynamicTypeAdjustable protocol.")
        }

        setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func setup() {
        sizesSlider.tickCount
            = UIContentSizeCategory.validSizes.count

        if let category = self.adjustableViewController.contentSizeCategory {
            self.contentSizeCategory.value = category
            self.usesSizeForScene.value
                = (self.adjustableViewController.contentSizeCategory != nil)
        }

        bind()
    }

    private func bind() {
        self.usesSizeForScene
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.useSizeForSceneSwitch.isOn = $0
                self?.sizesSliderStackView.isHidden = !$0
            })
            .disposed(by: self.disposeBag)

        self.useSizeForSceneSwitch.rx.isOn
            .asObservable()
            .observeOn(MainScheduler.instance)
            .bind(to: self.usesSizeForScene)
            .disposed(by: self.disposeBag)

        self.contentSizeCategory
            .asDriver()
            .drive(onNext: { [weak self] size in
                guard let `self` = self else {
                    return
                }
                self.sizesSlider.value
                    = CGFloat(UIContentSizeCategory.validSizes
                        .index(where: { $0.value == size })
                        ?? -1)
            })
            .disposed(by: self.disposeBag)

        self.sizesSlider.rx.value
            .distinctUntilChanged()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let `self` = self else {
                    return
                }

                if self.usesSizeForScene.value {
                    let category = UIContentSizeCategory
                        .validSizes[Int($0)]
                        .value
                    self.contentSizeCategory.value = category
                }
            })
            .disposed(by: self.disposeBag)

        Observable.combineLatest(
            self.contentSizeCategory.asObservable(),
            self.usesSizeForScene.asObservable()) { category, _ in
                return category
            }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] in
                guard let `self` = self else {
                    return
                }

                self.adjustableViewController.contentSizeCategory =
                    self.usesSizeForScene.value ? $0 : nil
            })
            .disposed(by: self.disposeBag)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.preferredContentSize = self.contentSize
    }
}

extension SizesSettingPopoverViewController: KUIPopOverUsable {
    public var contentSize: CGSize {
        self.view.subviews.first?.sizeToFit()
        return self.view.subviews.first?.bounds.size
            ?? CGSize(width: 0, height: 0)
    }
}
