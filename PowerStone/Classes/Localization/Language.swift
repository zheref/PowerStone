//
//  Language.swift
//  PowerStone
//
//  Created by Sergio Daniel L. García on 7/11/18.
//

import Foundation

public struct PWLanguage {
    
    public static var isoLanguages: [PWLanguage] {
        let isoCodes = Locale.isoLanguageCodes
        
        var languages = isoCodes.map { (isoCode) -> PWLanguage in
            return PWLanguage(withCode: isoCode)
        }
        
        languages.sort { (language1, language2) -> Bool in
            guard let name1 = language1.languageName,
                let name2 = language2.languageName else {
                    return false
            }
            
            return name1.compare(name2) == .orderedAscending
        }
        
        return languages
    }
    
    public var languageCode: String
    public var translationCode: String?
    
    public var languageName: String? {
        let englishLocale = NSLocale(localeIdentifier: "en")
        let languageName = englishLocale.displayName(forKey: .identifier, value: languageCode)
        return languageName
    }
    
    public var translatedName: String? {
        guard let code = translationCode else {
            return nil
        }
        
        let translationLocale = NSLocale(localeIdentifier: code)
        let languageName = translationLocale.displayName(forKey: .identifier, value: languageCode)
        return languageName
    }
    
    public init(withCode languageCode: String, andTranslationCode translationCode: String? = nil) {
        self.languageCode = languageCode
        self.translationCode = translationCode
    }
    
}
