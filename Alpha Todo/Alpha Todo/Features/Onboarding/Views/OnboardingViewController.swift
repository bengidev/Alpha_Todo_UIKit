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
    private var pages: [UIViewController] = []
    private var wrapperOnboardingController = WrapperBaseOnboardingViewController()
    
    
    // MARK: Views
    private lazy var skipButton: UIButton = {
        let bt = ViewFactory.buildTextButton()
        bt.setTitle("Skip", for: .normal)
        bt.setTitleColor(.appPrimary, for: .normal)
        bt.backgroundColor = .clear
        
        return bt
    }()
    
    private lazy var nextButton: UIButton = {
        let bt = ViewFactory.buildTextButton()
        bt.setTitle("Next", for: .normal)
        bt.setTitleColor(.appPrimary, for: .normal)
        bt.backgroundColor = .clear
        
        return bt
    }()
    
    private lazy var wrapperOnboardingView: UIView = {
        // Add UIPageViewController into self to be child controller
        // And self to be parent of UIPageViewController
        self.add(self.wrapperOnboardingController)
        
        guard let vw = self.wrapperOnboardingController.view else { return .init() }
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return vw
    }()

    private lazy var pageControl: UIPageControl = {
        let cl = UIPageControl()
        cl.translatesAutoresizingMaskIntoConstraints = false
        cl.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cl.pageIndicatorTintColor = .gray.withAlphaComponent(0.4)
        cl.currentPageIndicatorTintColor = .appPrimary
        cl.currentPage = 0
        cl.numberOfPages = self.pages.count
        
        return cl
    }()
    
    // MARK: Lifecycles
    override func loadView() {
        super.loadView()
        self.setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupData()
        self.updatePageControll()
        self.updateWrapperOnboardingView()
    }
    
    // MARK: Functions
    private func setupViews() -> Void {
        self.view.backgroundColor = .init(.appSecondary)
        self.view.addSubview(self.nextButton)
        self.view.addSubview(self.skipButton)
        self.view.addSubview(self.wrapperOnboardingView)
        self.view.addSubview(self.pageControl)
        
        self.nextButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).inset(10.0)
        }
        
        self.skipButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).inset(10.0)
        }

        self.wrapperOnboardingView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(10.0)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(40.0)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(40.0)
        }
        
        self.pageControl.snp.makeConstraints { make in
            make.height.equalTo(30.0)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(5.0)
        }
    }
    
    private func setupData() -> Void {
        let pageOne = BaseOnboardingViewController(
            image: "Rocket",
            title: "Your Personal Productivity Assistant Has Arrived",
            body: "Say hello to your new productivity assistant. Let our app help you tackle tasks with ease. From reminders to collaboration, we've got you covered"
        )
        let pageTwo = BaseOnboardingViewController(
            image: "MakeThingsHappen",
            title: "Elevate Your Task Management Experience Today",
            body: "Elevate your task management experience with our feature-rich app. Discover tools to boost efficiency and stay on top of your to-do list. Welcome to a more productive you"
        )
        let pageThree = BaseOnboardingViewController(
            image: "YouCanDoIt",
            title: "Your Gateway to Organized Living Starts Now",
            body: "Step through the gateway to organized living. Our app is your key to a clutter-free and productive lifestyle. Start your journey to organized living now"
        )
        
        self.pages.append(pageOne)
        self.pages.append(pageTwo)
        self.pages.append(pageThree)
    }
    
    private func updatePageControll() -> Void {
        // Remove current UIPageControl
        self.pageControl.removeFromSuperview()
        
        // Remake UIPageControl for new value
        let cl = UIPageControl()
        cl.translatesAutoresizingMaskIntoConstraints = false
        cl.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cl.pageIndicatorTintColor = .gray.withAlphaComponent(0.4)
        cl.currentPageIndicatorTintColor = .appPrimary
        cl.currentPage = 0
        cl.numberOfPages = self.pages.count
        
        // Change old UIPageControl to new value
        self.pageControl = cl
        self.view.addSubview(cl)
        
        cl.snp.makeConstraints { make in
            make.height.equalTo(30.0)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(5.0)
        }
        self.view.layoutIfNeeded()
    }
    
    private func updateWrapperOnboardingView() -> Void {
        // Remove current WrapperBaseOnboardingViewController from stack
        self.wrapperOnboardingController.remove()
        self.wrapperOnboardingView.removeFromSuperview()
        
        // Change old to new WrapperBaseOnboardingViewController
        self.wrapperOnboardingController = WrapperBaseOnboardingViewController(
            pageControl: self.pageControl,
            pages: self.pages
        )
        self.add(self.wrapperOnboardingController)
        
        // Remake view for new WrapperBaseOnboardingViewController
        guard let vw = self.wrapperOnboardingController.view else { return }
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.view.addSubview(vw)
        vw.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(10.0)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(40.0)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(40.0)
        }
        self.view.layoutIfNeeded()
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
