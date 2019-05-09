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
    
    func deleteCodableRequest(endpoint: PSEndpoint, params: Any?, extraHeaders: [PSHTTPRequestHeader: String], _ completion: @escaping PSCodableRequestCompletion)
    
    func getRequest(endpoint: PSEndpoint, params: Any?, extraHeaders: [PSHTTPRequestHeader: String], _ completion: @escaping PSPluralRequestCompletion)
    
    func getCodableRequest(endpoint: PSEndpoint, params: Any?, extraHeaders: [PSHTTPRequestHeader: String], _ completion: @escaping PSCodableRequestCompletion)
    
    func getStatusCode(from response: URLResponse?) -> Int
    
    func getCodableString(from data: Data) -> String
    
    func translateBadRequest(statusCode: Int, jsonArray: [PSJson]) -> PSError
    func translateServerError(statusCode: Int, jsonArray: [PSJson]) -> PSError
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
    
    func deleteCodableRequest(endpoint: PSEndpoint, params: Any?, extraHeaders: [PSHTTPRequestHeader: String], _ completion: @escaping PSCodableRequestCompletion) {
        
        if let definitionParam = definitionParam {
            endpoint.add(restParam: definitionParam)
        }
        
        parent?.deleteCodableRequest(endpoint: endpoint, params: params, extraHeaders: extraHeaders, completion)
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

public extension PSFetcherParent {
    
    func getStatusCode(from response: URLResponse?) -> Int {
        return (response as? HTTPURLResponse)?.statusCode ?? 0
    }
    
    func getCodableString(from data: Data) -> String {
        return String(data: data, encoding: .utf8) ?? "[]"
    }
    
    func translateBadRequest(statusCode: Int, jsonArray: [PSJson]) -> PSError {
        var error: Error!
        
        switch statusCode {
        case 401:
            error = PSKnownError.unauthorized
        default:
            error = PSKnownError.badRequest(statusCode)
        }
        
        let defaultMessage = "Bad Request"
        let defaultErrorCode = "HTTP-\(statusCode)"
        
        if let errorInfo = jsonArray.first {
            let message = errorInfo["error"] as? String ?? errorInfo["message"] as? String ?? defaultMessage
            let errorCode = errorInfo["code"] as? String ?? errorInfo["errorCode"] as? String ?? defaultErrorCode
            let pserror = PSError(code: errorCode, message: message, error: error)
            pserror.statusCode = statusCode
            return pserror
        } else {
            let pserror = PSError(code: defaultErrorCode, message: defaultMessage, error: error)
            pserror.statusCode = statusCode
            return pserror
        }
    }
    
    func translateServerError(statusCode: Int, jsonArray: [PSJson]) -> PSError {
        let error = PSKnownError.serverError(statusCode)
        let defaultMessage = "Server Error"
        let defaultErrorCode = "HTTP-\(statusCode)"
        
        if let errorInfo = jsonArray.first {
            let message = errorInfo["error"] as? String ?? errorInfo["message"] as? String ?? defaultMessage
            let errorCode = errorInfo["code"] as? String ?? errorInfo["errorCode"] as? String ?? defaultErrorCode
            return PSError(code: errorCode, message: message, error: error)
        } else {
            return PSError(code: defaultErrorCode, message: defaultMessage, error: error)
        }
    }
    
}
