//
//  WrapperBaseOnboardingViewController.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 19/12/23.
//

import SwiftUI
import UIKit

final class WrapperBaseOnboardingViewController: UIPageViewController {
    // MARK: Properties
    private var pageControl: UIPageControl?
    private var pages: [UIViewController]?
    private var nextButton: UIButton?
    private var skipButton: UIButton?
    private var didChangePageControlValue: ((UIPageControl) -> Void)?
    
    // MARK: Initializers
    init(
        pageControl: UIPageControl? = nil,
        pages: [UIViewController]? = nil,
        nextButton: UIButton? = nil,
        skipButton: UIButton? = nil,
        didChangePageControlValue: ((UIPageControl) -> Void)? = nil
    ) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: .none)
        
        self.pageControl = pageControl
        self.pages = pages
        self.nextButton = nextButton
        self.skipButton = skipButton
        self.didChangePageControlValue = didChangePageControlValue
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
    
    // MARK: Lifecycles
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupDataDelegate()
        self.pageControl?.addTarget(
            self,
            action: #selector(self.didTapPageControl(_:)),
            for: .valueChanged
        )
        self.nextButton?.addTarget(
            self,
            action: #selector(self.didTapNextButton(_:)),
            for: .touchUpInside
        )
        self.skipButton?.addTarget(
            self,
            action: #selector(self.didTapSkipButton(_:)),
            for: .touchUpInside
        )
    }
    
    // MARK: Functions
    private func setupDataDelegate() -> Void {
        self.dataSource = self
        self.delegate = self
        
        // Set initial viewController to be displayed
        // Note: We are not passing in all the viewControllers here. Only the one to be displayed.
        self.setViewControllers([self.pages?.first ?? .init()], direction: .forward, animated: true)
    }
    
    @objc
    private func didTapPageControl(_ sender: UIPageControl) -> Void {
        guard let pageControl = self.pageControl else { return }
        guard let pages = self.pages else { return }
        
        self.goToSpecificPage(index: sender.currentPage, ofControllers: pages)
        self.didChangePageControlValue?(pageControl)
    }

    @objc
    private func didTapNextButton(_ sender: UIButton) -> Void {
        guard let pageControl = self.pageControl else { return }
        
        self.goToNextPage()
        self.didChangePageControlValue?(pageControl)
    }
    
    @objc
    private func didTapSkipButton(_ sender: UIButton) -> Void {
        guard let pageControl = self.pageControl else { return }
        guard let pages = self.pages else { return }
        
        self.goToSpecificPage(index: pages.count - 1, ofControllers: pages)
        self.didChangePageControlValue?(pageControl)
    }
}

// MARK: Datasources
extension WrapperBaseOnboardingViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let pages = self.pages else { return nil }
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex == 0 {
            return pages.last               // wrap to last
        } else {
            return pages[currentIndex - 1]  // go previous
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let pages = self.pages else { return nil }
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]  // go next
        } else {
            return pages.first              // wrap to first
        }
    }
}

// MARK: Delegates
extension WrapperBaseOnboardingViewController: UIPageViewControllerDelegate {
    // How we keep our pageControl in sync with viewControllers
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let pageControl = self.pageControl else { return }
        guard let pages = self.pages else { return }
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        
        // Pass back data into initializers
        pageControl.currentPage = currentIndex
        
        // Pass callback with UIPageControl current value 
        // when UIPageViewController finish animated
        self.didChangePageControlValue?(pageControl)
    }
}

extension WrapperBaseOnboardingViewController {
    func goToNextPage(
        animated: Bool = true,
        completion: ((Bool) -> Void)? = nil
    ) -> Void {
        guard let pageControl = self.pageControl else { return }
        guard let pages = self.pages else { return }
        guard let currentPage = self.viewControllers?
            .first else { return }
        guard let nextPage = self.dataSource?
            .pageViewController(self, viewControllerAfter: currentPage) else { return }
        
        self.setViewControllers(
            [nextPage],
            direction: .forward,
            animated: animated,
            completion: completion
        )
        
        if pageControl.currentPage < pages.count - 1 {
            pageControl.currentPage += 1
        } else {
            pageControl.currentPage = 0
        }
    }
    
    func goToPreviousPage(
        animated: Bool = true,
        completion: ((Bool) -> Void)? = nil
    ) -> Void {
        guard let pageControl = self.pageControl else { return }
        guard let currentPage = self.viewControllers?
            .first else { return }
        guard let previousPage = self.dataSource?
            .pageViewController(self, viewControllerBefore: currentPage) else { return }
        
        self.setViewControllers(
            [previousPage],
            direction: .forward,
            animated: animated,
            completion: completion
        )
        
        pageControl.currentPage -= 1
    }
    
    func goToSpecificPage(
        index: Int,
        ofControllers pages: [UIViewController],
        animated: Bool = true,
        completion: ((Bool) -> Void)? = nil
    ) -> Void {
        guard let pageControl = self.pageControl else { return }
        
        self.setViewControllers(
            [pages[index]],
            direction: .forward,
            animated: animated,
            completion: completion
        )
        
        pageControl.currentPage = index
    }
}

#if DEBUG
@available(iOS 13, *)
struct WrapperBaseOnboardingViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview(WrapperBaseOnboardingViewController())
            .edgesIgnoringSafeArea(.all)
    }
}
#endif
