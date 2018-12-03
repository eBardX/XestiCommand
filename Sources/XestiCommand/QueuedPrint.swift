// © 2018 J. G. Pusey (see LICENSE.md)

import Dispatch
import Foundation

public func qfatalError(_ message: @autoclosure () -> String = "",
                        file: StaticString = #file,
                        line: UInt = #line) -> Never {
    outputQueue.sync {
        fflush(stdout)

        let file = ("\(file)" as NSString).lastPathComponent

        fputs("\(message()): file \(file), line \(line)\n", stderr)
    }

    abort()
}

public func qprint(_ item: Any) {
    outputQueue.async {
        print(item)
    }
}

public func qprintError(_ item: Any) {
    outputQueue.async {
        fflush(stdout)
        fputs(String(describing: item) + "\n", stderr)
    }
}

private let outputQueue: DispatchQueue = {
    let queue = DispatchQueue(label: "com.xesticode.XestiCommand.outputQueue",
                              qos: .userInteractive,
                              target: .global(qos: .userInteractive))

    atexit_b {
        queue.sync(flags: .barrier) {}
    }

    return queue
}()
