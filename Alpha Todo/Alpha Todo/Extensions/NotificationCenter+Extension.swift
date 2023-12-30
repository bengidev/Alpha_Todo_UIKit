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
    static let HomeDidTapEditTodoButton = Notification.Name("HomeDidTapEditTodoButton")
    static let TodoSelectedTaskChanged = Notification.Name("TodoDataTaskChanged")
    static let TodoSelectedCategoryIndexPathChanged = Notification.Name("TodoSelectedCategoryIndexPathChanged")
    static let TaskDidTapSaveButton = Notification.Name("TaskDidTapSaveButton")
    static let CategoryDidTapCategoryButton = Notification.Name("CategoryDidTapCategoryButton")
    static let CategoryDataTasksChanged = Notification.Name("CategoryDataTasksChanged")
}
