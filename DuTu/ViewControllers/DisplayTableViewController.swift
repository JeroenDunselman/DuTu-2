//
//  DisplayTableViewController.swift
//  CoreDataExample
//
//  Created by Farhan Syed on 4/16/17.
//  Copyright © 2017 Farhan Syed. All rights reserved.
//

import UIKit

class DisplayTableViewController: UITableViewController, UISearchBarDelegate {
    
    var selectedIndex: Int!
    var model: DisplayViewModel?
    var updateItemVC: UpdateItemViewController?
    var viewItemVC: ViewItemViewController?
    
    @IBAction func addItem(_ sender: Any) {
        updateItemDetails(item: nil)
    }
    
    @IBOutlet weak var buttonToggle: UIBarButtonItem!
    @IBAction func buttonTogglePublicPrivate(_ sender: Any) {
        
        model?.contentModeAll = buttonToggle.title == "All DoToos"
        model?.fetchData()
        self.tableView.reloadData()
        
        buttonToggle.title = buttonToggle.title == "All DoToos" ? "My Dotoos" : "All DoToos"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = DisplayViewModel(client: self)
        model?.contentModeAll = true
        buttonToggle.title = "My Dotoos" //if exist
        createSearchBar()
        
        self.tableView.estimatedRowHeight = 10
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        model?.fetchData()
        self.tableView.reloadData()
    }

    func showItemDetails() {
        
        if self.viewItemVC == nil {
            self.viewItemVC = (storyboard!.instantiateViewController(withIdentifier: "viewItemVC") as! ViewItemViewController)
        }
        
        if let viewItemVC = self.viewItemVC {
            viewItemVC.item = DoTooItem(item: model!.data()[selectedIndex!])
            viewItemVC.navigationItem.title = viewItemVC.item.data.name //"Viewing Someone's DoToo"
            
            let navigationController = UINavigationController(rootViewController: viewItemVC)
            present(navigationController, animated: false, completion: nil)
        }
    }
    
    func updateItemDetails(item: Item?) {
        var updateItem: DoTooItem?
        var title = ""
        
        if item == nil {
            updateItem = model!.newItem()
            title = "New DoToo"
        } else {
            updateItem = DoTooItem(item: item!)
            title = item!.name!
        }
        
        if self.updateItemVC == nil {
            self.updateItemVC = (storyboard!.instantiateViewController(withIdentifier: "EditDoTooVC") as! UpdateItemViewController)
        }
        
        if let updateItemVC = self.updateItemVC {
            updateItemVC.isAdding = item == nil
            updateItemVC.title = title
            updateItemVC.navigationItem.title = title //
            updateItemVC.navigationItem.leftBarButtonItem =
                UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(goBack))
            updateItemVC.item = updateItem
            
            let navigationController = UINavigationController(rootViewController: updateItemVC)
            present(navigationController, animated: false, completion: nil)
        }
    }
    
    @objc func goBack(){
        dismiss(animated: true, completion: nil)
    }
}

extension DisplayTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        let cell = UITableViewCell(style: .subtitle , reuseIdentifier: cellIdentifier)

        let item = DoTooItem(item: (model?.data()[indexPath.row])!)
        cell.textLabel?.text = item.text()
        cell.detailTextLabel?.text = item.detailText()
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (model?.data().count)!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedIndex = indexPath.row

        showItemDetails()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        self.selectedIndex = indexPath.row
        
        // no edit/delete action offered unless content filtered userowned items
        if !(model?.contentModeAll)! {
            
            let delete = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
                // delete item at indexPath
                self.model?.delete(forRow: indexPath.row)
                tableView.reloadData()
            }
            delete.backgroundColor = UIColor(red: 0/255, green: 177/255, blue: 106/255, alpha: 1.0)
            
            let edit = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
                // share item at indexPath
                self.updateItemDetails(item: self.model!.data()[self.selectedIndex!]) //title: "Update Your DoToo")
            }
            edit.backgroundColor = UIColor(red: 54/255, green: 215/255, blue: 183/255, alpha: 1.0)
            
            return [delete, edit]
            
        } else {
            
            let show = UITableViewRowAction(style: .default, title: "Show") { (action, indexPath) in
                // share item at indexPath
                self.showItemDetails()
            }
            show.backgroundColor = UIColor(red: 54/255, green: 215/255, blue: 183/255, alpha: 1.0)
            
            return [show]
        }
    }
    
    func createSearchBar() {
        
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        
        self.navigationItem.titleView = searchBar
        
    }
    
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //        if searchText.isEmpty {
        //            model.data() = items
        //
        //        } else {
        //
        //            model.data() = items.filter { ($0.name?.lowercased().contains(searchText.lowercased()))! }
        //
        //        }
        //
        //        DispatchQueue.main.async {
        //            self.tableView.reloadData()
        //        }
        
    }
    
}
