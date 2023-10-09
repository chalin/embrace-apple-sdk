//
//  Copyright © 2023 Embrace Mobile, Inc. All rights reserved.
//

import Foundation
import OpenTelemetryApi

extension Span {

    func setAttribute(key: SpanAttributeKey, value: String) {
        setAttribute(key: key.rawValue, value: value)
    }

    /// Mark this Span as important  so the backend will create aggregate metrics for it, and the UI will show it as a "top level" span
    func markAsKeySpan() {
        setAttribute(key: SpanAttributeKey.isKey, value: "true")
    }

    /**
     * Monotonically increasing ID given to completed span that is expected to sent to the server. Can be used to track data loss on the server.
     */
    func setSequenceId(_ sequenceId: UInt64) {
        setAttribute(key: SpanAttributeKey.sequenceId, value: String(sequenceId))
    }

    func end(errorCode: SpanErrorCode? = nil, time: Date? = nil) {
        if let errorCode = errorCode {
            setAttribute(key: SpanAttributeKey.errorCode, value: errorCode.rawValue)
            status = .error(description: errorCode.rawValue)
        } else {
            status = .ok
        }

        if let time = time {
            end(time: time)
        } else {
            end()
        }

    }

}
