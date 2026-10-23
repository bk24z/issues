//
//  IssuesDroplet.swift
//  Issues
//

import Combine
import DroppyKit
import SwiftUI

/// The class Droppy's loader instantiates, named in the bundle's
/// `NSPrincipalClass`. Keep it empty: it runs before the host is ready.
@objc(IssuesPrincipal)
public final class IssuesPrincipal: NSObject, DropletPrincipal {
    public override init() { super.init() }

    @MainActor public func makeDroplet() -> AnyObject { IssuesDroplet() }
}

/// Issues.
@MainActor
public final class IssuesDroplet: NSObject, ObservableObject, Droplet {
    /// Must equal `DroppyDropletID` in the bundle's Info.plist and `id` in
    /// droplet.json. The loader refuses the bundle if the three disagree.
    public nonisolated static let id: DropletID = "issues"

    private var host: DropletHost?

    public func activate(host: DropletHost) throws {
        self.host = host
        host.log.info("Issues activated")
    }

    public func deactivate() {
        // Everything activate() started is torn down here. Swift cannot unload
        // code, so anything left running keeps running until Droppy relaunches.
        host = nil
    }

    /// What the widget's control does. Replace it with the real action.
    public func refresh() {
        host?.log.info("Issues refreshed")
    }

    /// Opens the solo widget layout from the compact shelf widget.
    public func showAllIssues() {
        host?.shelf.open(revealing: "issues")
    }
}

// MARK: - Shelf widget

extension IssuesDroplet: ShelfWidgetProviding {
    public var widgetDescriptors: [ShelfWidgetDescriptor] {
        [
            ShelfWidgetDescriptor(
                id: "issues",
                title: "Issues",
                systemImage: "smallcircle.fill.circle",
                layoutTraits: ShelfWidgetLayoutTraits(
                    // The CARD, in points at the Regular shelf size: the area
                    // your view draws in, which is what the harness shows.
                    // Droppy adds its own chrome around it. Both widths are
                    // required; Droppy refuses a descriptor that leaves
                    // either to a host fallback. The height is clamped to
                    // 48 through 480 and holds in a paired row too.
                    preferredSoloWidth: 420,
                    preferredPairedWidth: 210,
                    contentHeight: .fixed(150)
                )
            )
        ]
    }

    public func makeWidgetView(_ id: ShelfWidgetID, context: ShelfWidgetContext) -> AnyView {
        AnyView(IssuesWidget(droplet: self, context: context))
    }

    public func makeWidgetSettingsPopover(_ id: ShelfWidgetID) -> AnyView? { nil }
}
