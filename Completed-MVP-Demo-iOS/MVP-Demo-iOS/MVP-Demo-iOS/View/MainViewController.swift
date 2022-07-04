//
//  ViewController.swift
//  MVP-Demo-iOS
//
//  Created by Ikmal Azman on 24/12/2021.
//

import UIKit

final class MainViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    //MARK: - Variables
    var presenter : MainPresenter = MainPresenter()
    var leagueData = [League]()
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(delegate: self)
        presenter.getLeagueList()
        tableView.dataSource = self
        
    }
    //MARK: - Actions
    @IBAction func refreshTap(_ sender: UIBarButtonItem) {
        presenter.didRefreshView()
    }
}

//MARK: - Presenter Delegate
extension MainViewController : MainPresenterDelegate {
    
    func presentListOfLegue(_ MainVCPresenter: MainPresenter, data: [League]) {
        guaranteeMainThread { [weak self] in
            self?.leagueData = data
            self?.tableView?.reloadData()
            self?.removeSpinner()
        }
    }
    
    func presentActionWhenRefresh(_ MainVCPresenter: MainPresenter) {
        leagueData = []
        presenter.getLeagueList()
        addSpinner()
    }
}

//MARK: - DataSoure
extension MainViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagueData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = leagueData[indexPath.row].name
        return cell
    }
}

