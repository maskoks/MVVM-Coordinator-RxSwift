//
//  PreferencesService.swift
//  MVVM+Coordinator
//
//  Created by Жеребцов Данил on 22.05.2022.
//

import Foundation
import RxSwift

protocol HasPreferencesService {
    var preferencesService: PreferencesService { get }
}

struct UserPreferences {
    private init () {}
    static let isLogedIn = "isLogedIn"
}

class PreferencesService {

    func setIsLogedIn () {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: UserPreferences.isLogedIn)
    }

    func setNotLogedIn () {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: UserPreferences.isLogedIn)
    }

    func isLogedIn () -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: UserPreferences.isLogedIn)
    }
}

extension PreferencesService: ReactiveCompatible {}

extension Reactive where Base: PreferencesService {
    var isLogedIn: Observable<Bool> {
        return UserDefaults.standard
            .rx
            .observe(Bool.self, UserPreferences.isLogedIn)
            .map { $0 ?? false }
    }
}

