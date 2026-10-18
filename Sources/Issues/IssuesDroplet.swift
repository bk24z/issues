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
}

// MARK: - Shelf widget

extension IssuesDroplet: ShelfWidgetProviding {
    public var widgetDescriptors: [ShelfWidgetDescriptor] {
        [
            ShelfWidgetDescriptor(
                id: "issues",
                title: "Issues",
                systemImage: "drop.fill",
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

/// The widget.
///
/// Solo and paired are different compositions, not one view at two widths.
/// Branch on `context.isCompact`, never on a width comparison.
///
/// The layout is the one every Droppy widget shares (Design guidelines):
/// no card or border, the content straight on the shelf; one padding,
/// `context.contentInsets`, which clears the host's rounded clip for this
/// slot (8 against the 18pt card corner, 0 alone on the island, which the
/// island shell clips), and nothing on top of it; the root
/// fills the rectangle; a header row of symbol and title with the widget's
/// control at its trailing end; leading text, trailing numbers; buttons are
/// Droppy's Liquid Glass disc and pill, never a wash of your own.
private struct IssuesWidget: View {
    @ObservedObject var droplet: IssuesDroplet
    let context: ShelfWidgetContext

    var body: some View {
        VStack(alignment: .leading, spacing: DroppySpacing.sm) {
            HStack(spacing: DroppySpacing.xsm) {
                Image(systemName: "list.bullet.rectangle")
                    .font(.system(size: 12, weight: .medium))
                Text("Issues")
                    .font(.system(size: 12, weight: .semibold))
                Spacer(minLength: 0)
                if !context.isCompact {
                    // The widget's one control: the same Liquid Glass disc the
                    // File Tray puts on an item.
                    Button {
                        // Handle the create issue action
                    } label: {
                        Image(systemName: "plus")
                    }
                    .buttonStyle(DroppyCircleButtonStyle(size: 20))
                    .help("Create issue")
                    .accessibilityLabel("Create issue")
                }
            }
            .foregroundStyle(AdaptiveColors.notchSurfaceSecondaryText)

            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: DroppySpacing.sm) {
                    HStack(alignment: .center, spacing: DroppySpacing.xsm) {
                        Text("10")
                            .font(.system(size: 22, weight: .semibold, design: .rounded))
                            .foregroundStyle(AdaptiveColors.notchSurfacePrimaryText)
                        Text("open issues for you")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(AdaptiveColors.notchSurfaceSecondaryText)
                    }
                    ForEach(0..<10, id: \.self) { i in
                        HStack(spacing: DroppySpacing.xsm) {
                            Button {
                                // Change the state of the issue (e.g., mark as resolved)
                            } label: {
                                Image(systemName: "smallcircle.fill.circle")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(Color(red: 0.247, green: 0.729, blue: 0.314))
                            }
                            .buttonStyle(.borderless)
                            Text("Issue \(i + 1)")
                                .font(.system(size: 12, weight: .medium))
                            Spacer(minLength: 0)
                            Text("\(Int.random(in: 1 ... 100))")
                                .font(.system(size: 12, weight: .semibold))
                        }
                    }
                }
            }
            .scrollIndicators(.never)
        }
        .padding(context.contentInsets)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}
