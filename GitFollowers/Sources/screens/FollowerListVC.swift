//
//  FollowerListVC.swift
//  GitFollowers
//
//  Created by Daylon van wel on 06/06/2020.
//  Copyright © 2020 Daylon van Wel. All rights reserved.
//

import UIKit

protocol FollowerListVCDelegate: class {
	func didRequestFollowers(for userName: String)
}

class FollowerListVC: UIViewController {

	enum Section {
		case main
	}

	var userName: String!
	var collectionView: UICollectionView!
	var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
	var followers: [Follower] = []
	var filteredFollowers: [Follower] = []
	var pageNumber = 1
	var hasMoreFollowers = true
	var isSearching = false

    override func viewDidLoad() {
        super.viewDidLoad()

		self.configureViewController()
		self.configureCollectionView()
		self.configureSearchController()
		self.getFollowers(username: self.userName, page: self.pageNumber)
		self.configureDataSource()
    }

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		navigationController?.setNavigationBarHidden(false, animated: true)
	}

	func configureCollectionView() {
		self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: GFCollectionViewFlowLayout(bounds: self.view.bounds))
		self.collectionView.backgroundColor = .systemBackground
		self.collectionView.delegate = self
		self.view.addSubview(self.collectionView)
		self.collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
	}

	func configureViewController() {
		self.view.backgroundColor = .systemBackground
		navigationController?.navigationBar.prefersLargeTitles = true

		let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
		self.navigationItem.leftBarButtonItem = addButton
	}

	@objc
	func addButtonTapped() {

	}

	func configureSearchController() {
		let searchController = UISearchController()
		searchController.searchResultsUpdater = self
		searchController.searchBar.placeholder = "Search"
		searchController.searchBar.delegate = self
		self.navigationItem.searchController = searchController
	}

	func configureDataSource() {
		self.dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: self.collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as? FollowerCell
			cell?.set(follower: follower)

			return cell
		})
	}

	func updateData(on followers: [Follower]) {
		var snapShot = NSDiffableDataSourceSnapshot<Section, Follower>()
		snapShot.appendSections([.main])
		snapShot.appendItems(followers)
		DispatchQueue.main.async {
			self.dataSource.apply(snapShot, animatingDifferences: true)
		}
	}

	func getFollowers(username: String, page: Int) {
		self.showLoadingView()
		NetworkManager.shared.getFollowers(for: self.userName, page: page) {[weak self] (result) in
			guard let self = self else { return }
			self.dismissLoadingView()

			switch result {
				case .success(let followers):
					self.followers.append(contentsOf: followers)

					if self.followers.isEmpty {
						let message = "This user does not have any followers. Go Follow them"
						DispatchQueue.main.async {
							self.showEmptyStateView(with: message, in: self.view)
							return
						}
					}

					self.updateData(on: self.followers)
					if followers.count < 100 { self.hasMoreFollowers = false }
				case .failure(let error):
					self.presentGFAlertOnMainThread(title: "Bad stuff happend", message: error.rawValue, buttonTitle: "Ok")
			}
		}
	}
}

extension FollowerListVC: UICollectionViewDelegate {

	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		let offsetY = scrollView.contentOffset.y
		let contentHeight = scrollView.contentSize.height
		let height = scrollView.frame.size.height

		if offsetY > contentHeight - height {
			guard hasMoreFollowers else { return }
			self.pageNumber += 1
			self.getFollowers(username: self.userName,page: self.pageNumber)
		}
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let activeArray = isSearching ? self.filteredFollowers : self.followers
		let follower = activeArray[indexPath.item]

		let destVC = UserInfoVC()
		destVC.delegate = self
		destVC.user = follower

		let navController = UINavigationController(rootViewController: destVC)
		self.present(navController, animated: true)
	}
}

extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
	func updateSearchResults(for searchController: UISearchController) {
		guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }

		self.isSearching = true
		self.filteredFollowers = self.followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
		self.updateData(on: self.filteredFollowers)
	}

	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		self.isSearching = false
		self.updateData(on: self.followers)
	}
}

extension FollowerListVC: FollowerListVCDelegate {
	func didRequestFollowers(for userName: String) {
		self.userName = userName
		self.title = userName
		self.pageNumber = 1
		self.followers.removeAll()
		self.filteredFollowers.removeAll()
		self.collectionView.setContentOffset(.zero, animated: true)

		self.getFollowers(username: userName, page: self.pageNumber)
	}
}
