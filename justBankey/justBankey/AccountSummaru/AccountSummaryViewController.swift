//
//  AccountSummaryViewController.swift
//  justBankey
//
//  Created by  Mr.Ki on 11.03.2022.
//

import UIKit

class AccountSummaryViewController: UIViewController {
    
    //MARK: - Request models
    var profile: Profile?
    var accounts: [Account] = []
    
    //MARK: - View models
    var headerViewModel = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Welcome", name: "", date: Date())
    var accountCellViewModels: [AccountSummaryCell.ViewModel] = []
    
    //MARK: - Components
    var tableView = UITableView()
    var headerView = AccountSummaryHeaderView(frame: .zero)
    let refreshControll = UIRefreshControl()
    
    //MARK: - Networking
    var profileManager: ProfileManageable = ProfileManager()
    var accountsManager: AccountsManegable = AccountsManager()
    
    var isLoaded = false
    
    lazy var logoutBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        barButtonItem.tintColor = .label
        return barButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
       
    }
    
   
    
}

extension AccountSummaryViewController {
    private func setup() {
        setupNavigationBar()
        setupTableView()
        setupTableHeaderView()
       // fetchAccounts()
        setupRefreshControl()
        setupSkeletons()
        fetchData()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = appColor
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.register(SkeletonCell.self, forCellReuseIdentifier: SkeletonCell.reuseID)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.tableFooterView = UIView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupTableHeaderView() {
      
        var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        headerView.frame.size = size
        
        tableView.tableHeaderView = headerView
    }
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
    
    private func setupSkeletons() {
        let row = Account.makeSkeleton()
        accounts = Array(repeating: row, count: 10)
        
        configureTableCells(with: accounts)
        
    }
    
    private func setupRefreshControl() {
        refreshControll.tintColor = appColor
        refreshControll.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        tableView.refreshControl = refreshControll
    }
    
}

extension AccountSummaryViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//      //  let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
//        guard !accountCellViewModels.isEmpty else { return UITableViewCell() }
//
//                let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
//                let account = accountCellViewModels[indexPath.row]
//                cell.configure(with: account)
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return accountCellViewModels.count
//    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          guard !accountCellViewModels.isEmpty else { return UITableViewCell() }
          let account = accountCellViewModels[indexPath.row]

          if isLoaded {
              let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
              cell.configure(with: account)
              return cell
          }
          
          let cell = tableView.dequeueReusableCell(withIdentifier: SkeletonCell.reuseID, for: indexPath) as! SkeletonCell
          return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return accountCellViewModels.count
    }
}

extension AccountSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

//extension AccountSummaryViewController {
//    private func fetchAccounts() {
//
//        let savings = AccountSummaryCell.ViewModel(accountType: .Banking,
//                                                            accountName: "Basic Savings",
//                                                        balance: 929466.23)
//        let chequing = AccountSummaryCell.ViewModel(accountType: .Banking,
//                                                    accountName: "No-Fee All-In Chequing",
//                                                    balance: 17562.44)
//        let visa = AccountSummaryCell.ViewModel(accountType: .CreditCard,
//                                                       accountName: "Visa Avion Card",
//                                                       balance: 412.83)
//        let masterCard = AccountSummaryCell.ViewModel(accountType: .CreditCard,
//                                                       accountName: "Student Mastercard",
//                                                       balance: 50.83)
//        let investment1 = AccountSummaryCell.ViewModel(accountType: .Investment,
//                                                       accountName: "Tax-Free Saver",
//                                                       balance: 2000.00)
//        let investment2 = AccountSummaryCell.ViewModel(accountType: .Investment,
//                                                       accountName: "Growth Fund",
//                                                       balance: 15000.00)
//
//        accountCellViewModels.append(savings)
//        accountCellViewModels.append(chequing)
//        accountCellViewModels.append(visa)
//        accountCellViewModels.append(masterCard)
//        accountCellViewModels.append(investment1)
//        accountCellViewModels.append(investment2)
//    }
//}

// MARK: - Networking
extension AccountSummaryViewController {
    private func fetchData() {
        
//        fetchProfile(forUserId: "2") { hello in
//            switch hello {
//
//            case .success(let hi):
//                self.profile = hi
//                profile?.firstName
//            case .failure(_):
//                <#code#>
//            }
//        }
        
        let group = DispatchGroup()
        
        let userId = String(Int.random(in: 1..<4))
        
        group.enter()
        profileManager.fetchProfile(forUserId: userId) { result in
            switch result {
            case .success(let profile):
                self.profile = profile
          //      self.configureTableHeaderView(with: profile)
             //   self.tableView.reloadData()
            case .failure(let error):
                self.displayError(error)
            }
            group.leave()
        }
        
        group.enter()
        accountsManager.fetchAccounts(forUserId: userId) { result in
            switch result {
            case .success(let accounts):
                self.accounts = accounts
           //     self.configureTableCells(with: accounts)
              //  self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
                self.displayError(error)
            }
            group.leave()
        }
        group.notify(queue: .main) {
            self.tableView.refreshControl?.endRefreshing()
            
            guard let profile = self.profile else { return }
            
            self.isLoaded = true
            self.configureTableHeaderView(with: profile)
            self.configureTableCells(with: self.accounts)
            self.tableView.reloadData()
            
        }
    }
    
    private func configureTableHeaderView(with profile: Profile) {
        let vm = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Good morning,",
                                                    name: profile.firstName,
                                                    date: Date())
        headerView.configure(viewModel: vm)
    }
    
    private func configureTableCells(with accounts: [Account]) {
        accountCellViewModels = accounts.map {
            AccountSummaryCell.ViewModel(accountType: $0.type,
                                         accountName: $0.name,
                                         balance: $0.amount)
        }
    }
    
//    private func displayError(_ error: NetworkError) {
//        print(error.localizedDescription)
//        let title: String
//        let message: String
//        switch error {
//        case .serverError:
//            title = "Server Error"
//            message = "Check your internet connection"
//        case .decodingError:
//            title = "Decoding Error"
//            message = "We could not process your request"
//        }
//        self.showErrorAlert(title: title, message: message)
//    }
    
    private func displayError(_ error: NetworkError) {
        let titleAndMessage = titleAndMessage(for: error)
        self.showErrorAlert(title: titleAndMessage.0, message: titleAndMessage.1)
    }

    private func titleAndMessage(for error: NetworkError) -> (String, String) {
        let title: String
        let message: String
        switch error {
        case .serverError:
            title = "Server Error"
            message = "Check your internet connection"
        case .decodingError:
            title = "Network Error"
            message = "We could not process your request"
        }
        return (title, message)
    }
    
    private func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
}

//MARK: - Actions
extension AccountSummaryViewController {
    @objc func logoutTapped(sender: UIButton) {
        NotificationCenter.default.post(name: .logout, object: nil)
    }
    
//    @objc func refreshContent() {
//        fetchData()
//    }
    @objc func refreshContent() {
        reset()
        setupSkeletons()
        tableView.reloadData()
        fetchData()
    }
    
    private func reset() {
        profile = nil
        accounts = []
        isLoaded = false
    }
    
}

//MARK: - Unit testing
extension AccountSummaryViewController {
    func titleAndMessageForTesting(for error: NetworkError) -> (String, String) {
            return titleAndMessage(for: error)
    }
}
