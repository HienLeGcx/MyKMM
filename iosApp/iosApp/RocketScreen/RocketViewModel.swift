//
//  RocketViewModel.swift
//  iosApp
//
//  Created by Hien Le on 01.03.23.
//  Copyright © 2023 orgName. All rights reserved.
//

import shared

struct RocketUiState {
    var rocketItems: [RocketItemUiState] = []
}

struct RocketItemUiState: Identifiable {
    let id: String
    let mission: String
    let launchYear: String
    let flightNumber: String
    let details: String?
    let url: String?
}

class RocketViewModel: ObservableObject {
    @Published var uiState: RocketUiState = RocketUiState()
    
    func loadItems() async {
        do {
            let items = try await SpaceXRepositoryHelper().getAllLaunches()
            let rocketItems: [RocketItemUiState] = items.map { item in
                return RocketItemUiState(id: String(item.flightNumber), mission: item.missionName, launchYear: String(item.launchYear), flightNumber: String(item.flightNumber), details: item.details, url: item.links.article)
            }
            DispatchQueue.main.async {
                self.uiState.rocketItems = rocketItems
            }
        } catch {
            print("Error loading launches: \(error)")
        }
    }
}
