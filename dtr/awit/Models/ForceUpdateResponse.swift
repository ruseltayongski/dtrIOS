//
//  ForceUpdateResponse.swift
//  dtr
//
//  Created by ICTU1 on 12/7/23.
//

import Foundation

struct ForceUpdateResponse: Codable {
    var message: String
    var code: Int
    var latest_version: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.message = try container.decode(String.self, forKey: .message)
        self.code = try container.decode(Int.self, forKey: .code)
        self.latest_version = try container.decode(String.self, forKey: .latest_version)
    }
    
    init(message: String, code: Int, latest_version: String){
        self.message = message
        self.code = code
        self.latest_version = latest_version
    }
}
