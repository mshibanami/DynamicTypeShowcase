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
    @IBOutlet weak var sizesSliderStackView: UIStackView!

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
        setup()
    }

    func setup() {
        sizesSlider.tickCount
            = UIContentSizeCategory.validSizes.count
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
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.preferredContentSize = self.contentSize
    }

    // HACK: This is deprecated Method. But we need it
    //       for a solution of a popover's crash after rotating.
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        super.willRotate(to: toInterfaceOrientation, duration: duration)
        self.dismissPopover(animated: true)
    }
}

extension SizesSettingPopoverViewController: KUIPopOverUsable {
    var contentSize: CGSize {
        return self.view.subviews.first?.bounds.size
            ?? CGSize(width: 300, height: 100)
    }
}
