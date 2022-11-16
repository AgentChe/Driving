//
//  SSAppsAndTopicsView.swift
//  Driving
//
//  Created by Андрей Чернышев on 16.11.2022.
//

import UIKit

final class SSAppsAndTopicsView: SSlideView {
    lazy var appsView = makeAppsView()
    lazy var topicsView = makeTopicsView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func moveToThis() {
        super.moveToThis()
        
        topicsView.vc = vc
    }
}

// MARK: Private
private extension SSAppsAndTopicsView {
    func initialize() {
        backgroundColor = Onboarding.background
        
        appsView.didSelect = { [weak self] app in
            guard let self = self else {
                return
            }
            
            UIView.animate(withDuration: 0.3, animations: {
                self.appsView.frame.origin.x = -UIScreen.main.bounds.width
                self.topicsView.frame.origin.x = 0
            }, completion: { result in
                self.topicsView.app.accept(app)
            })
        }
        
        topicsView.didFinish = { [weak self] in
            self?.onNext()
        }
    }
}

// MARK: Lazy initialization
private extension SSAppsAndTopicsView {
    func makeAppsView() -> SSAppsView {
        let view = SSAppsView()
        view.frame.size = CGSize(width: UIScreen.main.bounds.width,
                                 height: UIScreen.main.bounds.height)
        view.frame.origin = CGPoint(x: 0, y: 0)
        view.backgroundColor = Onboarding.background
        addSubview(view)
        return view
    }
    
    func makeTopicsView() -> SSlideTopicsView {
        let view = SSlideTopicsView()
        view.frame.size = CGSize(width: UIScreen.main.bounds.width,
                                 height: UIScreen.main.bounds.height)
        view.frame.origin = CGPoint(x: UIScreen.main.bounds.width, y: 0)
        view.backgroundColor = Onboarding.background
        addSubview(view)
        return view
    }
}
