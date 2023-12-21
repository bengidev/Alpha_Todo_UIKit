//
//  HomeViewModel.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 21/12/23.
//

import Foundation

final class HomeViewModel {
    private(set) var categories: [Category] = [
        .init(name: "Personal", imageName: "person.fill", isSelected: false),
        .init(name: "Work", imageName: "tv.fill", isSelected: false),
        .init(name: "Health", imageName: "heart.fill", isSelected: false),
        .init(name: "Finance", imageName: "dollarsign.fill", isSelected: false),
        .init(name: "Study", imageName: "book.fill", isSelected: false),
        .init(name: "Social", imageName: "person.3.fill", isSelected: false),
    ]
    
}
