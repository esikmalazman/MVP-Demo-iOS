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
    //MARK: - Variables
    private var leagueData = [String]()
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    //MARK: - Actions
    @IBAction func refreshTap(_ sender: UIBarButtonItem) {
    }
}

//MARK: - DataSoure
extension MainViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Let's Get Started"
        return cell
    }
}

