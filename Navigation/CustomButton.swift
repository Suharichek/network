//
//  CustomButton.swift
//  Navigation
//
//  Created by Suharik on 24.06.2022.
//

import Foundation
import UIKit

final class CustomButton: UIButton {
    
    let title: String
    let titleColor: UIColor
    let backColor: UIColor
    let backImage: UIImage
    var tapAction: (() -> Void)?
    init (title: String, titleColor: UIColor, backColor: UIColor, backImage: UIImage) {
        self.title = title
        self.titleColor = titleColor
        self.backColor = backColor
        self.backImage = backImage
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        titleLabel?.textColor = titleColor
        layer.cornerRadius = 10
        clipsToBounds = true
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        backgroundColor = backColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped() {
        tapAction?()
    }
}



