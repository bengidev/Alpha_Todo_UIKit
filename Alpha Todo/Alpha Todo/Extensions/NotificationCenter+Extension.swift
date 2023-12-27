//
//  NotificationCenter+Extension.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 26/12/23.
//

import Foundation

extension Notification.Name {
    static let HomeSelectedTask = Notification.Name("HomeSelectedTask")
    static let HomeDidTapAddButton = Notification.Name("HomeDidTapAddButton")
    static let TodoDataTaskChanged = Notification.Name("TodoDataTaskChanged")
    static let TaskDidTapSaveButton = Notification.Name("TaskDidTapSaveButton")
    static let CategoryDidTapCategoryButton = Notification.Name("CategoryDidTapCategoryButton")
    static let CategoryDataTasksChanged = Notification.Name("CategoryDataTasksChanged")
}
