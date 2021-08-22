//
//  DataModel.swift
//  Git Finder
//
//  Created by Asif Mimi Rabbi on 3/8/21.
//

import Foundation
import SwiftJWT

struct UsersInfo : Codable {

   let login : String?
   let url : String?
   let avatarUrl : String?

   enum CodingKeys: String, CodingKey {
         case login = "login"
         case url = "url"
         case avatarUrl = "avatar_url"
   }
}

struct Token: Decodable {
    var jwtString: String = "hello world"

    func abc() {
        do {
            let newJWT = try JWT<MyJWTClaims>(jwtString: jwtString)
            print(newJWT.claims.exp)
        } catch {
            print("error")
        }
    }
}

struct MyJWTClaims: Claims {
    let exp: Date
}
