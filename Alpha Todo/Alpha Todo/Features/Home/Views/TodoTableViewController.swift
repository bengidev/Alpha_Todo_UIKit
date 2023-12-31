//
//  TodoTableViewController.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 24/12/23.
//

import SnapKit
import SwiftUI
import UIKit

final class TodoTableViewController: UITableViewController {
    // MARK: Properties
    private var homeViewModel: HomeViewModel?
    private var selectedCategoryIndexPath: IndexPath = .init(row: 0, section: 0)
    
    // MARK: Computer Properties
    private var tasks: [CDAlphaTask]? {
        return self.homeViewModel?.tasks
    }
    
    private var selectedTask: CDAlphaTask? {
        guard let tasks, !tasks.isEmpty else { return nil }
        
        return tasks[self.selectedCategoryIndexPath.row]
    }
    
    private var todos: [CDTodo]? {
        return self.selectedTask?.wrappedTodos
    }
    
    // MARK: Initializers
    init(homeViewModel: HomeViewModel? = nil) {
        super.init(nibName: nil, bundle: nil)
        
        self.homeViewModel = homeViewModel
        self.homeViewModel?.fetchTasks()
        self.tableView.reloadData()
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
        
        self.setupController()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.selectedTaskChanged(_:)),
            name: .TodoSelectedTaskChanged,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.selectedCategoryIndexPathChanged(_:)),
            name: .TodoSelectedCategoryIndexPathChanged,
            object: nil
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.reloadData()
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
    
    // MARK: Functionalities
    private func setupController() -> Void {
        self.tableView = AppViewFactory.buildTableView(with: .plain)
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(
            TodoTableViewCell.self,
            forCellReuseIdentifier: TodoTableViewCell.identifier
        )
    }
    
    @objc
    private func selectedTaskChanged(_ notification: Notification) -> Void {
        self.tableView.reloadData()
        print("New Notification: \(notification.name)")
    }
    
    @objc
    private func selectedCategoryIndexPathChanged(_ notification: Notification) -> Void {
        if let indexPath = notification.object as? IndexPath {
            self.selectedCategoryIndexPath = indexPath
            self.tableView.reloadData()
            print("New IndexPath: \(indexPath)")
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let todos, !todos.isEmpty else { return 0 }
        
        return todos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let todos, !todos.isEmpty else { return .init() }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoTableViewCell.identifier, for: indexPath) as? TodoTableViewCell else { return .init() }

        // Configure the cell...
        cell.updateTodoCell(with: todos[indexPath.row])
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let selectedTask else { return }
        
        if editingStyle == .delete {
            // Delete the row from the data source
            self.homeViewModel?.removeTodo(from: selectedTask, with: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        guard let selectedTask else { return }

        self.homeViewModel?.swapTodo(from: selectedTask, from: fromIndexPath, to: to)
        
        tableView.reloadData()
    }

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
}

#if DEBUG
@available(iOS 13, *)
struct TodoTableViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview(TodoTableViewController())
            .edgesIgnoringSafeArea(.all)
    }
}
#endif
