<p align="center">
  <img alt="header" src="https://shieldcn.dev/header/gradient.svg?title=Issues&amp;subtitle=Review+and+create+GitHub+issues+from+your+notch.+Built+with+DroppyKit%2C+for+Droppy.&amp;logo=lu%3ACircleDot&amp;mode=dark&amp;image=https%3A%2F%2Fimages.unsplash.com%2Fphoto-1614850523459-c2f4c699c52e%3Fw%3D1600%26q%3D70%26fit%3Dcrop%26fm%3Djpg" />
</p>

<p align="center">
  <a href="https://getdroppy.app/docs/droppykit"><img alt="Custom badge" src="https://shieldcn.dev/badge/built%20with-DroppyKit-abcde3.svg?logo=ri%3APiDropSimple&amp;color=1016C9" /></a>
  <a href="https://github.com/bk24z/issues"><img alt="stars" src="https://shieldcn.dev/github/bk24z/issues/stars.svg" /></a>
  <img alt="built in" src="https://shieldcn.dev/flag/gb.svg" />
</p>

## Overview

A lightweight GitHub issue manager for [Droppy](https://getdroppy.app), built with [DroppyKit](https://getdroppy.app/docs/droppykit).

GitHub Issues is great for tracking development work, but creating, reviewing and updating issues can feel like more effort than it needs to be.

**Issues** brings GitHub issue management into your Mac's notch through Droppy, making it easier to capture ideas, track development work, and pick up where you left off. It aims to make managing issues feel as effortless as ticking off a to-do list, while retaining GitHub's powerful issue-tracking capabilities.

## Status

**🚧 Early development - not yet functional**

The project currently focuses on the shelf widget's UI and interaction design, using placeholder data. GitHub integration and issue management functionality are upcoming.

## Planned features

- View and filter GitHub issues across repositories
- Quickly create, edit and close issues
- Access issue details, labels and milestones
- Open issues directly on GitHub
- Time tracker to help you stay focused and keep track of where development time is being spent

## Behind the project

**A note from Bradley:**

> "Issues is both a tool I'm building to solve a problem I've experienced myself and an opportunity to grow as a developer.
>
> My journey with Swift and SwiftUI began with my A-Level Computer Science NEA project. While I was proud of what I built, looking back I realised that relying too heavily on external guidance sometimes came at the expense of truly understanding my own code.
>
> With Issues, I'm taking a different approach: building incrementally, making more of my own technical decisions, and prioritising understanding over simply getting things working.
>
> I'm also excited to explore open-source development for the first time, from learning how to maintain a project to collaborating with others and contributing something useful to the Droppy community. 
> 
> This is also an opportunity for me to learn healthier agentic development: my aim is to use agentic tools like Codex and Claude Code as a tool, not a replacement, to help get mundane tasks done faster and patch gaps in my knowledge, while still remaining the main orchestrator in understanding and writing code.
>
> I'm still learning, and constructive feedback is always appreciated!"

## Feedback and contributions

Feedback, suggestions and contributions are welcome as the project develops.

## Developing

```bash
droppykit run        # open it in Droppy's Settings panel
droppykit build      # produce Issues.droplet
droppykit validate   # the checks the Store repository runs
droppykit submit     # open the merge request that puts it in the Store
```

## With a coding agent

Open this folder in Claude Code, Codex or Cursor. `AGENTS.md` is the brief they read first, and `.mcp.json` / `.cursor/mcp.json` connect the DroppyKit MCP server, which gives them the build, the checks, pictures of every surface and an install into Droppy Playground as tools. Codex registers the server once per Mac: `codex mcp add droppykit -- path/to/droppykit/Scripts/droppykit mcp`. Run `droppykit agent` again after moving this folder or the SDK checkout.

## Before submitting

- Leave `Issues.icon` as it is. It is a placeholder for the harness: Jordy designs every Store droplet's icon, and `droppykit submit` leaves it out. Have an idea for yours? Put it in the merge request's Icon concept section.
- Replace `Assets/Creator.png` with your own square, unrounded mark.
- Fill in `summary`, `description` and `creator` in `droplet.json`, and write `CHANGELOG.md`.
- `droppykit submit`: the Store is a repository, one folder per droplet, and this opens the merge request that adds yours. See [Submitting](https://getdroppy.app/docs/droppykit/submitting).

## License

Issues uses an **MIT license**: the full license text can be found in [LICENSE](https://github.com/bk24z/issues/blob/main/LICENSE).
