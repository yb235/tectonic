# Dev Container Setup

This guide explains how to start developing in a VS Code Dev Container for this workspace.

## Prerequisites

- Docker (or an alternative compatible container engine)
- Visual Studio Code
- The VS Code “Dev Containers” extension

## Start the Dev Container (VS Code)

1. Open the folder in VS Code.
2. Open the Command Palette ($$Ctrl+Shift+P$$ / $$Cmd+Shift+P$$).
3. Run: **Dev Containers: Reopen in Container**.
4. Wait for the container to build and the window to reload.

## If the Container Is Already Open

- Use **Dev Containers: Rebuild Container** to rebuild from scratch.
- Use **Dev Containers: Reopen Folder Locally** to exit the container.

## Verify You’re in the Container

- Check the green “><” status bar indicator in VS Code (bottom-left).
- Open a terminal in VS Code and run:
  - `uname -a`
  - `cat /etc/os-release`

You should see a Linux environment (the container OS).

## Common Troubleshooting

- **Build fails**: Run **Dev Containers: Rebuild Container**.
- **Docker not running**: Start Docker Desktop or your container engine.
- **Stuck on configuring**: Check the Dev Containers logs in the VS Code Output panel.

## Notes for Windows Users

- Prefer running Docker Desktop with WSL 2 enabled.
- Keep the project inside the WSL file system for best performance.

---

If you need to update container settings, edit the `.devcontainer` configuration and rebuild the container.