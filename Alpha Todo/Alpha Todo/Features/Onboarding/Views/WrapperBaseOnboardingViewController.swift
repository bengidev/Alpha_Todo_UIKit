//
//  WrapperBaseOnboardingViewController.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 19/12/23.
//

import SwiftUI
import UIKit

class WrapperBaseOnboardingViewController: UIPageViewController {
    // MARK: Properties
    private var pageControl: UIPageControl?
    private var pages: [UIViewController]?
    
    // MARK: Initializers
    init(pageControl: UIPageControl? = nil, pages: [UIViewController]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: .none)
        self.pageControl = pageControl
        self.pages = pages
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Lifecycles
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupData()
    }
    
    // MARK: Functions
    private func setupData() -> Void {
        self.dataSource = self
        self.delegate = self

        // Set initial viewController to be displayed
        // Note: We are not passing in all the viewControllers here. Only the one to be displayed.
        self.setViewControllers([pages?[0] ?? .init()], direction: .forward, animated: true)
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
        guard let pages = self.pages else { return }
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        
        self.pageControl?.currentPage = currentIndex
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
