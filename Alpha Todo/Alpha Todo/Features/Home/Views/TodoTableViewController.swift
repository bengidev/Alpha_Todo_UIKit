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
    
    // MARK: Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.setupController()
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupController()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
    
    // MARK: Functionalities
    private func setupController() -> Void {
        self.tableView = AppViewFactory.buildTableView()
        self.tableView.allowsSelection = false
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(
            TodoTableViewCell.self,
            forCellReuseIdentifier: TodoTableViewCell.identifier
        )
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 100
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoTableViewCell.identifier, for: indexPath) as? TodoTableViewCell else { return .init() }

        // Configure the cell...
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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