//
//  CharacterListViewController.swift
//  
//
//  Created by Victor C Tavernari on 14/01/21.
//

import UIKit
import Shared

protocol CharacterListViewControllerDelegate: class {
    func selected(from: CharacterListViewController, character: Character)
}

class CharacterListViewController: UIViewController {

    weak var delegate: CharacterListViewControllerDelegate?

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

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Characters"

        view.addSubview(tableView)
        view.addSubview(activityIndicatorView)

        activityIndicatorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        activityIndicatorView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        activityIndicatorView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        activityIndicatorView.heightAnchor.constraint(equalToConstant: 50).isActive = true

        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        viewModel.onUpdated = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .loading:
                self.showLoadingView()
            case .failed:
                self.hideLoadingView()
                self.showErrorAlert()
            case .done:
                self.hideLoadingView()
                self.dataSource.models = self.viewModel.items
                self.tableView.reloadData()
            case .selected(let character):
                self.delegate?.selected(from: self, character: character)
            }
        }

        viewModel.fetchCharacters()

        view.backgroundColor = .systemBackground
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.sizeToFit()
        tableView.reloadData()
    }
}

extension CharacterListViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y + 1) >= (scrollView.contentSize.height - scrollView.frame.size.height) {
            viewModel.fetchCharacters()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.select(index: indexPath.item)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
