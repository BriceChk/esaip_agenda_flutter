# Changelog

All notable changes to this project will be documented in this file.

This project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).


<!-- Template:
## [NEW](https://github.com/JonasWanke/timetable/compare/vOLD...vNEW) ยท 2020-xx-xx
### โ  BREAKING CHANGES
### ๐ New Features
### โก Changes
### ๐ Bug Fixes
### ๐ Documentation updates
### ๐ Refactoring
### ๐ฆ Build & CI
-->

## [Unreleased](https://github.com/JonasWanke/timetable/compare/v0.2.9...master)


## [0.2.9](https://github.com/JonasWanke/timetable/compare/v0.2.8...v0.2.9) ยท 2020-10-26

### ๐ Bug Fixes
- Compatibility with Flutter v1.23 ([#57](https://github.com/JonasWanke/timetable/pull/57)), closes: [#55](https://github.com/JonasWanke/timetable/issues/55) (for Flutter `^1.23.0-13.0.pre`)


## [0.2.8](https://github.com/JonasWanke/timetable/compare/v0.2.7...v0.2.8) ยท 2020-09-18

### ๐ Bug Fixes
- Allow full-height `leadingHeaderBuilder`s ([#50](https://github.com/JonasWanke/timetable/pull/50)), closes: [#49](https://github.com/JonasWanke/timetable/issues/49)


## [0.2.7](https://github.com/JonasWanke/timetable/compare/v0.2.6...v0.2.7) ยท 2020-09-02

### ๐ New Features
- add `TimetableThemeData.minimumHourZoom` & `.maximumHourZoom`, closes: [#40](https://github.com/JonasWanke/timetable/issues/40) & [#45](https://github.com/JonasWanke/timetable/issues/45)

### ๐ Bug Fixes
- support null values in `InitialTimeRange.range`

### ๐ฆ Build & CI
- update <kbd>dartx</kbd> to `^0.5.0`


## [0.2.6](https://github.com/JonasWanke/timetable/compare/v0.2.5...v0.2.6) ยท 2020-07-12

### ๐ New Features
- add custom builders for date header and leading area of the header (usually a week indicator) ([#28](https://github.com/JonasWanke/timetable/pull/28)), closes: [#27](https://github.com/JonasWanke/timetable/issues/27). Thanks to [@TatsuUkraine](https://github.com/TatsuUkraine)!
- add theme properties for disabling event stacking and configuring the minimum overlap ([#34](https://github.com/JonasWanke/timetable/pull/34)), closes: [#31](https://github.com/JonasWanke/timetable/issues/31)

### ๐ Bug Fixes
- Expand part-day events to fill empty columns ([#30](https://github.com/JonasWanke/timetable/pull/30)), closes: [#29](https://github.com/JonasWanke/timetable/issues/29)


## [0.2.5](https://github.com/JonasWanke/timetable/compare/v0.2.4...v0.2.5) ยท 2020-07-06

### ๐ Documentation updates
- add Localization section to the README

### ๐ฆ Build & CI
- update <kbd>dartx</kbd> to `^0.4.0`


## [0.2.4](https://github.com/JonasWanke/timetable/compare/v0.2.3...v0.2.4) ยท 2020-06-25

### ๐ New Features
- `Timetable.onEventBackgroundTap`: called when tapping the background, e.g. for creating an event ([#20](https://github.com/JonasWanke/timetable/pull/20)), closes: [#18](https://github.com/JonasWanke/timetable/issues/18). Thanks to [@raLaaaa](https://github.com/raLaaaa)!
- add `EventProvider.simpleStream` as a simpler interface than `EventProvider.stream` ([e63bfb4](https://github.com/JonasWanke/timetable/commit/e63bfb4f974ce5319fd6f6bb12ebb561d8c5143c))

### ๐ Documentation updates
- improve streaming `EventProvider` documentation ([e63bfb4](https://github.com/JonasWanke/timetable/commit/e63bfb4f974ce5319fd6f6bb12ebb561d8c5143c)), fixes: [#19](https://github.com/JonasWanke/timetable/issues/19)


## [0.2.3](https://github.com/JonasWanke/timetable/compare/v0.2.2...v0.2.3) ยท 2020-06-15

### ๐ New Features
- Customizable date/weekday format with `TimetableThemeData.weekDayIndicatorPattern`, `.dateIndicatorPattern` & temporary `.totalDateIndicatorHeight` ([#16](https://github.com/JonasWanke/timetable/pull/16)), closes: [#15](https://github.com/JonasWanke/timetable/issues/15)


## [0.2.2](https://github.com/JonasWanke/timetable/compare/v0.2.1...v0.2.2) ยท 2020-05-30

### ๐ New Features
- optional `onTap`-parameter for `BasicEventWidget` & `BasicAllDayEventWidget` ([#12](https://github.com/JonasWanke/timetable/pull/12)), closes: [#11](https://github.com/JonasWanke/timetable/issues/11)

### ๐ฆ Build & CI
- specify minimum Dart version (v2.7.0) in `pubspec.yaml`


## [0.2.1](https://github.com/JonasWanke/timetable/compare/v0.2.0...v0.2.1) ยท 2020-05-19

### ๐ New Features
- All-day events (shown at the top) ([#8](https://github.com/JonasWanke/timetable/pull/8)), closes: [#5](https://github.com/JonasWanke/timetable/issues/5)
- Theming ([#9](https://github.com/JonasWanke/timetable/pull/9))โโโsee the README for more information!

### ๐ฆ Build & CI
- specify minimum Flutter version (v1.17.0) in `pubspec.yaml`
- **example:** upload generated APK as artifact


## [0.2.0](https://github.com/JonasWanke/timetable/compare/v0.1.3...v0.2.0) ยท 2020-05-08

### โ  BREAKING CHANGES
- fix week scroll alignment ([#6](https://github.com/JonasWanke/timetable/pull/6))
  - To provide a simpler API the exposed methods of `VisibleRange` were changed slightly. This doesn't affect you if you just instantiate one of the given implementations, but only if you extend it yourself or call one of its methods directly.

### ๐ Bug Fixes
- support Flutter v1.17.0 ([#4](https://github.com/JonasWanke/timetable/pull/4))


## [0.1.3](https://github.com/JonasWanke/timetable/compare/v0.1.2...v0.1.3) ยท 2020-05-06

### ๐ Bug Fixes
- fix time zooming & add testing ([#3](https://github.com/JonasWanke/timetable/pull/3))


## [0.1.2](https://github.com/JonasWanke/timetable/compare/v0.1.1...v0.1.2) ยท 2020-05-05

### ๐ New Features
- add `TimetableController.initialTimeRange`, closes: [#1](https://github.com/JonasWanke/timetable/issues/1)

### ๐ Bug Fixes
- fix week alignment with `WeekVisibleRange`, closes: [#2](https://github.com/JonasWanke/timetable/issues/2)


## [0.1.1](https://github.com/JonasWanke/timetable/compare/v0.1.0...v0.1.1) ยท 2020-04-02

### ๐ Documentation updates
- fix broken links in README


## 0.1.0 ยท 2020-04-02

Initial release ๐
