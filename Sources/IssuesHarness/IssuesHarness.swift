//
//  IssuesHarness.swift
//
//  Run with: droppykit run
//
//  Not named main.swift on purpose: Swift treats that name as top-level code,
//  which cannot coexist with @main.
//

import DroppyKit
import DroppyKitHarness
import Issues

@main
struct IssuesHarness: DropletHarnessApp {
    static func makeDroplet() -> any Droplet { IssuesDroplet() }
}
