# poindeo-plugins

Poindeo MCP plugin marketplace for Claude Code.

## Install

    claude plugin marketplace add poindeo/poindeo-plugins
    claude plugin install poindeo-mcp@poindeo-plugins

Run `/mcp` in a session and confirm `poindeo` is connected. The first tool call opens the Poindeo editor in your browser automatically.

Claude Code on Windows: MCP startup uses an extensionless shell script; if the server fails to launch, register the npm package directly instead (see the Claude Code section at https://poindeo.com/mcp).

## Uninstall

    claude plugin uninstall poindeo-mcp@poindeo-plugins
    claude plugin marketplace remove poindeo-plugins

## Notes

- The plugin bundles its own server (`plugins/poindeo-mcp/tools/mcp-server/`) — no global npm install required.
- The server checks the npm registry for new versions in the background and downloads them to `~/.poindeo-mcp/store/`; the new version becomes active on the next start (disable with `POINDEO_MCP_NO_UPDATE=1`).
- Version: 0.1.7
