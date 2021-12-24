//
//  MainVCPresenter.swift
//  MVP-Demo-iOS
//
//  Created by Ikmal Azman on 24/12/2021.
//

import Foundation

protocol MainPresenterDelegate : AnyObject {
    func presentListOfLegue(_ MainVCPresenter : MainPresenter, data : [League])
    func presentActionWhenRefresh(_ MainVCPresenter : MainPresenter)
}

final class MainPresenter {
    
    weak private var delegate : MainPresenterDelegate?
    private let networkManager = NetworkManager()
    
    func setViewDelegate(delegate : MainPresenterDelegate) {
        self.delegate = delegate
    }
    
    func getLeagueList() {
        networkManager.requestLeague { [weak self] league in
            self?.delegate?.presentListOfLegue(self!, data: league)
        }
    }
    
    func didRefreshView() {
        self.delegate?.presentActionWhenRefresh(self)
    }
    
}
