//
//  GitHubWebhookController.swift
//  
//
//  Created by Heonjin Ha on 2023/05/30.
//

import Vapor

final class GitHubWebhookController {
    func handle(_ req: Request) throws -> EventLoopFuture<Response> {
        // 여기에 웹훅 처리 로직을 구현합니다.

        // Secret 키 검증 로직
        guard let secretKey = Environment.get("SECRET_TOKEN") else {
            throw Abort(.internalServerError, reason: "No SECRET_TOKEN in environment")
        }
        guard let signature = req.headers.first(name: "X-Hub-Signature-256"),
              let payload = req.body.string else {
            throw Abort(.unauthorized, reason: "Signature or Payload missing")
        }

        do {
            let isVerified = try verifySignature(payload: payload, secretKey: secretKey, signature: signature)
            guard isVerified else {
                throw Abort(.unauthorized, reason: "Signature did not match")
            }
        } catch let error {
            return req.eventLoop.makeFailedFuture(error)
        }

        // 웹훅 이벤트 처리 후 서버 재시작
        do {
            try restartServer(app: req.application)
        } catch {
            // 서버 재시작 실패
            return req.eventLoop.makeFailedFuture(error)
        }

        // 응답 생성
        let responseJSON: [String: String] = [
            "content_type": "json",
            "insecure_ssl": "0",
            "secret": "********",
            "url": "https://example.com/webhook"
        ]
        let response = Response(status: .ok, headers: HTTPHeaders([("Content-Type", "application/json")]))
        try response.content.encode(responseJSON, as: .json)
        return req.eventLoop.makeSucceededFuture(response)
    }
}
