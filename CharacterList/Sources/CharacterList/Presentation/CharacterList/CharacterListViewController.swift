//
//  CharacterListViewController.swift
//  
//
//  Created by Victor C Tavernari on 14/01/21.
//

import UIKit
import Shared

extension CharacterListViewModel.Segment {
    var emptyMessage: String {
        switch self {
        case .allCharacters:
            return "Something wrong!"
        case .allFavorites:
            return "No favorites."
        }
    }
}

protocol CharacterListViewControllerDelegate: class {
    func selected(from: CharacterListViewController, character: Character)
}

class CharacterListViewController: UIViewController {

    private let allCharactersSegmentIndex = 0
    private let allFavoritesSegmentIndex = 1

    weak var delegate: CharacterListViewControllerDelegate?

    lazy var emptyListLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.textColor = .systemPurple
        return label
    }()

    lazy var segmentControl: UISegmentedControl = {
        let control = UISegmentedControl()
        control.insertSegment(withTitle: "All", at: allCharactersSegmentIndex, animated: false)
        control.insertSegment(withTitle: "Favorites", at: allFavoritesSegmentIndex, animated: false)
        control.selectedSegmentIndex = 0
        return control
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CharacterListCell.self,
                                forCellReuseIdentifier: CharacterListCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.delegate = self
        tableView.bounces = true
        tableView.bouncesZoom = true

        tableView.dataSource = self.dataSource

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsMultipleSelection = false
        return tableView
    }()

    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .systemPurple
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.alpha = 0
        let blurEffect = UIBlurEffect(style: .systemMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = activityIndicator.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        activityIndicator.insertSubview(blurEffectView, at: 0)
        return activityIndicator
    }()

    var viewModel: CharacterListViewModel!
    lazy var dataSource = TableViewDataSource.make(for: [], withViewModel: viewModel)

    private func showLoadingView() {
        activityIndicatorView.layer.removeAllAnimations()
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn) {
            self.activityIndicatorView.alpha = 1
        } completion: { _ in
            self.activityIndicatorView.startAnimating()
        }
    }

    private func hideLoadingView() {
        activityIndicatorView.layer.removeAllAnimations()
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
            self.activityIndicatorView.alpha = 0
        } completion: { _ in
            self.activityIndicatorView.stopAnimating()
        }
    }

    private func showErrorAlert() {
        let alert = UIAlertController(title: "Something wrong", message: "Check your internet connection, or try again later!", preferredStyle: .alert)
        alert.addAction(.init(title: "Retry", style: .default, handler: { action in
            alert.dismiss(animated: true, completion: self.viewModel.fetchCharacters)
        }))
        self.present(alert, animated: true)
    }

    private func applyConstraints() {
        let viewSafeArea = view.safeAreaLayoutGuide

        activityIndicatorView
            .bottomAnchor
            .constraint(equalTo: viewSafeArea.bottomAnchor)
            .isActive = true
        activityIndicatorView
            .leftAnchor
            .constraint(equalTo: viewSafeArea.leftAnchor)
            .isActive = true
        activityIndicatorView
            .rightAnchor
            .constraint(equalTo: viewSafeArea.rightAnchor)
            .isActive = true
        activityIndicatorView
            .heightAnchor
            .constraint(equalToConstant: 50)
            .isActive = true

        tableView
            .topAnchor
            .constraint(equalTo: viewSafeArea.topAnchor)
            .isActive = true
        tableView
            .leftAnchor
            .constraint(equalTo: viewSafeArea.leftAnchor)
            .isActive = true
        tableView
            .rightAnchor
            .constraint(equalTo: viewSafeArea.rightAnchor)
            .isActive = true
        tableView
            .bottomAnchor
            .constraint(equalTo: viewSafeArea.bottomAnchor)
            .isActive = true

        emptyListLabel
            .centerYAnchor
            .constraint(equalTo: tableView.centerYAnchor)
            .isActive = true
        emptyListLabel
            .centerXAnchor
            .constraint(equalTo: tableView.centerXAnchor)
            .isActive = true
    }

    private func binViewModelUpdate() {
        viewModel.onUpdated = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .loading:
                self.showLoadingView()
                self.emptyListLabel.isHidden = true
            case .failed:
                self.hideLoadingView()
                self.showErrorAlert()
                self.emptyListLabel.isHidden = true
            case .itemsUpdated:
                self.hideLoadingView()
                self.dataSource.models = self.viewModel.items
                self.emptyListLabel.isHidden = !self.viewModel.items.isEmpty
                self.tableView.reloadData()
            case .selected(let character):
                self.delegate?.selected(from: self, character: character)
            }
        }
    }

    private func updateDataSourceByegment() {
        if segmentControl.selectedSegmentIndex == self.allCharactersSegmentIndex {
            viewModel.segment = .allCharacters
        } else {
            viewModel.segment = .allFavorites
        }
    }

    @objc func segmentChanged() {
        updateDataSourceByegment()
        emptyListLabel.text = viewModel.segment.emptyMessage
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Characters"

        segmentControl.frame = .init(x: 0, y: 0, width: 10, height: 40)
        segmentControl.autoresizingMask = .flexibleWidth
        tableView.tableHeaderView = segmentControl
        segmentControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        view.addSubview(tableView)
        view.addSubview(emptyListLabel)
        view.addSubview(activityIndicatorView)

        applyConstraints()
        binViewModelUpdate()
        viewModel.fetchCharacters()

        view.backgroundColor = .systemBackground
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.sizeToFit()
        viewModel.fetchFavorites()
        self.updateDataSourceByegment()
        self.tableView.reloadData()
    }
}

extension CharacterListViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if segmentControl.selectedSegmentIndex == allCharactersSegmentIndex
            && (scrollView.contentOffset.y + 1) >= (scrollView.contentSize.height - scrollView.frame.size.height) {
            viewModel.fetchCharacters()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.select(index: indexPath.item)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
