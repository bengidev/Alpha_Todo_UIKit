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
    private var selectedTask: Task?
    private var selectedCategoryIndexPath: IndexPath?
    
    // MARK: Initializers
    init(homeViewModel: HomeViewModel? = nil) {
        super.init(nibName: nil, bundle: nil)
        
        self.homeViewModel = homeViewModel
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
        if let task = notification.object as? Task {
            self.selectedTask = task
            self.tableView.reloadData()
            print("New Task: \(task)")
        }
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
        guard let tasks = self.homeViewModel?.tasks, !tasks.isEmpty else { return 0 }
        return tasks[self.selectedCategoryIndexPath?.row ?? 0].todos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tasks = self.homeViewModel?.tasks, !tasks.isEmpty else { return .init() }
        guard let selectedCategoryIndexPath else { return .init() }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoTableViewCell.identifier, for: indexPath) as? TodoTableViewCell else { return .init() }

        // Configure the cell...
        cell.updateTodoCell(with: tasks[selectedCategoryIndexPath.row].todos[indexPath.row])
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let selectedCategoryIndexPath else { return }
        
        if editingStyle == .delete {
            // Delete the row from the data source
            self.homeViewModel?.removeTodo(with: selectedCategoryIndexPath, from: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        guard var tasks = self.homeViewModel?.tasks, !tasks.isEmpty else { return }
        guard let selectedCategoryIndexPath else { return }
        
        tasks[selectedCategoryIndexPath.row].todos.swapAt(fromIndexPath.row, to.row)
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
