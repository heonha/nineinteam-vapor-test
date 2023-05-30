//
//  verifySignature.swift
//  
//
//  Created by Heonjin Ha on 2023/05/30.
//

import Vapor
import Crypto

func verifySignature(payload: String, secretKey: String, signature: String) throws -> Bool {
    // Check if signature header is provided
    guard !signature.isEmpty else {
        throw Abort(.forbidden, reason: "x-hub-signature-256 header is missing!")
    }

    // Calculate SHA256 HMAC signature from the payload and the secret
    guard let secretKeyData = secretKey.data(using: .utf8),
          let payloadData = payload.data(using: .utf8) else {
        throw Abort(.internalServerError, reason: "Error encoding strings to UTF8")
    }

    let key = SymmetricKey(data: secretKeyData)
    let hmac = HMAC<SHA256>.authenticationCode(for: payloadData, using: key)
    let calculatedSignature = "sha256=" + hmac.compactMap { String(format: "%02x", $0) }.joined()

    // Compare the received signature with the calculated signature
    guard calculatedSignature == signature else {
        throw Abort(.forbidden, reason: "Request signatures didn't match!")
    }

    return true
}
