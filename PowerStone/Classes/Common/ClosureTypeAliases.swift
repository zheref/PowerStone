//
//  ClosureTypeAliases.swift
//  PowerStone
//
//  Created by Sergio Daniel L. García on 7/9/18.
//

import Foundation

public typealias PSJson = [String: Any?]
public typealias PSRegularDictionary = [String: Any]
public typealias PSSafeDictionary = [AnyHashable: Any?]

public typealias PSRequestBody = [AnyHashable: Any]

public typealias PSHandler = () -> Void

public typealias PSCallback = (PSJson?, Error?) -> Void
public typealias PSCompletion = PSCallback

public typealias PSReturner = (PSJson) -> Void
public typealias PSFailer = (PSError) -> Void
public typealias PSRecorder = (String) -> Void

public typealias PSRequestCompletion = (PSJson?, PSError?) -> Void
public typealias PSStringCompletion = (String?, PSError?) -> Void
public typealias PSPluralRequestCompletion = ([PSJson]?, PSError?) -> Void
public typealias PSCodableRequestCompletion = (String?, PSError?) -> Void

public typealias PSEchoRequestCompletion = (PSEcho) -> Void
