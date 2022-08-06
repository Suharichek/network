//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Suharik on 14.03.2022.
//

import UIKit
import SnapKit
import iOSIntPackage

class ProfileHeaderView: UIView {
    static let identifire = "ProfileHeaderView"
    private var status: String = ""
    
     lazy var setStatusButton: CustomButton = {
        let button = CustomButton(
            title: "Показать статус",
            titleColor: UIColor.white,
            backColor: UIColor.systemBlue,
            backImage: UIImage(named: "blue_pixel")!
        )
        return button
    }()
    
    var avatarImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Ava")
        image.layer.cornerRadius = 60
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        return image
    }()
    
    var fullNameLabel: UILabel = {
        let name = UILabel()
        name.text = "Сухарик"
        name.font = .boldSystemFont(ofSize: 18)
        name.textColor = .black
        return name
    }()
    
    public lazy var statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.text = "Пока пусто"
        statusLabel.numberOfLines = 2
        statusLabel.textColor = .darkGray
        statusLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return statusLabel
    }()
    
    var statusTextField: UITextField = {
        let text = UITextField()
        text.textColor = .darkGray
        text.backgroundColor = .white
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        text.leftView = paddingView
        text.leftViewMode = .always
        text.attributedPlaceholder = NSAttributedString.init(string: "Чего-то ждем...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        text.layer.cornerRadius = 10
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColor.black.cgColor
        return text
    }()
    
     func setStatusbuttonPressed() {
        guard statusTextField.text?.isEmpty == false else {return}
        statusLabel.text = statusTextChanged(statusTextField)
        self.statusTextField.text = ""
    }
    
    @objc func statusTextChanged(_ textField: UITextField) -> String {
        if let newStatus = textField.text {
            status = newStatus
        }
        return status
    }
    
    func setupViews(){
        self.addSubview(avatarImageView)
        self.addSubview(setStatusButton)
        self.addSubview(fullNameLabel)
        self.addSubview(statusLabel)
        self.addSubview(statusTextField)
        
        avatarImageView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(120)
            make.width.equalTo(120)
        }
        setStatusButton.snp.makeConstraints{ make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
        fullNameLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(27)
            make.leading.equalToSuperview().offset(150)
        }
        statusTextField.snp.makeConstraints{ make in
            make.bottom.equalTo(setStatusButton.snp.top).offset(-34)
            make.leading.equalToSuperview().offset(150)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(30)
        }
        statusLabel.snp.makeConstraints{ make in
            make.bottom.equalTo(statusTextField.snp.top).offset(-10)
            make.leading.equalToSuperview().offset(150)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(30)
        }
    }
}

