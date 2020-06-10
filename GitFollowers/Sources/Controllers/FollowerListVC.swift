//
//  FollowerListVC.swift
//  GitFollowers
//
//  Created by Daylon van wel on 06/06/2020.
//  Copyright © 2020 Daylon van Wel. All rights reserved.
//

import UIKit

class FollowerListVC: UIViewController {

	enum Section {
		case main
	}

	var userName: String!
	var collectionView: UICollectionView!
	var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
	var followers: [Follower] = []
	var pageNumber = 1
	var hasMoreFollowers = true

    override func viewDidLoad() {
        super.viewDidLoad()

		self.configureViewController()
		self.configureCollectionView()
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
	}

	func configureDataSource() {
		self.dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: self.collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as? FollowerCell
			cell?.set(follower: follower)

			return cell
		})
	}

	func updateData() {
		var snapShot = NSDiffableDataSourceSnapshot<Section, Follower>()
		snapShot.appendSections([.main])
		snapShot.appendItems(self.followers)
		DispatchQueue.main.async {
			self.dataSource.apply(snapShot, animatingDifferences: true)
		}
	}

	func getFollowers(username: String, page: Int) {
		NetworkManager.shared.getFollowers(for: self.userName, page: page) {[weak self] (result) in // weak self = self in closure is a weak reference so no reference is hold by Network manager when view controller is NIL
			guard let self = self else { return }

			switch result {
				case .success(let followers):
					self.followers.append(contentsOf: followers)
					self.updateData()
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
}
