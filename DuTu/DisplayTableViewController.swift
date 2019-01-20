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
    
    @IBAction func addItem(_ sender: Any) {
        
        if self.updateItemVC == nil {
            self.updateItemVC = (storyboard!.instantiateViewController(withIdentifier: "EditDoTooVC") as! UpdateItemViewController)
        }
        if let updateItemVC = self.updateItemVC {
            let newEntry = model!.newItem() //
            updateItemVC.item = newEntry
            updateItemVC.isAdding = true
            updateItemVC.navigationItem.title = "Enter New DoToo"
            updateItemVC.navigationItem.leftBarButtonItem =
                UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(goBack))
            let navController = UINavigationController(rootViewController: updateItemVC)
            present(navController, animated: false, completion: nil)
        }
    }
    @objc func goBack(){
        dismiss(animated: true, completion: nil)
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
    
}

extension DisplayTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = model?.data()[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (model?.data().count)!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedIndex = indexPath.row
        
        //        performSegue(withIdentifier: "UpdateVC", sender: self)
        
        if self.updateItemVC == nil {
            self.updateItemVC = (storyboard!.instantiateViewController(withIdentifier: "EditDoTooVC") as! UpdateItemViewController)
        }
        if let updateItemVC = self.updateItemVC {
            //        let updateItemVC = storyboard!.instantiateViewController(withIdentifier: "EditDoTooVC") as! UpdateItemViewController
            updateItemVC.isAdding = false
            updateItemVC.navigationItem.title = "Update Your DoToo"
            updateItemVC.navigationItem.leftBarButtonItem =
                UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(goBack))
            updateItemVC.item = model!.data()[selectedIndex!]
            let navController = UINavigationController(rootViewController: updateItemVC)
            present(navController, animated: false, completion: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            
            let item = self.model?.data()[indexPath.row]
            self.model!.context.delete(item!)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            //            self.model?.data().remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
        
        let share = UITableViewRowAction(style: .default, title: "Share") { (action, indexPath) in
            // delete item at indexPath
            
            print("Share")
            
        }
        
        delete.backgroundColor = UIColor(red: 0/255, green: 177/255, blue: 106/255, alpha: 1.0)
        share.backgroundColor = UIColor(red: 54/255, green: 215/255, blue: 183/255, alpha: 1.0)
        
        
        return [delete,share]
        
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "UpdateVC" {
    //            let updateVC = segue.destination as! ViewItemViewController
    //            updateVC.item = model!.data()[selectedIndex!]
    //
    //        }
    //    }
    
    
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
