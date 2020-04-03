//
//  JSONStringResponse.swift
//  UITestUtils
//
//  Created by Duckie N on 4/2/20.
//  Copyright © 2020 Nguyen Van Duc. All rights reserved.
//

import Foundation
import EnvoyAmbassador
import ObjectMapper

public struct JSONStringResponse: WebApp {
    
    let dataResponse: DataResponse

    public init(
        statusCode: Int = 200,
        statusMessage: String = "OK",
        contentType: String = "application/json",
        jsonWritingOptions: JSONSerialization.WritingOptions = .prettyPrinted,
        headers: [(String, String)] = [],
        handler: ((_ environ: [String: Any]) -> String)? = nil
    ) {
        dataResponse = DataResponse(
            statusCode: statusCode,
            statusMessage: statusMessage,
            contentType: contentType,
            headers: headers
        ) { environ, sendData in
            let data: Data
            if let handler = handler {
                let json = handler(environ)
                data = Data(json.utf8)
            } else {
                data = Data()
            }
            sendData(data)
        }
    }
    
    public func app(_ environ: [String : Any], startResponse: @escaping ((String, [(String, String)]) -> Void), sendBody: @escaping ((Data) -> Void)) {
        
        return dataResponse.app(environ, startResponse: startResponse, sendBody: sendBody)
    }
}
