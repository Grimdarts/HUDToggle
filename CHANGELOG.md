# Changelog

All notable changes to HUDToggle. Versions follow [Semantic Versioning](https://semver.org/).

## [1.1.0] - 2026-11-01
### Added
- The FFXIDB minimap plugin is hidden too (unloaded and loaded again).
### Changed
- The SMN HUD line only applies when SMN is the main job.
- `//hud show` undoes exactly what the last `//hud hide` did, even after a job change.

## [1.0.0] - 2026-11-01
### Added
- First version: `//hud` toggles, `//hud hide`, `//hud show`, `//hud list`. Hides addons with
  their own commands, flips toggle-only windows, and unloads/loads addons with no hide command.
  Shows everything again at logout or if HUDToggle is unloaded while hidden.
