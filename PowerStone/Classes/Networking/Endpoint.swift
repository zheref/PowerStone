//
//  Endpoint.swift
//  PowerStone
//
//  Created by Sergio Daniel on 1/8/19.
//

import Foundation

public struct PSEndpoint {
    var host: String
    var base: String?
    
    var restParams = PSStack<PSEndpointParam>()
    var httpParams = PSStack<PSEndpointParam>()
    
    public init(host: String) {
        self.host = host
    }
    
    public func add(restParam: PSEndpointParam, overwrite: Bool = false) {
        if !overwrite, let _ = restParams.stackArray.first(where: { $0.name == restParam.name }) {
            print("PowerStone >>> Name '\(restParam.name)' already exists as a REST param")
        } else {
            remove(restParamWithName: restParam.name)
            restParams.push(element: restParam)
        }
    }
    
    public func remove(restParamWithName restParamName: String) {
        restParams.stackArray.removeAll { $0.name == restParamName }
    }
    
    public func add(restParam: String, value: String?, overwrite: Bool = false) {
        let param = PSEndpointParam(name: restParam, value: value)
        add(restParam: param, overwrite: overwrite)
    }
    
    public func add(httpParam: PSEndpointParam) {
        httpParams.push(element: httpParam)
    }
    
    public var stringValue: String {
        var path = "\(host)"
        
        if let base = base {
            path = "\(path)/\(base)"
        }
        
        if restParams.isNotEmpty {
            path = "\(path)/\(restParamsString)"
        }
        
        guard httpParams.isNotEmpty else {
            return path
        }
        
        path = "\(path)?\(httpParamsString)"
        
        return path
    }
    
    private var restParamsString: String {
        var paramsString = String()
        
        restParams.iterate { (param, index) in
            paramsString = index == restParams.count - 1 ? "\(param.restFormatted)" : "\(paramsString)/\(param.restFormatted)"
        }
        
        return paramsString
    }
    
    private var httpParamsString: String {
        var paramsString = String()
        
        httpParams.iterate { (param, index) in
            paramsString = index == httpParams.count - 1 ? "\(param.httpFormatted)" : "\(paramsString)&\(param.httpFormatted)"
        }
        
        return paramsString
    }
    
}

public struct PSEndpointParam : Codable {
    var name: String
    var value: String?
    
    public init(name: String, value: String?) {
        self.name = name
        self.value = value
    }
    
    var restFormatted: String {
        if let value = value {
            return "\(name)/\(value)"
        } else {
            return "\(name)"
        }
    }
    
    var httpFormatted: String {
        if let value = value {
            return "\(name)=\(value)"
        } else {
            return "\(name)"
        }
    }
}
