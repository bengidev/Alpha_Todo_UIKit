//
//  HomeViewModel.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 21/12/23.
//

import Foundation

@MainActor
final class HomeViewModel {
    private(set) var tasks: [Task] = [
        .init(
            category: .init(name: "Personal", imageName: "person.fill", isSelected: false),
            todos: [
                .init(
                    title: "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...",
                    timeStart: .init(),
                    timeEnd: .init(),
                    description: "Duis non odio arcu. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Vestibulum feugiat neque vitae nisl mattis, quis efficitur libero gravida. Quisque faucibus magna eu hendrerit placerat. Mauris laoreet dictum nisl, quis vestibulum magna. Proin vehicula, nulla at aliquam efficitur, nibh dui fringilla erat, pretium aliquam odio tellus maximus augue. Donec malesuada odio at neque sollicitudin, id cursus mauris euismod.",
                    isImportant: true,
                    hasCompleted: false
                ),
                .init(
                    title: "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...",
                    timeStart: .init(),
                    timeEnd: .init(),
                    description: "Duis non odio arcu. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Vestibulum feugiat neque vitae nisl mattis, quis efficitur libero gravida. Quisque faucibus magna eu hendrerit placerat. Mauris laoreet dictum nisl, quis vestibulum magna. Proin vehicula, nulla at aliquam efficitur, nibh dui fringilla erat, pretium aliquam odio tellus maximus augue. Donec malesuada odio at neque sollicitudin, id cursus mauris euismod.",
                    isImportant: false,
                    hasCompleted: false
                ),
                .init(
                    title: "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...",
                    timeStart: .init(),
                    timeEnd: .init(),
                    description: "Duis non odio arcu. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Vestibulum feugiat neque vitae nisl mattis, quis efficitur libero gravida. Quisque faucibus magna eu hendrerit placerat. Mauris laoreet dictum nisl, quis vestibulum magna. Proin vehicula, nulla at aliquam efficitur, nibh dui fringilla erat, pretium aliquam odio tellus maximus augue. Donec malesuada odio at neque sollicitudin, id cursus mauris euismod.",
                    isImportant: true,
                    hasCompleted: true
                ),
            ]
        ),
        .init(
            category: .init(name: "Work", imageName: "tv.fill", isSelected: false),
            todos: [.init(
                title: "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...",
                timeStart: .init(),
                timeEnd: .init(),
                description: "Duis non odio arcu. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Vestibulum feugiat neque vitae nisl mattis, quis efficitur libero gravida. Quisque faucibus magna eu hendrerit placerat. Mauris laoreet dictum nisl, quis vestibulum magna. Proin vehicula, nulla at aliquam efficitur, nibh dui fringilla erat, pretium aliquam odio tellus maximus augue. Donec malesuada odio at neque sollicitudin, id cursus mauris euismod.",
                isImportant: false,
                hasCompleted: false
            ),
            ]
        ),
    ]
    
    func addNewTask(_ task: Task) -> Void {
        self.tasks.append(task)
    }
    
    func updateCurrentTask(for indexPath: IndexPath, with todos: [Todo]) -> Void {
        self.tasks[indexPath.row].addNewTodos(todos)
    }
}
