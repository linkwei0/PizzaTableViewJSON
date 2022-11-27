//
//  MenuPresenter.swift
//  HammerTest
//

import UIKit

protocol MenuPresenterProtocol: AnyObject {
    var bannerViews: [BannerView] { get }
    var categoryViews: [CategoryView] { get }
    var arrayOfFood: [Food] { get }
    
    func viewDidLoaded()
    func didLoad(arrayOfFood: [Food])
    func configureCell(indexPath: IndexPath) -> Food
}

class MenuPresenter {
    // MARK: - Properties
    
    weak var view: MenuViewProtocol?
    
    private(set) var bannerViews: [BannerView] = [BannerView(), BannerView()]
    private(set) var categoryViews: [CategoryView] = []
    private(set) var arrayOfFood: [Food] = []
    
    private let router: MenuRouterProtocol
    private let interactor: MenuInteractorProtocol
    
    
    // MARK: - Init
    
    init(router: MenuRouterProtocol, interactor: MenuInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    // MARK: - Private methods
    
    private func catchAllCategories() {
        let allDuplicatesCategories = arrayOfFood.map { $0.category }
        let uniqueCategories = Set(allDuplicatesCategories).sorted { $0 > $1 }
        
        uniqueCategories.forEach { categoryName in
            let categoryView = CategoryView()
            let category: Category
            
            if uniqueCategories.first == categoryName {
                category = Category(text: categoryName, isSelected: true)
            } else {
                category = Category(text: categoryName, isSelected: false)
            }
            
            categoryView.onDidTap = { [weak self] selectedCategory in
                self?.categoryViews.forEach { categoryView in
                    categoryView.category?.isSelected = false
                    categoryView.configure(with: categoryView.category!)
                }
                
                if let index = allDuplicatesCategories.firstIndex(where: { name in
                    name == selectedCategory.text
                }) {
                    let indexPath = IndexPath(row: index, section: 0)
                    let selectedCategory = self?.categoryViews.first { $0.category?.text == selectedCategory.text }
                    selectedCategory?.category?.isSelected = true
                    categoryView.configure(with: (selectedCategory?.category)!)
                    self?.view?.showCategory(indexPath)
                }
            }
            categoryView.configure(with: category)
            categoryViews.append(categoryView)
        }
    }
    
    // MARK: - Public methods
    
    func configureCell(indexPath: IndexPath) -> Food {
        return arrayOfFood[indexPath.row]
    }
}

// MARK: - MenuPresenterProtocol

extension MenuPresenter: MenuPresenterProtocol {
    func viewDidLoaded() {
        interactor.loadData()
    }
    
    func didLoad(arrayOfFood: [Food]) {
        self.arrayOfFood = arrayOfFood.sorted { $0.category > $1.category }
        catchAllCategories()
        view?.updateTable()
    }
}
