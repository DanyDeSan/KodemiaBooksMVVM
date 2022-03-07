//
//  BooksListViewController.swift
//  BooksMVVM
//
//  Created by L Daniel De San Pedro on 18/02/22.
//

import UIKit

class BooksListViewController: UIViewController {
    
    private var viewModel: BooksListViewModel = BooksListViewModel()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hey there!"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var sectionsSegmentedControl: UISegmentedControl = {
        var sections = viewModel.obtainSegmentedControlSections()
        let segmentedControl: UISegmentedControl = UISegmentedControl(items:sections)
        segmentedControl.addTarget(self, action: #selector(indexChanged(_:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    private lazy var activityIndicatorContainer: UIVisualEffectView = {
        
        let blurVisualEffect: UIBlurEffect = UIBlurEffect(style: .dark)
        let visualEffectView: UIVisualEffectView = UIVisualEffectView(effect: blurVisualEffect)
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        return visualEffectView
    }()
    
    private var headerStackViewElements : [UIView] {
        return [titleLabel,sectionsSegmentedControl]
    }
    
    private lazy var headerStackView: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20.0
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        headerStackViewElements.forEach { stackViewElement in
            stack.addArrangedSubview(stackViewElement)
        }
        stack.layer.borderWidth = Constants.borderWidth
        stack.layer.cornerRadius = Constants.cornerRadius
        stack.layer.borderColor = UIColor.systemGray2.cgColor
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        view.addSubview(stack)
        return stack
    }()
    
    private lazy var booksTableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.masksToBounds = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = Constants.cornerRadius
        tableView.layer.borderColor = UIColor.systemGray.cgColor
        tableView.layer.borderWidth = Constants.borderWidth
        view.addSubview(tableView)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        initUI()
    }
    
    // Init ViewModel
    func initViewModel() {
        viewModel.isRequestingData.valueChanged = {[weak self] isRequesting in
            isRequesting ?? false ? self?.applyActivityIndicator() : self?.removeActivityIndicator()
        }
    }
    
    // Init functions
    
    func initUI() {
        view.backgroundColor = .systemBackground
        // Header stackview constraints
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.padding),
            headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.padding),
            headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.padding),
            headerStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2)
        ])
        
        
        // TableView Constraints
        NSLayoutConstraint.activate([
            booksTableView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: Constants.padding),
            booksTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.padding),
            booksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.padding),
            booksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.padding)
        ])
        
        sectionsSegmentedControl.selectedSegmentIndex = 0
        notifyIndexChange(0)
        
    }
    
    private func applyActivityIndicator() {
        self.booksTableView.addSubview(self.activityIndicatorContainer)
        NSLayoutConstraint.activate([
            activityIndicatorContainer.topAnchor.constraint(equalTo: booksTableView.topAnchor),
            activityIndicatorContainer.bottomAnchor.constraint(equalTo: booksTableView.bottomAnchor),
            activityIndicatorContainer.trailingAnchor.constraint(equalTo: booksTableView.trailingAnchor),
            activityIndicatorContainer.leadingAnchor.constraint(equalTo: booksTableView.leadingAnchor)
        ])
        
    }
    
    private func removeActivityIndicator() {
        
    }
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        notifyIndexChange(sender.selectedSegmentIndex)
    }
    
    private func notifyIndexChange(_ index: Int) {
        typealias Sections = BooksListViewModel.Sections
        guard let newSection: Sections = Sections(rawValue: index) else { return }
        viewModel.currentCategory.value = newSection
    }
   
}

extension BooksListViewController: UITableViewDelegate {
    
    
}

extension BooksListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
