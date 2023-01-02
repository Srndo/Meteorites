//
//  Observable.swift
//  Meteorites
//
//  Created by Simon Sestak on 27/08/2021.
//

import Foundation

class Observable<T> {
    var value: T {
        didSet {
            if let listenerWithValue = listenerWithValue {
                listenerWithValue(value)
            } else {
                listener?()
            }
        }
    }

    private var listenerWithValue: ((T) -> Void)?
    private var listener: (() -> Void)?

    init(_ value: T) {
        self.value = value
    }

    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listenerWithValue = closure
    }

    func bind(_ closure: @escaping () -> Void) {
        closure()
        listener = closure
    }

    func unbind() {
        listenerWithValue = nil
        listener = nil
    }
}
