//
//  RepositoriesViewController.swift
//  RobustaTask
//
//  Created by Assem on 14/10/2022.
//

import UIKit

class RepositoriesViewController: UIViewController {

    // MARK: Properties and outlets

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var repositoriesTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    var viewModel: RepositoriesViewModel!
    var refreshControl: UIRefreshControl = UIRefreshControl()

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupViewModel()
        loadRepositories()
    }


    // MARK: Helper Methods
    private func setupView() {
        title = "Repositories"
        searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        tableViewSetup()
    }

    private func setupViewModel() {
        viewModel.successHandler.onUpdate = { [weak self] _ in
            self?.hideRefreshController()
            self?.activityIndicator.stopAnimating()
            self?.activityIndicator.isHidden = true
            self?.repositoriesTableView.reloadData()
        }
        viewModel.errorHandler.onUpdate = { [weak self] _ in
            guard let error = self?.viewModel.errorHandler.value else {return}
            self?.hideRefreshController()
            self?.activityIndicator.stopAnimating()
            self?.activityIndicator.isHidden = true
            self?.showAlertmessage(with: error)
        }
        //        viewModel.isLoading = true
    }

    private func navigateToRepositoryProfileVC(with owner: Owner) {
        let vc = ViewControllerProvider.navigateToRepoProfileVC(with: owner)
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func loadRepositories() {
        self.activityIndicator.startAnimating()
        self.activityIndicator.isHidden = false
        clearSearch()
        viewModel.fetchRepositories(currentPage: viewModel.currentpage)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

// MARK: TableView DataSource and Delegate
extension RepositoriesViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {

    private func tableViewSetup() {
        repositoriesTableView.dataSource = self
        repositoriesTableView.delegate = self
        repositoriesTableView.prefetchDataSource = self
        repositoriesTableView.isPrefetchingEnabled = true
        let nib = UINib(nibName: RepositoryableViewCell.identifier, bundle: nil)
        repositoriesTableView.register(nib, forCellReuseIdentifier: RepositoryableViewCell.identifier)
        repositoriesTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(loadRepositories), for: .valueChanged)
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        //        for indexPath in indexPaths {
        //            if indexPath.row >= viewModel.titles.value.count - 3, viewModel.currentpage < viewModel.totalpages, viewModel.currentpage != viewModel.totalpages, !viewModel.isLoading {
        //                viewModel.currentpage += 1
        //                viewModel.fetchUpcoming(currentPage: viewModel.currentpage)
        //            }
        //        }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repositories.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryableViewCell.identifier, for: indexPath) as? RepositoryableViewCell else {
            return UITableViewCell()
        }
        let viewModel = viewModel.repositories[indexPath.row]
        cell.configure(with: viewModel)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 109
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let owner = viewModel.repositories[indexPath.row].owner else {return}
        navigateToRepositoryProfileVC(with: owner)
    }

    func hideRefreshController(){
        if refreshControl.isRefreshing{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                self.refreshControl.endRefreshing()
            })
        }
    }

    func scrollTableViewToTop()  {
        let indexPath = IndexPath(row: 0, section: 0)
        if viewModel.repositories.count > indexPath.row{
            repositoriesTableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
}

//MARK: - UISearchBar delegates and related methods
extension RepositoriesViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            searchBar.perform(#selector(self.resignFirstResponder), with: nil, afterDelay: 0.1)
        }
        let text = searchText.lowercased()
        viewModel.repositories = viewModel.searchRepositories(with: text)
        repositoriesTableView.reloadData()
                scrollTableViewToTop()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.repositories = viewModel.searchRepositories(with: "")
        repositoriesTableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func clearSearch() {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}

