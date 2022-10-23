//
//  FilterViewModel.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 23.10.22.
//

import Foundation


class FilterViewModel {
    var items = [FilterModel(title: "Popular", type: .popular),
                 FilterModel(title: "Trending", type: .trending),
                 FilterModel(title: "Top Rated", type: .topRated),
                 FilterModel(title: "Upcoming", type: .upcoming)]
}
