//
//  PeopleViewModel.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 22.10.22.
//

import Foundation

class PeopleViewModel {
    var coordinator: PeopleCoordinator?    
    var item: People?
    var peopleItems = [PeopleResult]()
    
    var successCallback: (()->())?
    var errorCallback: ((String)->())?
    
    func getPopularPeople() {
        PeopleManager.shared.getPopularPeople(page: (item?.page ?? 0) + 1) { [weak self] item, errorMessage in
            if let errorMessage {
                self?.errorCallback?(errorMessage)
            } else {
                self?.item = item
                if let peopleItems = item?.result, !peopleItems.isEmpty {
                    self?.peopleItems.append(contentsOf: peopleItems)
                }
                self?.successCallback?()
            }
        }
    }
    
    func pagination(index: Int) {
        if let item = item {
            if (item.page ?? 0 <= item.totalPages ?? 0) && index == (peopleItems.count - 1) {
                getPopularPeople()
            }
        }
    }
}
