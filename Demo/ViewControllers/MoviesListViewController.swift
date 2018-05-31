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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    internal var viewModel: MoviesListViewModel!
    var footerView: UIView!
    var loaderView: UIActivityIndicatorView!

    fileprivate var cellHeights: [Int: [Int: CGFloat]] = [:]

    override func viewDidLoad() {
        
        self.searchBar.becomeFirstResponder()
        viewModel = MoviesListViewModel.init(getEnvironment())

        self.searchBar.delegate = self
        tableView.keyboardDismissMode = .onDrag
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.tableView.frame.size.width, height: 30))
        loaderView = UIActivityIndicatorView.init()
        loaderView.center = CGPoint.init(x: (self.tableView.frame.size.width - 10)/2, y: 10)
        loaderView.hidesWhenStopped = true
        loaderView.activityIndicatorViewStyle = .gray
        footerView.addSubview(loaderView)
        self.tableView.tableFooterView = footerView
        
        self.bindViewModel()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func bindViewModel() {
        
        self.viewModel.reloadTableView = {[unowned self] in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            }
        }
        
        self.viewModel.updateTableView = { [unowned self] (array) in
            DispatchQueue.main.async {
                self.tableView.insertRows(at: array, with: .fade)
                self.tableView.setContentOffset(self.tableView.contentOffset, animated: false)
                self.loaderView.stopAnimating()
            }
        }
        
        self.viewModel.errorOccured = { [unowned self] (message) in
            DispatchQueue.main.async {
                self.showAlertView(message)
                self.activityIndicator.stopAnimating()
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlertView(_ message: String){
        let alert = UIAlertController(title: "Demo", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
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
        if (self.viewModel.cellType == .Movies) {
            let cellIdentifier = "MovieCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MovieCell  else {
                fatalError("The dequeued cell is not an instance of MovieCell.")
            }
            cell.configureWith(self.viewModel.getObjectAt(indexPath.row))
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "suggesstionsCell", for: indexPath)
            cell.textLabel?.text = self.viewModel.getSuggesstionAt(indexPath.row)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (self.viewModel.cellType == .Suggesstions) {
            let query = self.viewModel.getSuggesstionAt(indexPath.row)
            self.activityIndicator.startAnimating()
            
            self.viewModel.resetPagination()
            self.viewModel.setCellType(.Movies)
            self.tableView.reloadData()
            
            self.viewModel.fetchMoviesList(query)
            self.searchBar.text = query
        }
    }
}

extension MoviesListViewController: UISearchBarDelegate {
    
    // called when keyboard search button pressed
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        self.activityIndicator.startAnimating()
        self.viewModel.resetPagination()
        self.viewModel.fetchMoviesList(searchBar.text!)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool // return NO to not become first responder
    {
        if (searchBar.text?.count == 0) {
            self.viewModel.setCellType(.Suggesstions)
            self.tableView.reloadData()
        }
        return true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) // called when text starts editing
    {
        
    }
    // called when text changes (including clear)
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)  {
       
        if (searchText.count == 0) {
            // reset tableView
            self.viewModel.setCellType(.Suggesstions)
            self.tableView.reloadData()
        }
        else if (self.viewModel.cellType == .Suggesstions){
            self.viewModel.setCellType(.Movies)
            self.tableView.reloadData()
        }
    }
    
    // called before text changes
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool  {
        return true
    }
}

extension MoviesListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !self.viewModel.getLoadingStatus() && ((self.searchBar.text?.count)! > 0) && self.viewModel.cellType == .Movies){
            self.viewModel.setLoadingStatus(true)
            self.loaderView.startAnimating()
            self.viewModel.loadPaginatedResponseWith(self.searchBar.text!)
        }
        else {
            self.loaderView.stopAnimating()
            
        }
    }
}
