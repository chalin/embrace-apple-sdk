//
//  Copyright © 2023 Embrace Mobile, Inc. All rights reserved.
//

import OpenTelemetryApi
import OpenTelemetrySdk
import Foundation

class EmbraceLoggerSharedState {
    let resource: Resource
    let processors: [LogRecordProcessor]
    private(set) var config: any EmbraceLoggerConfig

    init(
        resource: Resource,
        config: any EmbraceLoggerConfig,
        processors: [LogRecordProcessor]
    ) {
        self.resource = resource
        self.config = config
        self.processors = processors
    }

    static func `default`() -> EmbraceLoggerSharedState {
        .init(resource: .init(),
              config: DefaultEmbraceLoggerConfig(),
              processors: [])
    }

    func update(_ config: any EmbraceLoggerConfig) {
        self.config = config
    }
}