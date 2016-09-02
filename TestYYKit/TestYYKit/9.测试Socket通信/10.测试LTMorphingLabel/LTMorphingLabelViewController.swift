//
//  LTMorphingLabelViewController.swift
//  TestYYKit
//
//  Created by lieon on 16/8/23.
//  Copyright © 2016年 lieon. All rights reserved.
//
// swiftlint:disable force_cast
// swiftlint:disable colon
// swiftlint:disable control_statement
// swiftlint:disable valid_docs
// swiftlint:disable opening_brace
// swiftlint:disable trailing_newline
// swiftlint:disable trailing_semicolon
// swiftlint:disable variable_name
// swiftlint:disable legacy_constant
// swiftlint:disable legacy_constructor
// swiftlint:disable comma
// swiftlint:disable trailing_whitespace

import UIKit
import LTMorphingLabel

class LTMorphingLabelViewController: UIViewController {
    private lazy var label: LTMorphingLabel = {
        let label = LTMorphingLabel()
        label.delegate = self
        label.font = UIFont.systemFontOfSize(17)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
       setupUI()
    }

    private func setupUI() {
        view.addSubview(label)
        label.text = "我被搞了"
        label.snp_makeConstraints { (make) in
            make.center.equalTo(view.snp_center)
            make.size.equalTo(CGSize(width: 50, height: 44))
        }
        label.morphingDuration = 2
        label.morphingEffect = .Fall
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension LTMorphingLabelViewController: LTMorphingLabelDelegate {
    
}