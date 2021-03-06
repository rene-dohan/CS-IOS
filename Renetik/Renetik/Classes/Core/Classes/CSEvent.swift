// Created by Rene Dohan on 9/23/19.
//

public func event<Type>() -> CSEvent<Type> { CSEvent<Type>() }

public func event() -> CSEvent<Void> { CSEvent<Void>() }

public class CSEventRegistration: CSObject {
    open var isActive = true

    open func cancel() { fatalError() }
}

public struct CSEventArgument<Type> {
    public let registration: CSEventListener<Type>
    public let argument: Type
}

public class CSEventListener<Type>: CSEventRegistration {

    public typealias CSEventFunction = (CSEventListener<Type>, Type) -> Void

    private unowned let event: CSEvent<Type>
    private let function: CSEventFunction

    fileprivate init(event: CSEvent<Type>, function: @escaping CSEventFunction) {
        self.event = event
        self.function = function
    }

    private var canceled = false

    override public func cancel() {
        if canceled { return }
        isActive = false
        event.remove(listener: self)
        canceled = true
    }

    fileprivate func fire(_ argument: Type) {
        if isActive { function(self, argument) }
    }
}

public class CSEvent<Type> {

    public init() {}

    private var registrations = [CSEventListener<Type>]()

    public func fire(_ argument: Type) {
        for registration in registrations { registration.fire(argument) }
    }

    @discardableResult
    public func listen(function: @escaping (Type) -> Void) -> CSEventListener<Type> {
        registrations.add(CSEventListener(event: self, function: { _, argument in
            function(argument)
        }))
    }

    @discardableResult
    public func listen(function: @escaping (CSEventListener<Type>, Type) -> Void) -> CSEventListener<Type> {
        registrations.add(CSEventListener(event: self, function: function))
    }

    @discardableResult
    public func listenOnce(function: @escaping ArgFunc<Type>) -> CSEventListener<Type> {
        listen(function: { registration, argument in
            registration.cancel()
            function(argument)
        })
    }

    fileprivate func remove(listener: CSEventListener<Type>) {
        registrations.remove(all: listener)
    }
}

public extension CSEvent where Type == Void {
    public func fire() { fire(()) }

    @discardableResult
    public func listenOnce(function: @escaping Func) -> CSEventListener<Type> {
        listen(function: { registration, argument in
            registration.cancel()
            function()
        })
    }

    @discardableResult
    public func listen(function: @escaping Func) -> CSEventListener<Type> {
        registrations.add(CSEventListener(event: self, function: { _, argument in
            function()
        }))
    }
}