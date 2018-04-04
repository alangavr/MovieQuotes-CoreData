//
//  MovieQuotesTableViewController.swift
//  MovieQuotes
//
//  Created by CSSE Department on 3/29/18.
//  Copyright © 2018 alangavr. All rights reserved.
//

import UIKit
import CoreData

class MovieQuotesTableViewController: UITableViewController {
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let movieQuotesCellIdentifier = "MovieQuotesCell"
    let noMovieQuoteCellIdentifier = "NoMovieQuoteCell"
    let showDetailSequeIdentifier = "ShowDetailSeque"
    var movieQuotes = [MovieQuote]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddDialog))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateMovieQuoteArray()
        tableView.reloadData()
    }
    
    @objc func showAddDialog () {
        let alertController = UIAlertController(title: "Create a new movie quote", message: "HEYOOOO", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Quote"
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Movie Title"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler:nil)
        
        let createQuoteAction = UIAlertAction(title: "Create Quote", style: UIAlertActionStyle.default) { (action) in
            let quoteTextField = alertController.textFields![0]
            let movieTextField = alertController.textFields![1]
            print(quoteTextField.text!)
            print(movieTextField.text!)
            
//            let movieQuote = MovieQuote(quote: quoteTextField.text!, movie: movieTextField.text!)
//            self.movieQuotes.insert(movieQuote, at: 0)
            
            //TODO: come back here once we have access to the context 
            let newMovieQuote = MovieQuote(context: self.context)
            newMovieQuote.quote = quoteTextField.text!
            newMovieQuote.movie = movieTextField.text!
            self.save()
            self.updateMovieQuoteArray()
//
            //we want animations!
            self.tableView.reloadData()
            
//            if (self.movieQuotes.count == 1) {
//                self.tableView.reloadData()
//
//            } else {
//                self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: UITableViewRowAnimation.top)
//                //no animations here
//                // self.tableView.reloadData()
//            }
        
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(createQuoteAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    func updateMovieQuoteArray() {
        //get data from out of core data
        //make a fetch request
        //execute the request in a try/catch block
        
        let request: NSFetchRequest<MovieQuote> = MovieQuote.fetchRequest()
        do {
            movieQuotes = try context.fetch(request)
        } catch {
            fatalError("Unresolved Core Data error \(error)")
        }
    }
    
    func save() {
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        if movieQuotes.count == 0 {
            super.setEditing(false, animated: animated)
        } else {
            super.setEditing(editing, animated: animated)
        }
    }
    
    // MARK: - Table view data source
    
    //(defaults to 1)
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return max(movieQuotes.count, 1)
    }
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell
        
        if movieQuotes.count == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: noMovieQuoteCellIdentifier, for: indexPath)
            return cell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: movieQuotesCellIdentifier, for: indexPath)
     
            // Configure the cell...
            cell.textLabel?.text = movieQuotes[indexPath.row].quote
            cell.detailTextLabel?.text = movieQuotes[indexPath.row].movie
            return cell
        }
     }
    
    
    
     // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return (movieQuotes.count > 0)
    }
    
    
    
     // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            movieQuotes.remove(at: indexPath.row)
            if (movieQuotes.count == 0){
                tableView.reloadData()
                self.setEditing(false, animated: true)
            } else {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            print(movieQuotes)
        }
    }
    
    
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        if segue.identifier == showDetailSequeIdentifier {
            //Goal: pass the selected movie quote to the detail view controller
            if let indexPath = tableView.indexPathForSelectedRow {
                (segue.destination as! MovieQuoteDetailViewController).movieQuote = movieQuotes[indexPath.row]
            }
            
            
        }
        
     }
    
    
}
