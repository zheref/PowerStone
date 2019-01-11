//
//  FetcherParent.swift
//  PowerStone
//
//  Created by Sergio Daniel on 1/8/19.
//

import Foundation

public typealias PSHeadersDict = [PSHTTPRequestHeader: String]

public enum PSHTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public enum PSHTTPRequestHeader : String {
    case contentType = "Content-Type"
    case accept = "Accept"
    
    case appVersion = "App-Version"
    case appBuild = "App-Build"
    case authorization = "Authorization"
    case sourceApp = "Source-App"
    case osName = "Os-Name"
    case osVersion = "Os-Version"
    case deviceLatitude = "Device-Lat"
    case deviceLongitude = "Device-Lng"
    case deviceAcc = "Device-Acc"
    case appLanguage = "App-Language"
    case appKey = "App-Key"
    case authToken = "Auth-Token"
    case zoneId = "Zone-Id"
    case userPhone = "User-Phone"
    case jsonEncoding = "Json-Case-Encoding"
}

public protocol PSFetcherParent {
    var baseUrl: String { get }
    var definitionParam: PSEndpointParam? { get }
    var parent: PSFetcherParent? { get set }
    
    func postRequest(endpoint: PSEndpoint, params: Any?, extraHeaders: [PSHTTPRequestHeader: String], _ completion: @escaping PSPluralRequestCompletion)
    
    func postCodableRequest(endpoint: PSEndpoint, params: Any?, extraHeaders: [PSHTTPRequestHeader: String], _ competion: @escaping PSCodableRequestCompletion)
    
    func getRequest(endpoint: PSEndpoint, params: Any?, extraHeaders: [PSHTTPRequestHeader: String], _ completion: @escaping PSPluralRequestCompletion)
    
    func getCodableRequest(endpoint: PSEndpoint, params: Any?, extraHeaders: [PSHTTPRequestHeader: String], _ completion: @escaping PSCodableRequestCompletion)
}

public extension PSFetcherParent {
    
    var baseUrl: String {
        return parent?.baseUrl ?? ""
    }
    
    func postRequest(endpoint: PSEndpoint, params: Any?, extraHeaders: [PSHTTPRequestHeader : String], _ completion: @escaping PSPluralRequestCompletion) {
        
        if let definitionParam = definitionParam {
            endpoint.add(restParam: definitionParam)
        }
        
        parent?.postRequest(endpoint: endpoint, params: params, extraHeaders: extraHeaders, completion)
    }
    
    func postCodableRequest(endpoint: PSEndpoint, params: Any?, extraHeaders: [PSHTTPRequestHeader : String], _ completion: @escaping PSCodableRequestCompletion) {
        
        if let definitionParam = definitionParam {
            endpoint.add(restParam: definitionParam)
        }
        
        parent?.postCodableRequest(endpoint: endpoint, params: params, extraHeaders: extraHeaders, completion)
    }
    
    func getRequest(endpoint: PSEndpoint, params: Any?, extraHeaders: [PSHTTPRequestHeader : String], _ completion: @escaping PSPluralRequestCompletion) {
        
        if let definitionParam = definitionParam {
            endpoint.add(restParam: definitionParam)
        }
        
        parent?.getRequest(endpoint: endpoint, params: params, extraHeaders: extraHeaders, completion)
    }
    
    func getCodableRequest(endpoint: PSEndpoint, params: Any?, extraHeaders: [PSHTTPRequestHeader : String], _ completion: @escaping PSCodableRequestCompletion) {
        
        if let definitionParam = definitionParam {
            endpoint.add(restParam: definitionParam)
        }
        
        parent?.getCodableRequest(endpoint: endpoint, params: params, extraHeaders: extraHeaders, completion)
    }
    
}
