//
//  ViewController.swift
//  ToDoList_Example
//
//  Created by Santhosh Konduru on 04/10/23.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableView.self, forCellReuseIdentifier: "cell")
        
        return table
    }()
    

    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        // Initialize Fetch Request
        let fetchRequest = ToDoListItem.createFetchRequest()
        
        // Add Sort Descriptors
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Initialize Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    private var models = [ToDoListItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "To Do List"
        view.addSubview(tableView)
        getAllItems()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapOnAdd))
    }
    
    @objc private func didTapOnAdd() {
        
        self.presentAlert(alertTitle: "New Item", message: "Enter new Item", buttonTitle: "Submit", preferredStyle: .alert) { [weak self] text in
            self?.createItem(name: text)
        }
        
    }
    
    func presentAlert(alertTitle: String, message: String?, buttonTitle: String, preferredStyle: UIAlertController.Style, completion: @escaping (_ text: String) -> ()) {
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: preferredStyle)
        
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .cancel, handler: {  _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
                return
            }
            
            completion(text)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.presentAlert(alertTitle: "Edit Item", message: "Edit Your Item", buttonTitle: "Save", preferredStyle: .alert) { text in
            
        }
    }
    
    
    // Core Data
    
    func getAllItems() {
//        let request = ToDoListItem.createFetchRequest()
//        let sort = NSSortDescriptor(key: "createdAt", ascending: false)
//        request.sortDescriptors = [sort]
//        do {
//            
//            models = try context.fetch(request)
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }catch {
//            // error
//        }
    }
    
    func saveContext() {
       
        do {
            try context.save()
            getAllItems()
        }catch {
            
        }
    }
    
    func createItem(name: String) {
        let newItem = ToDoListItem(context: context)
        newItem.name = name
        newItem.createdAt = Date()
        
        saveContext()
    }
    
    func deleteItem(item: ToDoListItem) {
        context.delete(item)
        
        saveContext()
    }
    
    func updateItem(item: ToDoListItem, name: String) {
        
        item.name = name
        
        saveContext()
        
    }


}

