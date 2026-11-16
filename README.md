# Umpire-Tracker

## Overview
The Digital Umpire Counter is a tap-based watchOS application designed for local cricket matches and net sessions. It allows umpires to seamlessly log balls, runs, extras, and wickets directly from their wrist, eliminating the need to pull out a smartphone between deliveries.

## Key Features

Comprehensive Scoring: Logs legal deliveries (0-6 runs), extras (Wides, No-Balls, Byes, Leg Byes), and wickets.

Smart Over Tracking: Automatically differentiates between legal deliveries that count toward the over and extras that incur a run penalty without incrementing the ball count.

Contextual Haptics:

Triggers a distinct .success sustained haptic vibration upon logging the 6th legal delivery of an over, allowing the umpire to call "Over!" without looking at the screen.

Plays a light .click haptic for standard deliveries for immediate tactile confirmation.

Uses a .retry haptic when undoing an action.

Complex Delivery Handling: Utilizes custom SwiftUI menus to handle edge cases with a single extra tap, such as logging additional boundary runs on a No-Ball or recording a stumping/run-out on a Wide.

Robust Undo System: Features a prominent, full-width "Undo Last Action" button at the bottom of the scroll view, backed by a comprehensive event history stack to quickly and safely roll back misclicks.

## Architecture & Tech Stack

Framework: Built entirely from scratch with SwiftUI, utilizing scalable Grid layouts designed specifically for watchOS glanceability (41mm, 45mm, 49mm faces).

Data Flow (Modern MVVM): Uses Swift's modern Observation framework (@Observable) as the single source of truth (MatchManager). This fully decouples the complex cricket scoring logic from the view layer for highly efficient redrawing.

Type-Safe Logic: Employs strict enums (LegalDelivery, ExtraType, MatchEvent) to cleanly map button taps to specific run values and rules, keeping the UI layer completely free of scoring math.

Single Sheet Manager: Replaces standard native menus with custom, tap-friendly SwiftUI .sheet layers (WicketOptionsView, ExtraOptionsView, UndoConfirmationView). It uses a centralized ActiveSheet enum-driven .sheet(item:) modifier to completely prevent known SwiftUI multi-sheet conflicts on watchOS.

## Performance Optimizations

OLED Optimized: Designed heavily around pure black backgrounds and native tinting, which turns off individual pixels on the Apple Watch display to preserve battery life.

GPU Friendly: Explicitly avoids expensive .shadow() modifiers on UI components, preventing CoreAnimation from continuously calculating dynamic pixel paths and ensuring a buttery-smooth 60fps interaction rate on the wrist.
