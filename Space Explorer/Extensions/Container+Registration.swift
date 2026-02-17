//
//  Container+Registration.swift
//  Space Explorer
//
//  Created by Novus on 15/12/2025.
//

import Factory

extension Container {
    
    var appInfoModel: Factory<AppInfoModel> {
        self {
            MainActor.assumeIsolated { AppInfoModel() } }.singleton
        }
    
    var dateGenerator: Factory<DateGenerator> {
        self {
            MainActor.assumeIsolated { DateGeneratorImpl() } }.singleton
        }
    
    var apodRepository: Factory<APODRepository> {
        self {
            MainActor.assumeIsolated { APODRepositoryImpl() } }.singleton
        }
    
    var planetRepository: Factory<PlanetRepository> {
        self {
            MainActor.assumeIsolated { PlanetRepositoryImpl() } } .singleton
        }
    
    }
    

