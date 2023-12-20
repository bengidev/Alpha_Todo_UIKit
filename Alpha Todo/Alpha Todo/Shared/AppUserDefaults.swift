//
//  AppUserDefaults.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 20/12/23.
//

import Foundation

enum AppUserDefaults: String, Hashable, Identifiable, CaseIterable {
    var id: Self { return self }
    case onboarding
}
