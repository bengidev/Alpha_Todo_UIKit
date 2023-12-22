//
//  OnboardingViewModel.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 23/12/23.
//

import UIKit

final class OnboardingViewModel: NSObject {
    private(set) var pages: [UIViewController] = [
        BaseOnboardingViewController(
            image: "Rocket",
            title: "Your Personal Productivity Assistant Has Arrived",
            body: "Say hello to your new productivity assistant. Let our app help you tackle tasks with ease. From reminders to collaboration, we've got you covered"
        ),
        BaseOnboardingViewController(
            image: "MakeThingsHappen",
            title: "Elevate Your Task Management Experience Today",
            body: "Elevate your task management experience with our feature-rich app. Discover tools to boost efficiency and stay on top of your to-do list. Welcome to a more productive you"
        ),
        BaseOnboardingViewController(
            image: "YouCanDoIt",
            title: "Your Gateway to Organized Living Starts Now",
            body: "Step through the gateway to organized living. Our app is your key to a clutter-free and productive lifestyle. Start your journey to organized living now"
        ),
    ]
    
    @MainActor
    func setHasCompletedOnboarding(to hasCompleted: Bool) -> Void {
        UserDefaults.standard.setValue(
            hasCompleted,
            forKey: AppUserDefaults.onboarding.rawValue
        )
    }
}
