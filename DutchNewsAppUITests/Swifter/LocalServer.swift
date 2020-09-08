//
//  LocalServer.swift
//  DutchNewsAppUITests
//
//  Created by Kirill Sedykh on 08.09.2020.
//  Copyright © 2020 Kirill Sedykh. All rights reserved.
//

import Foundation
import Swifter

enum Method {
    case get, put, post, delete, patch
}

final class LocalServer {
    private let server = HttpServer()

    func start(port: Int) {
        do {
            try server.start(in_port_t(port))
        } catch {
            assertionFailure("Failed to start local server \(error.localizedDescription)")
        }
    }

    func stub(method: Method? = nil, httpResponse: HttpResponse? = nil,  path: String, with filename: String? = nil) {
        let response: ((HttpRequest) -> HttpResponse)!
        
        if let httpResponse = httpResponse {
            response = { _ in
                return httpResponse
            }
        } else {
            guard let fileName = filename,
                let data = FileLoader.loadJsonData(from: fileName),
                let json = dataToJSON(data: data) else { return }
            
            response = { _ in
                return HttpResponse.ok(.json(json))
            }
        }
        
        guard let method = method else {
            server[path] = response
            return
        }

        switch method {
        case .get:
            server.get[path] = response
        case .put:
            server.put[path] = response
        case .post:
            server.post[path] = response
        case .delete:
            server.delete[path] = response
        case .patch:
            server.patch[path] = response
        }
    }

    func stubBodyIntoResponse(for path: String) {
        let response: ((HttpRequest) -> HttpResponse) = { [weak self] request in
            let data = Data(bytes: request.body, count: request.body.count)
            guard let json = self?.dataToJSON(data: data) else {
                return HttpResponse.internalServerError
            }
            return HttpResponse.ok(.json(json))
        }

        server.put[path] = response
        server.post[path] = response
    }

    func stop() {
        server.stop()
    }

    private func dataToJSON(data: Data) -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil
    }
}
