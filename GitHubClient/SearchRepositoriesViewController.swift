//
//  SearchRepositoriesViewController.swift
//  GitHubClient
//
//  Created by Annemarie Ketola on 1/19/15.
//  Copyright (c) 2015 Up Early, LLC. All rights reserved.
//

import UIKit

class SearchRepositoriesViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  let networkController = NetworkController()

    override func viewDidLoad() {
        super.viewDidLoad()
      self.tableView.dataSource = self
      self.searchBar.delegate = self
      self.networkController.fetchRepositoriesForSearchTerm("Swift", callback: { (items, errorDescription) -> (Void) in
      })

        // Do any additional setup after loading the view.
    }
  
  // UITableViewDataSource
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("REPO_CELL", forIndexPath: indexPath) as UITableViewCell
    return cell
  }
  
  // UISearchBarDelegate
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    println(searchBar.text)
    searchBar.resignFirstResponder()
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
