//
//  OnboardingView.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 23/12/23.
//

import SnapKit
import SwiftUI
import UIKit

final class OnboardingView: UIView {
    // MARK: Views
    private lazy var nextButton: UIButton = {
        let bt = AppViewFactory.buildTextButton()
        bt.setTitle("Next", for: .normal)
        bt.setTitleColor(.appPrimary, for: .normal)
        bt.backgroundColor = .clear
        
        return bt
    }()
    
    private lazy var skipButton: UIButton = {
        let bt = AppViewFactory.buildTextButton()
        bt.setTitle("Skip", for: .normal)
        bt.setTitleColor(.appPrimary, for: .normal)
        bt.backgroundColor = .clear
        
        return bt
    }()
    
    private lazy var getStartedButton: UIButton = {
        let bt = AppViewFactory.buildTextButton()
        bt.setTitle("Get Started", for: .normal)
        bt.setTitleColor(.appSecondary, for: .normal)
        bt.backgroundColor = .appPrimary
        bt.isHidden = true
        
        return bt
    }()
    
    private lazy var pageControl: UIPageControl = {
        let cl = UIPageControl()
        cl.translatesAutoresizingMaskIntoConstraints = false
        cl.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cl.transform = .init(scaleX: 1.5, y: 1.5)
        cl.pageIndicatorTintColor = .gray.withAlphaComponent(0.4)
        cl.currentPageIndicatorTintColor = .appPrimary
        cl.currentPage = 0
        
        return cl
    }()
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        fatalError("init(coder:) has not been implemented")
    }
    
    @available(*, unavailable)
    override class func awakeFromNib() {
        super.awakeFromNib()
        
        fatalError("awakeFromNib() has not been implemented")
    }
    
    // MARK: Functionalities
    func getNextButton() -> UIButton {
        return self.nextButton
    }
    
    func getSkipButton() -> UIButton {
        return self.skipButton
    }
    
    func getGetStartedButton() -> UIButton {
        return self.getStartedButton
    }
    
    func getPageControl() -> UIPageControl {
        return self.pageControl
    }
    
    func updateWrapperOnboardingController(_ controller: WrapperBaseOnboardingViewController) -> Void {
        lazy var wrapperOnboardingView: UIView = {
            guard let vw = controller.view else { return .init() }
            vw.translatesAutoresizingMaskIntoConstraints = false
            vw.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            return vw
        }()
        
        self.addSubview(wrapperOnboardingView)
        wrapperOnboardingView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(10.0)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).inset(40.0)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(70.0)
        }
    }
    
    private func setupViews() -> Void {
        self.backgroundColor = .init(.appSecondary)
        self.addSubview(self.nextButton)
        self.addSubview(self.skipButton)
        self.addSubview(self.getStartedButton)
        self.addSubview(self.pageControl)
        
        self.nextButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).inset(10.0)
        }
        
        self.skipButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).inset(10.0)
        }
        
        self.getStartedButton.snp.makeConstraints { make in
            make.width.equalTo(150.0)
            make.height.equalTo(50.0)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(10.0)
        }
        
        self.pageControl.snp.makeConstraints { make in
            make.height.equalTo(30.0)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(5.0)
        }
    }
}

#if DEBUG
@available(iOS 13, *)
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        ViewPreview(OnboardingView())
            .edgesIgnoringSafeArea(.all)
    }
}
#endif
