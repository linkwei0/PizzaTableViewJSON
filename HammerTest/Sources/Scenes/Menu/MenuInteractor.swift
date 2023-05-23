//
//  MenuInteractor.swift
//  HammerTest
//

import Foundation

protocol MenuInteractorProtocol: AnyObject {
    func loadData()
}

class MenuInteractor {
    typealias Dependencies = HasMenuService

    // MARK: - Properties
    
    weak var presenter: MenuPresenterProtocol?
    private let dependencies: Dependencies
    
    // MARK: - Init
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Private methods
    
    private func handle(_ response: [Food]) {
        presenter?.dataDidLoad(arrayOfFood: response)
    }
}

// MARK: - MenuInteractorProtocol

extension MenuInteractor: MenuInteractorProtocol {
    func loadData() {
        dependencies.menuService.getMenu().done { response in
//            self.handle(response)
        }.catch { error in
            print("Failed load data")
        }
        // TODO: This's mock
        handle(Food.mockFood)
    }
}
