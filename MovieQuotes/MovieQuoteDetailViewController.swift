//
//  MovieQuoteDetailViewController.swift
//  MovieQuotes
//
//  Created by CSSE Department on 4/3/18.
//  Copyright © 2018 alangavr. All rights reserved.
//

import UIKit

class MovieQuoteDetailViewController: UIViewController {
    
    var movieQuote: MovieQuote?


    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var movieLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,
                                                            target: self,
                                                            action: #selector(showEditDialog))

        // Do any additional setup after loading the view.
    }
    
    @objc func showEditDialog () {
        let alertController = UIAlertController(title: "Create a new movie quote", message: "HEYOOOO", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Quote"
            textField.text = self.movieQuote?.quote
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Movie Title"
            textField.text = self.movieQuote?.movie
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler:nil)
        
        let createQuoteAction = UIAlertAction(title: "Create Edit", style: UIAlertActionStyle.default) { (action) in
            let quoteTextField = alertController.textFields![0]
            let movieTextField = alertController.textFields![1]
            print(quoteTextField.text!)
            print(movieTextField.text!)
            
            self.movieQuote?.quote = quoteTextField.text!
            self.movieQuote?.movie = movieTextField.text!
            self.updateView()
            }
        
        alertController.addAction(cancelAction)
        alertController.addAction(createQuoteAction)
        present(alertController, animated: true, completion: nil)
            
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ _animated: Bool) {
        super.viewWillAppear(_animated)
        updateView()
    }
    
    func updateView() {
        quoteLabel.text = movieQuote?.quote
        movieLabel.text = movieQuote?.movie
    }


}
