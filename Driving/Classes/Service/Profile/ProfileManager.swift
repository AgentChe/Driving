//
//  ProfileManager.swift
//  CDL
//
//  Created by Андрей Чернышев on 16.08.2022.
//

import RxSwift

protocol ProfileManagerProtocol {
    func set(level: Int?,
             assetsPreferences: [Int]?,
             examDate: String?,
             testMinutes: Int?,
             testNumber: Int?,
             testWhen: [Int]?,
             notificationKey: String?,
             testMode: TestMode?,
             selectedCoursesIds: [Int]?,
             selectedCourse: Course?,
             country: String?,
             state: String?,
             language: String?,
             app: App?) -> Single<Void>
    func obtainProfile(forceUpdate: Bool) -> Single<Profile?>
    func obtainSelectedCourse(forceUpdate: Bool) -> Single<Course?>
    func obtainTestMode(forceUpdate: Bool) -> Single<TestMode?>
    func obtainLocale(forceUpdate: Bool) -> Single<ProfileLocale?>
    func obtainCountries(forceUpdate: Bool) -> Single<[Country]>
    func obtainApp(forceUpdate: Bool) -> Single<App?>
    func syncTokens(oldToken: String, newToken: String) -> Single<Void>
    func login(userToken: String) -> Single<Void>
}

final class ProfileManager: ProfileManagerProtocol {
    enum Constants {
        static let selectedCoursesIdsKey = "profile_manager_selected_courses_ids_key"
        static let selectedCourseKey = "profile_manager_selected_course_key"
        static let testModeKey = "profile_manager_test_mode_key"
        static let localeKey = "profile_manager_locale_key"
        static let countriesKey = "profile_manager_countries_key"
        static let appKey = "profile_manager_app_key"
    }
    
    private lazy var defaultRequestWrapper = DefaultRequestWrapper()
    
    private lazy var sessionManager = SessionManager()
}

// MARK: Public
extension ProfileManager {
    func set(level: Int? = nil,
             assetsPreferences: [Int]? = nil,
             examDate: String? = nil,
             testMinutes: Int? = nil,
             testNumber: Int? = nil,
             testWhen: [Int]? = nil,
             notificationKey: String? = nil,
             testMode: TestMode? = nil,
             selectedCoursesIds: [Int]? = nil,
             selectedCourse: Course? = nil,
             country: String? = nil,
             state: String? = nil,
             language: String? = nil,
             app: App? = nil) -> Single<Void> {
        guard let userToken = sessionManager.getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        let request = SetRequest(userToken: userToken,
                                 country: country,
                                 state: state,
                                 language: language,
                                 selectedCoursesIds: selectedCoursesIds,
                                 selectedCourseId: selectedCourse?.id,
                                 level: level,
                                 assetsPreferences: assetsPreferences,
                                 testMode: testMode?.code(),
                                 examDate: examDate,
                                 testMinutes: testMinutes,
                                 testNumber: testNumber,
                                 testWhen: testWhen,
                                 notificationKey: notificationKey,
                                 app: app?.code)
        
        return defaultRequestWrapper
            .callServerApi(requestBody: request)
            .mapToVoid()
            .do(onSuccess: { [weak self] in
                guard let self = self else {
                    return
                }
                
                self.store(testMode: testMode)
                self.store(countryCode: country, languageCode: language, stateCode: state)
                self.store(selectedCourse: selectedCourse)
                self.store(selectedCoursesIds: selectedCoursesIds)
                self.store(app: app)
            })
    }
    
    func obtainProfile(forceUpdate: Bool) -> Single<Profile?> {
        forceUpdate ? loadProfile() : cachedProfile()
    }
    
    func obtainSelectedCourse(forceUpdate: Bool) -> Single<Course?> {
        forceUpdate ? loadSelectedCourse() : cachedSelectedCourse()
    }
    
    func obtainTestMode(forceUpdate: Bool) -> Single<TestMode?> {
        forceUpdate ? loadTestMode() : cachedTestMode()
    }
    
    func obtainLocale(forceUpdate: Bool) -> Single<ProfileLocale?> {
        forceUpdate ? loadLocale() : cachedLocale()
    }
    
    func obtainCountries(forceUpdate: Bool) -> Single<[Country]> {
        forceUpdate ? loadCountries() : cachedCountries()
    }
    
    func obtainApp(forceUpdate: Bool) -> Single<App?> {
        forceUpdate ? loadApp() : cachedApp()
    }
    
    func syncTokens(oldToken: String, newToken: String) -> Single<Void> {
        let request = SyncTokensRequest(oldToken: oldToken, newToken: newToken)
        
        return defaultRequestWrapper
            .callServerApi(requestBody: request)
            .mapToVoid()
    }
    
    func login(userToken: String) -> Single<Void> {
        defaultRequestWrapper
            .callServerApi(requestBody: LoginRequest(userToken: userToken))
            .mapToVoid()
    }
}

// MARK: Private
private extension ProfileManager {
    func cachedProfile() -> Single<Profile?> {
        let selectedCoursesIds = cachedSelectedCoursesIds()
        let selectedCourse = cachedSelectedCourse()
        let testMode = cachedTestMode()
        let locale = cachedLocale()
        let app = cachedApp()
        
        return Single
            .zip(
                selectedCoursesIds,
                selectedCourse,
                testMode,
                locale,
                app
            ) { selectedCoursesIds, selectedCourse, testMode, locale, app -> Profile in
                Profile(selectedCoursesIds: selectedCoursesIds ?? [],
                        selectedCourse: selectedCourse,
                        locale: locale,
                        testMode: testMode,
                        app: app)
            }
    }
    
    func loadProfile() -> Single<Profile?> {
        guard let userToken = sessionManager.getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        let request = GetProfileRequest(userToken: userToken)
        
        return defaultRequestWrapper
            .callServerApi(requestBody: request)
            .map { GetProfileResponse.map(from: $0) }
            .do(onSuccess: { [weak self] profile in
                guard let self = self, let profile = profile else {
                    return
                }
                
                self.store(testMode: profile.testMode)
                self.store(countryCode: profile.locale?.countryCode,
                           languageCode: profile.locale?.languageCode,
                           stateCode: profile.locale?.stateCode)
                self.store(selectedCourse: profile.selectedCourse)
                self.store(selectedCoursesIds: profile.selectedCoursesIds)
            })
    }
    
    func store(testMode: TestMode?) {
        guard let testMode = testMode, let data = try? JSONEncoder().encode(testMode) else {
            return
        }
        
        UserDefaults.standard.set(data, forKey: Constants.testModeKey)
        
        ProfileMediator.shared.notifyAboutChange(testMode: testMode)
    }
    
    func cachedTestMode() -> Single<TestMode?> {
        Single<TestMode?>
            .create { event in
                guard
                    let data = UserDefaults.standard.data(forKey: Constants.testModeKey),
                    let mode = try? JSONDecoder().decode(TestMode.self, from: data)
                else {
                    event(.success(nil))
                    return Disposables.create()
                }

                event(.success(mode))
                
                return Disposables.create()
            }
    }
    
    func loadTestMode() -> Single<TestMode?> {
        loadProfile()
            .map { $0?.testMode }
            .do(onSuccess: { [weak self] testMode in
                guard let self = self, let testMode = testMode else {
                    return
                }
                
                self.store(testMode: testMode)
            })
    }
    
    func store(countryCode: String?,
               languageCode: String?,
               stateCode: String?) {
        if countryCode == nil && languageCode == nil && stateCode == nil {
            return
        }
        
        let locale = ProfileLocale(countryCode: countryCode,
                                   languageCode: languageCode,
                                   stateCode: stateCode)
        
        guard let data = try? JSONEncoder().encode(locale) else {
            return
        }
        
        UserDefaults.standard.set(data, forKey: Constants.localeKey)
        
        ProfileMediator.shared.notifyAboutChange(profileLocale: locale)
    }
    
    func cachedLocale() -> Single<ProfileLocale?> {
        Single<ProfileLocale?>
            .create { event in
                guard
                    let data = UserDefaults.standard.data(forKey: Constants.localeKey),
                    let locale = try? JSONDecoder().decode(ProfileLocale.self, from: data)
                else {
                    event(.success(nil))
                    return Disposables.create()
                }

                event(.success(locale))
                
                return Disposables.create()
            }
    }
    
    func loadLocale() -> Single<ProfileLocale?> {
        loadProfile()
            .map { $0?.locale }
            .do(onSuccess: { [weak self] locale in
                guard let self = self, let locale = locale else {
                    return
                }
                
                self.store(countryCode: locale.countryCode,
                           languageCode: locale.languageCode,
                           stateCode: locale.stateCode)
            })
    }
    
    func store(selectedCourse: Course?) {
        guard let selectedCourse = selectedCourse, let data = try? JSONEncoder().encode(selectedCourse) else {
            return
        }
        
        UserDefaults.standard.set(data, forKey: Constants.selectedCourseKey)
        
        ProfileMediator.shared.notifyAboutChange(selectedCourse: selectedCourse)
    }
    
    func cachedSelectedCourse() -> Single<Course?> {
        Single<Course?>
            .create { event in
                guard
                    let data = UserDefaults.standard.data(forKey: Constants.selectedCourseKey),
                    let course = try? JSONDecoder().decode(Course.self, from: data)
                else {
                    event(.success(nil))
                    return Disposables.create()
                }
                
                event(.success(course))
                
                return Disposables.create()
            }
    }
    
    func loadSelectedCourse() -> Single<Course?> {
        loadProfile()
            .map { $0?.selectedCourse }
            .do(onSuccess: { [weak self] course in
                guard let self = self, let course = course else {
                    return
                }
                
                self.store(selectedCourse: course)
            })
    }
    
    func store(selectedCoursesIds: [Int]?) {
        guard let selectedCoursesIds = selectedCoursesIds else {
            return
        }
        
        UserDefaults.standard.set(selectedCoursesIds, forKey: Constants.selectedCoursesIdsKey)
        
        ProfileMediator.shared.notifyAboutChange(coursesIds: selectedCoursesIds)
    }
    
    func cachedSelectedCoursesIds() -> Single<[Int]?> {
        Single<[Int]?>
            .create { event in
                guard let ids = UserDefaults.standard.value(forKey: Constants.selectedCoursesIdsKey) as? [Int] else {
                    event(.success(nil))
                    return Disposables.create()
                }
                
                event(.success(ids))
                
                return Disposables.create()
            }
    }
    
    func loadSelectedCoursesIds() -> Single<[Int]?> {
        loadProfile()
            .map { $0?.selectedCoursesIds }
            .do(onSuccess: { [weak self] ids in
                guard let self = self, let ids = ids else {
                    return
                }
                
                self.store(selectedCoursesIds: ids)
            })
    }
    
    func store(countries: [Country]) {
        guard let data = try? JSONEncoder().encode(countries) else {
            return
        }
        
        UserDefaults.standard.set(data, forKey: Constants.countriesKey)
    }
    
    func cachedCountries() -> Single<[Country]> {
        Single<[Country]>
            .create { event in
                guard
                    let data = UserDefaults.standard.data(forKey: Constants.countriesKey),
                    let countries = try? JSONDecoder().decode([Country].self, from: data)
                else {
                    event(.success([]))
                    return Disposables.create()
                }
                
                event(.success(countries))
                
                return Disposables.create()
            }
    }
    
    func loadCountries() -> Single<[Country]> {
        defaultRequestWrapper
            .callServerApi(requestBody: GetCountriesRequest())
            .map { GetCountriesResponseMapper.map(from: $0) }
            .do(onSuccess: { [weak self] countries in
                guard let self = self else {
                    return
                }
                
                self.store(countries: countries)
            })
    }
    
    func store(app: App?) {
        guard let app = app, let data = try? JSONEncoder().encode(app) else {
            return
        }
        
        UserDefaults.standard.set(data, forKey: Constants.appKey)
    }
    
    func cachedApp() -> Single<App?> {
        Single<App?>
            .create { event in
                guard
                    let data = UserDefaults.standard.data(forKey: Constants.appKey),
                    let app = try? JSONDecoder().decode(App.self, from: data)
                else {
                    event(.success(nil))
                    return Disposables.create()
                }
                
                event(.success(app))
                
                return Disposables.create()
            }
    }
    
    func loadApp() -> Single<App?> {
        loadProfile()
            .map { $0?.app }
            .do(onSuccess: { [weak self] app in
                guard let self = self, let app = app else {
                    return
                }
                
                self.store(app: app)
            })
    }
}
