//
//  IssuesWidget.swift
//  Issues
//

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

import Combine
import DroppyKit
import SwiftUI

struct IssuesWidget: View {
    @ObservedObject var droplet: IssuesDroplet
    let context: ShelfWidgetContext

    var body: some View {
        VStack(alignment: .leading, spacing: DroppySpacing.sm) {
            header
            if context.isCompact {
                CompactBody()
            } else {
                SoloBody()
            }
        }
        .padding(context.contentInsets)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }

    var header: some View {
        HStack(spacing: DroppySpacing.xsm) {
            Image(systemName: "smallcircle.fill.circle")
                .font(.system(size: 12, weight: .medium))
            Text("Issues")
                .font(.system(size: 12, weight: .semibold))
            Spacer(minLength: 0)
            // The widget's one control: the same Liquid Glass disc the
            // File Tray puts on an item.
            Button {
                // Create a new issue
            } label: {
                Image(systemName: "plus")
            }
            .buttonStyle(DroppyCircleButtonStyle(size: 20))
            .help("New issue")
            .accessibilityLabel("New issue")
        }
        .foregroundStyle(AdaptiveColors.notchSurfaceSecondaryText)
    }
}

private struct SoloBody: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: DroppySpacing.sm) {
                ForEach(0..<10, id: \.self) { i in
                    IssueRow(i: i, isCompact: false)
                }
            }
        }
        .scrollIndicators(.never)
    }
}

private struct CompactBody: View {
    var body: some View {
        VStack(alignment: .leading, spacing: DroppySpacing.sm) {
            HStack(alignment: .center, spacing: DroppySpacing.xsm) {
                Text("10")
                    .font(.system(size: 22, weight: .semibold, design: .rounded))
                    .foregroundStyle(AdaptiveColors.notchSurfacePrimaryText)
                Text("open issues for you")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(AdaptiveColors.notchSurfaceSecondaryText)
            }
        }
    }
}

private struct IssueRow: View {
    let i: Int
    let isCompact: Bool
    var body: some View {
        HStack(spacing: DroppySpacing.xsm) {
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .center, spacing: DroppySpacing.xsm) {
                    Button {
                        // Change the state of the issue (e.g., mark as resolved)
                    } label: {
                        Image(systemName: "smallcircle.fill.circle")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(
                                Color(red: 0.247, green: 0.729, blue: 0.314))
                        // Image(systemName: "checkmark.circle")
                        //     .font(.system(size: 12, weight: .medium))
                        //     .foregroundColor(Color(red: 0.671, green: 0.490, blue: 0.973))
                    }
                    .buttonStyle(.borderless)
                    .help("Close this issue")
                    .accessibilityLabel("Close this issue")
                    Text("Issue \(i + 1)")
                        .font(.system(size: 12, weight: .medium))
                    Text("#\(i + 1)")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(AdaptiveColors.notchSurfaceTertiaryText)
                }
                if !isCompact {
                    HStack(spacing: DroppySpacing.xsm) {
                        Text("bk24z opened \(i + 1)d ago")
                        Label("a11y", systemImage: "tag")
                        Label("v1.0.0", systemImage: "signpost.right")
                    }
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(AdaptiveColors.notchSurfaceSecondaryText)
                }
            }
            Spacer(minLength: 0)
            Group {
                if !isCompact {
                    Button {
                        // Handle the edit action
                    } label: {
                        Image(systemName: "square.and.pencil")
                    }
                    .help("Edit this issue")
                    .accessibilityLabel("Edit this issue")
                    Button {
                        // Open on GitHub or the relevant platform for the issue
                    } label: {
                        Image(systemName: "arrow.up.forward.app")
                    }
                    .help("Open on GitHub")
                    .accessibilityLabel("Open on GitHub")
                }
                Button {
                    // See more details about the issue, e.g., open it in a new window or navigate to its page
                } label: {
                    Image(systemName: "chevron.right")
                }
                .help("View details")
                .accessibilityLabel("View details")
            }
            .font(.system(size: 12, weight: .medium))
            .buttonStyle(DroppyCircleButtonStyle(size: 20))
        }
    }
}
