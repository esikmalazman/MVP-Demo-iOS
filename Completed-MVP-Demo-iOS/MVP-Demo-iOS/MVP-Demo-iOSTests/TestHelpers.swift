@testable import MVP_Demo_iOS
import UIKit


func tap(_ button : UIBarButtonItem) {
    _ = button.target?.perform(button.action, with: nil)
}

/// Ask UIKit to execute registered events immediately
func executeRunLoop() {
    RunLoop.main.run(until: Date())
}

//MARK: - UITableViewSource Helper
func numberOfRowsInSection(_ tableView : UITableView, section : Int = 0) -> Int? {
    return tableView.dataSource?.tableView(tableView, numberOfRowsInSection: section)
}

func cellForRowAt(_ tableView : UITableView, row : Int, section : Int = 0) -> UITableViewCell? {
    let indexPath = IndexPath(row: row, section: section)
    return tableView.dataSource?.tableView(tableView, cellForRowAt: indexPath)
}

func createLeagueData(_ name : String) -> League {
    return League(name: name)
}


//MARK: - MainPresenter Helper
func presentActionWhenRefresh(_ presenter: MainPresenter) {
    presenter.delegate?.presentActionWhenRefresh(presenter)
}

func presentListOfLeague(_ presenter: MainPresenter, data : [League]) {
    presenter.delegate?.presentListOfLegue(presenter, data: data)
}
