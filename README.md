# Geo-Fenced Attendance System

A high-precision, location-aware Flutter application designed to automate attendance marking. The
system designation of an "Office Location" and strictly validates user proximity within a 50-meter
radius before allowing a check-in.

## Project Structure & Technical Decisions

The application is built using a **Layered Architecture** to ensure the code is modular, scalable,
and easy to maintain.

### 1. Data Layer

- **LocationRepository**: Acts as the single source of truth for location data. It interacts with
  the `geolocator` package to fetch current GPS coordinates and handles local persistence using
  `shared_preferences` to store office coordinates.

### 2. Logic Layer (BLoC Pattern)

- **AttendanceBloc**: Orchestrates the app state by responding to events like setting office
  coordinates or tracking movement.
- **Real-time Tracking**: Utilizes a `StreamSubscription` to listen for continuous GPS updates,
  providing a live distance indicator to the user.
- **Geofencing Logic**: Proximity validation is strictly enforced at the logic level, ensuring the "
  Mark Attendance" action only unlocks when within the 50m threshold.

### 3. Presentation Layer

- **AttendanceScreen**: A reactive UI built with **Material 3**. It observes the `AttendanceState`
  to provide instant visual feedback through a circular distance gauge and range status badges (
  e.g., "IN RANGE" vs "OUT OF RANGE").

## Key Features

- **Real-time Geofencing**: Precision distance calculation between user and office.
- **Hardware Integration**: High-accuracy GPS tracking with permission handling.
- **Persistent Storage**: Saved locations persist across application restarts.
- **Adaptive UI**: Responsive design with `SafeArea` integration for all device types.
- **Robust Error Handling**: Graceful recovery for disabled location services or denied permissions.

## Tech Stack

- **Framework**: Flutter (Dart)
- **State Management**: BLoC (flutter_bloc)
- **Persistence**: SharedPreferences
- **Location Services**: Geolocator
- **Comparison**: Equatable

## How to Run

Follow these steps to run the application locally:

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/rezaulkhan111/flutter_geo_fenced_attendance.git
   ```

2. **Install Dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the App:**
   ```bash
   flutter run
   ```
   *Note: A physical device is recommended for testing GPS features. Ensure Location Services are
   enabled.*

## Screenshots

<html>
<table border="0">
  <tr>
    <td align="center">Out Of Range<br/><img src="https://raw.githubusercontent.com/rezaulkhan111/flutter_geo_fenced_attendance/refs/heads/master/photo/1.jpeg" width="200" /></td>
    <td align="center">Out Of Range 2<br/><img src="https://raw.githubusercontent.com/rezaulkhan111/flutter_geo_fenced_attendance/refs/heads/master/photo/2.jpeg" width="200" /></td>
    <td align="center">In Range<br/><img src="https://raw.githubusercontent.com/rezaulkhan111/flutter_geo_fenced_attendance/refs/heads/master/photo/3.jpeg" width="200" /></td>
    <td align="center">In Range 2<br/><img src="https://raw.githubusercontent.com/rezaulkhan111/flutter_geo_fenced_attendance/refs/heads/master/photo/4.jpeg" width="200" /></td>
  </tr>
<tr>
<td align="center">Live App Demo<br/><img src="https://raw.githubusercontent.com/rezaulkhan111/flutter_geo_fenced_attendance/refs/heads/master/photo/attendance.gif" width="200" /></td>
</tr>
</table>
</html>
---

## APK Submission

The release APK can be downloaded from the following link:
[Link to Release APK](https://github.com/rezaulkhan111/flutter_geo_fenced_attendance/refs/heads/master/photo/app-release.apk)
