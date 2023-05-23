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
    func dataDidLoad(arrayOfFood: [Food])
    func configureCell(indexPath: IndexPath) -> Food
    func currentCategoryByOffsetY(_ indexPath: IndexPath?)
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
    
    private func handleCategories() {
        let categories = Set(arrayOfFood.map { $0.category }).sorted { $0 > $1 }
        
        for (index, categoryName) in categories.enumerated() {
            let category: Category = index == 0 ? Category(text: categoryName, isSelected: true) : Category(text: categoryName, isSelected: false)
            let categoryView = CategoryView()
            
            categoryView.onDidTap = { [weak self] selectedCategory in
                self?.categoryViews.forEach { subView in
                    if subView.category?.text == selectedCategory.text {
                        subView.category?.isSelected = true
                        subView.configure(with: subView.category!)
                    } else {
                        subView.category?.isSelected = false
                        subView.configure(with: subView.category!)
                    }
                }
                
                if let index = self?.arrayOfFood.firstIndex(where: { food in
                    food.category == selectedCategory.text
                }) {
                    let indexPath = IndexPath(row: index, section: 0)
                    self?.view?.scrollToCategory(with: indexPath)
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
    
    func dataDidLoad(arrayOfFood: [Food]) {
        self.arrayOfFood = arrayOfFood.sorted { $0.category > $1.category }
        handleCategories()
        view?.updateTableView()
    }
    
    func currentCategoryByOffsetY(_ indexPath: IndexPath?) {
        guard let index = indexPath else { return }
        let food = arrayOfFood[index.row]
        
        categoryViews.forEach { categoryView in
            let isSelected = categoryView.category?.text == food.category ? true : false
            if var category = categoryView.category {
                category.isSelected = isSelected
                categoryView.configure(with: category)
            }
        }
    }
}
