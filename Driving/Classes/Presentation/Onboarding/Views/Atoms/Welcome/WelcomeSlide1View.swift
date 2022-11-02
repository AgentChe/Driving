//
//  WelcomeSlide1View.swift
//  CDL
//
//  Created by Andrey Chernyshev on 20.06.2021.
//

import UIKit

final class WelcomeSlide1View: UIView {
    lazy var imageView = makeImageView()
    lazy var titleLabel = makeTitleLabel()
    lazy var subtitleLabel = makeSubtitleLabel()
    
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
private extension WelcomeSlide1View {
    func initialize() {
        backgroundColor = UIColor.clear
    }
}

// MARK: Make constraints
private extension WelcomeSlide1View {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 375.scale),
            imageView.heightAnchor.constraint(equalToConstant: 388.scale),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 61.scale : 30.scale)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.scale),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24.scale)
        ])
        
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.scale),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.scale),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension WelcomeSlide1View {
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "Onboarding.Welcome1")
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 51, green: 51, blue: 51))
            .font(Fonts.Lato.bold(size: 36.scale))
            .lineHeight(43.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = "Onboarding.Welcome.Title1".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSubtitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 51, green: 51, blue: 51, alpha: 0.8))
            .font(Fonts.Lato.regular(size: 18.scale))
            .lineHeight(25.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = "Onboarding.Welcome.Subtitle1".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
