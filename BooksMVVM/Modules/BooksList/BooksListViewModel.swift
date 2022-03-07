//
//  BooksListViewModel.swift
//  BooksMVVM
//
//  Created by L Daniel De San Pedro on 18/02/22.
//

import Foundation

final class BooksListViewModel {
    
    enum Sections: Int {
        case books = 0
        case categories = 1
        case authors = 2
    }
    
    var currentCategory: Observable = Observable(Sections.books)
    var isRequestingData: Observable = Observable(false)
    
    private var apiDataManager: APIDataManager = APIDataManager()
    
    init() {
        currentCategory.valueChanged = {[weak self] section in
            guard let section = section else { return }
            self?.requestInfoOf(section: section)
        }
    }
    
    func obtainSegmentedControlSections() -> [String] {
        return ["Books","Categories","Authors"]
    }
    
    
    private func requestInfoOf(section: Sections) {
        isRequestingData.value = true
    }
}
