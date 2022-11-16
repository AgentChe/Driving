//
//  SSAppsView.swift
//  Driving
//
//  Created by Андрей Чернышев on 16.11.2022.
//

import UIKit
import RxSwift
import RxCocoa

final class SSAppsView: UIView {
    var didSelect: ((App) -> Void)?
    
    lazy var titleLabel = makeTitleLabel()
    lazy var cdlCell = makeCell(app: .cdl)
    lazy var dmvCell = makeCell(app: .dmv)
    lazy var motoCell = makeCell(app: .moto)
    lazy var button = makeButton()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var profileManager = ProfileManager()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        initialize()
        changeEnabled()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension SSAppsView {
    func initialize() {
        profileManager
            .obtainApp(forceUpdate: false)
            .compactMap { $0 }
            .asDriver(onErrorDriveWith: .never())
            .drive(Binder(self) { base, app in
                let views = [base.cdlCell, base.dmvCell, base.motoCell]
                views.forEach { $0.marked = $0.app == app }
                
                base.changeEnabled()
            })
            .disposed(by: disposeBag)
        
        button.rx.tap
            .subscribe(onNext: { [weak self] success in
                guard let self = self else {
                    return
                }

                let app = [
                    self.cdlCell, self.dmvCell, self.motoCell
                ]
                .first(where: { $0.marked })?
                .app
                
                guard let app = app else {
                    return
                }
                
                self.didSelect?(app)
            })
            .disposed(by: disposeBag)
    }
    
    @objc
    func selected(sender: UIButton) {
        guard let cell = sender as? OAppCell else {
            return
        }
        
        [cdlCell, dmvCell, motoCell].forEach { $0.marked = false }
        
        cell.marked = true
        
        changeEnabled()
        
        AmplitudeManager.shared
            .logEvent(name: "Exam Tap", parameters: [:])
    }
    
    func changeEnabled() {
        let isEmpty = [cdlCell, dmvCell, motoCell]
        .filter { $0.marked }
        .isEmpty
        
        button.isEnabled = !isEmpty
        button.alpha = isEmpty ? 0.4 : 1
    }
}

// MARK: Make constraints
private extension SSAppsView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 320.scale : 120.scale)
        ])
        
        NSLayoutConstraint.activate([
            cdlCell.centerXAnchor.constraint(equalTo: centerXAnchor),
            cdlCell.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24.scale)
        ])
        
        NSLayoutConstraint.activate([
            dmvCell.centerXAnchor.constraint(equalTo: centerXAnchor),
            dmvCell.topAnchor.constraint(equalTo: cdlCell.bottomAnchor, constant: 12.scale)
        ])
        
        NSLayoutConstraint.activate([
            motoCell.centerXAnchor.constraint(equalTo: centerXAnchor),
            motoCell.topAnchor.constraint(equalTo: dmvCell.bottomAnchor, constant: 12.scale)
        ])
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            button.heightAnchor.constraint(equalToConstant: 53.scale),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -60.scale : -30.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension SSAppsView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Onboarding.pickerText)
            .font(Fonts.Lato.bold(size: 36.scale))
            .lineHeight(43.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = "Onboarding.App.Title".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeCell(app: App) -> OAppCell {
        let view = OAppCell(app: app)
        view.layer.cornerRadius = 12.scale
        view.backgroundColor = UIColor.white
        view.addTarget(self, action: #selector(selected(sender:)), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(Onboarding.primaryButtonTint)
            .font(Fonts.Lato.regular(size: 18.scale))
            .textAlignment(.center)
        
        let view = UIButton()
        view.backgroundColor = Onboarding.primaryButton
        view.layer.cornerRadius = 12.scale
        view.setAttributedTitle("Onboarding.Next".localized.attributed(with: attrs), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
