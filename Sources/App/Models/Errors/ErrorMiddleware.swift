//
//  ErrorMiddleware.swift
//  
//
//  Created by Heonjin Ha on 2023/05/30.
//

import Vapor

struct ErrorMiddleware: Middleware {
    func respond(to request: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
        next.respond(to: request).flatMapAlways { result in
            switch result {
            case .success(let response):
                return request.eventLoop.future(response)
            case .failure(let error):
                let status: HTTPResponseStatus
                let errorMessage: String

                if let appError = error as? AppError {
                    status = .badRequest
                    errorMessage = appError.description
                } else {
                    status = .internalServerError
                    errorMessage = "Internal server error"
                }

                let errorResponse = ErrorResponse(result: "ERROR", description: errorMessage)
                let errorBody = try? JSONEncoder().encode(errorResponse)

                return request.eventLoop.future(
                    Response(status: status, body: .init(data: errorBody ?? Data()))
                )
            }
        }
    }
}
