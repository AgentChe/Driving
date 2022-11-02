//
//  LocaleTableViewCell.swift
//  CDL
//
//  Created by Andrey Chernyshev on 25.05.2021.
//

import UIKit

final class LocaleTableViewCell: UITableViewCell {
    lazy var container = makeContainer()
    lazy var label = makeLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension LocaleTableViewCell {
    func setup(element: LocaleTableViewElement) {
        container.backgroundColor = element.isSelected ? UIColor(integralRed: 250, green: 210, blue: 133) : UIColor.white
        container.layer.borderWidth = element.isSelected ? 0 : 1.scale
        container.layer.borderColor = element.isSelected ? UIColor.clear.cgColor : UIColor(integralRed: 239, green: 238, blue: 229).cgColor
        
        let attrs = TextAttributes()
            .font(Fonts.Lato.bold(size: 18.scale))
            .textColor(element.isSelected ? UIColor(integralRed: 51, green: 51, blue: 51) : UIColor(integralRed: 51, green: 51, blue: 51))
            .lineHeight(25.scale)
        label.attributedText = element.name.attributed(with: attrs)
    }
}

// MARK: Private
private extension LocaleTableViewCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension LocaleTableViewCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale),
            label.topAnchor.constraint(equalTo: container.topAnchor, constant: 16.scale),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension LocaleTableViewCell {
    func makeContainer() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 12.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}
