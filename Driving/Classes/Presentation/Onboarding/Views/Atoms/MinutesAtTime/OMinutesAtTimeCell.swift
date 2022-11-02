//
//  OMinutesAtTimeCell.swift
//  CDL
//
//  Created by Andrey Chernyshev on 28.06.2021.
//

import UIKit

final class OMinutesAtTimeCell: UIView {
    var isSelected: Bool = false {
        didSet {
            layer.borderWidth = isSelected ? 2.scale : 0
            layer.borderColor = isSelected ? UIColor(integralRed: 249, green: 205, blue: 106).cgColor : UIColor.clear.cgColor
        }
    }
    
    var element: MinutesAtTimeElement? = nil {
        didSet {
            fill()
        }
    }
    
    lazy var titleLabel = makeLabel()
    lazy var minutesLabel = makeLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension OMinutesAtTimeCell {
    func initialize() {
        backgroundColor = UIColor.white
    }
    
    func fill() {
        guard let element = self.element else {
            return
        }
        
        titleLabel.attributedText = element
            .title
            .attributed(with: TextAttributes()
                            .textColor(UIColor(integralRed: 51, green: 51, blue: 51))
                            .font(Fonts.Lato.bold(size: 18.scale))
                            .lineHeight(25.2.scale))
        
        minutesLabel.attributedText = element
            .subTitle
            .attributed(with: TextAttributes()
                            .textColor(UIColor(integralRed: 64, green: 116, blue: 110))
                            .font(Fonts.Lato.regular(size: 18.scale))
                            .lineHeight(25.2.scale))
    }
}

// MARK: Make constraints
private extension OMinutesAtTimeCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            minutesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            minutesLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension OMinutesAtTimeCell {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
