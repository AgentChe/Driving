//
//  OAppCell.swift
//  Driving
//
//  Created by Андрей Чернышев on 02.11.2022.
//

import UIKit

final class OAppCell: UIButton {
    lazy var marked = false {
        didSet {
            update()
        }
    }
    
    lazy var label = makeLabel()
    lazy var iconView = makeImageView()
    
    let app: App
    
    init(app: App) {
        self.app = app
        
        super.init(frame: .zero)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 335.scale, height: 84.scale)
    }
}

// MARK: Private
private extension OAppCell {
    func update() {
        layer.borderWidth = marked ? 1.scale : 0
        layer.borderColor = marked ? UIColor(integralRed: 64, green: 116, blue: 110).cgColor : UIColor.clear.cgColor
    }
    
    func title() -> String {
        switch app {
        case .cdl:
            return "Onboarding.App.CDL".localized
        case .dmv:
            return "Onboarding.App.DMV".localized
        case .moto:
            return "Onboarding.App.Moto".localized
        }
    }
    
    func image() -> UIImage? {
        switch app {
        case .cdl:
            return UIImage(named: "Onboarding.App.CDL")
        case .dmv:
            return UIImage(named: "Onboarding.App.DMV")
        case .moto:
            return UIImage(named: "Onboarding.App.Moto")
        }
    }
}

// MARK: Make constraints
private extension OAppCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 52.scale),
            iconView.heightAnchor.constraint(equalToConstant: 52.scale),
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -28.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension OAppCell {
    func makeLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 51, green: 51, blue: 51))
            .font(Fonts.SFProRounded.regular(size: 16.scale))
            .lineHeight(22.4.scale)
        
        let view = UILabel()
        view.attributedText = title().attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.image = image()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
