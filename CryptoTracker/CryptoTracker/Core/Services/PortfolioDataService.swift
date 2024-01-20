//
//  PortfolioDataService.swift
//  CryptoTracker
//
//  Created by Yunus Emre Berdibek on 11.01.2024.
//

import CoreData
import Foundation

final class PortfolioDataService {
    @Published var savedEntities: [PortfolioEntity] = []
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"

    init() {
        self.container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error {
                print("Error loading Core Data!: \(error.localizedDescription)")
            }
            self.getPortfolio()
        }
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    // MARK: - PRIVATE

    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            let entities = try container.viewContext.fetch(request)
            DispatchQueue.main.async {
                self.savedEntities = entities
            }
        } catch {
            print("Error fetching portfolio entites!: \(error.localizedDescription)")
        }
    }
    
    private func add(coin: CoinModel, amount: Double) {
        if let existingEntity = savedEntities.first(where: { $0.coinID == coin.id }) {
            existingEntity.amount = amount
        } else {
            let entity = PortfolioEntity(context: container.viewContext)
            entity.coinID = coin.id
            entity.amount = amount
        }
        applyChanges()
    }
    
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        container.viewContext.refreshAllObjects()
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch {
            print("Error saving portfolio entity!: \(error.localizedDescription)")
        }
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
}
