//
//  OnboardingViewController.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 19/12/23.
//

import SnapKit
import SwiftUI
import UIKit

final class OnboardingViewController: UIViewController {
    // MARK: Properties
    private var onboardingView = OnboardingView()
    private var onboardingViewModel = OnboardingViewModel()
    
    // MARK: Initializers
    init() { super.init(nibName: nil, bundle: nil) }
    
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
    
    // MARK: Lifecycles
    override func loadView() {
        super.loadView()
        self.setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Functions
    private func setupViews() -> Void {
        self.view = self.onboardingView
        
        self.setupWrapperOnboardingController()
    }
    
    private func setupWrapperOnboardingController() -> Void {
        let wrapperOnboardingController = WrapperBaseOnboardingViewController(
            pageControl: self.onboardingView.getPageControl(),
            pages: self.onboardingViewModel.pages,
            nextButton: self.onboardingView.getNextButton(),
            skipButton: self.onboardingView.getSkipButton(),
            didChangePageControlValue: self.didChangePageControlValue(_:)
        )
        
        // Include that child view controller in the parent's view controller life cycle.
        self.add(wrapperOnboardingController)
        
        self.onboardingView.getPageControl().numberOfPages = self.onboardingViewModel.pages.count
        self.onboardingView.updateWrapperOnboardingController(wrapperOnboardingController)
    }

    private func didChangePageControlValue(_ control: UIPageControl) -> Void {
        self.hasReachedEndPage(with: control) { shouldHide in
            self.skipButtonVisibility(shouldHide)
            self.pageControlVisibility(shouldHide)
            self.getStartedButtonVisibility(!shouldHide)
        }
    }
    
    private func hasReachedEndPage(with control: UIPageControl, isEndPage: (Bool) -> Void) -> Void {
        if control.currentPage == self.onboardingViewModel.pages.count - 1 {
            isEndPage(true)
        } else {
            isEndPage(false)
        }
    }
    
    private func skipButtonVisibility(_ isHidden: Bool = false) -> Void {
        UIView.animate(withDuration: 1.0) {
            self.onboardingView.getSkipButton().isHidden = isHidden
            self.onboardingView.getSkipButton().isUserInteractionEnabled = !isHidden
            self.onboardingView.layoutIfNeeded()
        }
    }
    
    private func pageControlVisibility(_ isHidden: Bool = false) -> Void {
        UIView.animate(withDuration: 1.0) {
            self.onboardingView.getPageControl().isHidden = isHidden
            self.onboardingView.getPageControl().isUserInteractionEnabled = !isHidden
            self.onboardingView.layoutIfNeeded()
        }
    }
    
    private func getStartedButtonVisibility(_ isHidden: Bool = false) -> Void {
        UIView.animate(withDuration: 1.0) {
            self.onboardingView.getGetStartedButton().isHidden = isHidden
            self.onboardingView.getGetStartedButton().isUserInteractionEnabled = !isHidden
            self.onboardingView.getGetStartedButton().addTarget(
                self,
                action: #selector(self.didTapGetStartedButton(_:)),
                for: .touchUpInside
            )
            
            self.onboardingView.layoutIfNeeded()
        }
    }
    
    @objc
    private func didTapGetStartedButton(_ sender: UIButton) -> Void {
        self.setHasCompletedOnboarding(true)
        self.navigateToHomeScreen()
    }
    
    private func setHasCompletedOnboarding(_ value: Bool) -> Void {
        self.onboardingViewModel.setHasCompletedOnboarding(to: value)
    }
    
    private func navigateToHomeScreen() -> Void {
        // Access the SceneDelegate
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        
        // Add a crossfade transition animation
        let transition = CATransition()
        transition.type = .fade
        transition.duration = 0.3
        
        // Change the rootViewController into HomeViewController
        sceneDelegate.window?.layer.add(transition, forKey: kCATransition)
        sceneDelegate.window?.rootViewController = HomeViewController()
    }
}

#if DEBUG
@available(iOS 13, *)
struct OnboardingViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview(OnboardingViewController())
            .edgesIgnoringSafeArea(.all)
    }
}
#endif
