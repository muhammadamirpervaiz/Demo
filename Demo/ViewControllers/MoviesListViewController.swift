//
//  MoviesListViewController.swift
//  Demo
//
//  Created by Muhammad Amir Pervaiz on 5/28/18.
//  Copyright © 2018 Muhammad Amir Pervaiz. All rights reserved.
//

import UIKit

class MoviesListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    internal var viewModel: MoviesListViewModel!
    
    override func viewDidLoad() {
        
        self.searchBar.delegate = self
        tableView.keyboardDismissMode = .onDrag
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        viewModel = MoviesListViewModel.init(getEnvironment())
        
        self.bindViewModel()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func bindViewModel() {
        self.viewModel.reloadTableView = {[unowned self] in
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.count()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellIdentifier = "MovieCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MovieCell  else {
            fatalError("The dequeued cell is not an instance of TimeLineTableViewCell.")
        }
        cell.configureWith(self.viewModel.getObjectAt(indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
}

extension MoviesListViewController: UISearchBarDelegate {
    
    // called when keyboard search button pressed
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        self.viewModel.fetchMoviesList(searchBar.text!)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool // return NO to not become first responder
    {
        return true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) // called when text starts editing
    {
        
    }
}
