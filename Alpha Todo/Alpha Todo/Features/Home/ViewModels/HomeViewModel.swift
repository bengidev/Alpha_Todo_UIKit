//
//  HomeViewModel.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 21/12/23.
//

import Foundation

@MainActor
final class HomeViewModel {
    private(set) var tasks: [Task] = []
    private(set) var systemImageNames: [String] = [
        "person.fill",
        "house.fill",
        "music.note.list",
        "desktopcomputer",
        "car.fill",
        "heart.circle.fill",
        "cart.fill",
        "play.rectangle.fill",
        "cloud.sun.rain.fill",
    ]
    
    func addNewTask(_ task: Task) -> Void {
        var tempTask = task
        tempTask.category.imageName = self.randomSystemName()
        
        print("Temp Task: \(tempTask)")
        
        self.tasks.append(tempTask)
    }
    
    func updateCurrentTask(for indexPath: IndexPath, with todos: [Todo]) -> Void {
        self.tasks[indexPath.row].addNewTodos(todos)
    }
    
    func randomSystemName() -> String {
        return self.systemImageNames.randomElement() ?? "person.fill"
    }
}
