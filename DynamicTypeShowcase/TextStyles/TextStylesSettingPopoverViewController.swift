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

    var usesSizeForScene = Variable<Bool>(false)

    var sizeIndex = Variable<Int?>(nil)

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {

        super.viewDidLoad()

        setup()
    }

    func setup() {
        self.usesSizeForScene
            .asObservable()
            .observeOn(MainScheduler.instance)
            .bind(to:
                self.useSizeForSceneSwitch.rx.isOn)
            .disposed(by: self.disposeBag)

        self.useSizeForSceneSwitch.rx
            .isOn
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.usesSizeForScene.value = $0
            })
            .disposed(by: self.disposeBag)

        self.sizesSlider.rx.value
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in
                self?.sizeIndex.value = Int($0)
                print($0)
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
