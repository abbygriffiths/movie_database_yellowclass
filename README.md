# Movie Database

Simple movie database application that lists out movies that a user has watched in an infinite scrolling view.
Uses Hive as the database to store the information.

## Prerequisites
1. Latest version of flutter installed
2. Android/iOS/Web device available to run the application

## Dependencies
1. OMDB API key
    - The built APK will work fine (using my API key)
    - However, to build the app from source, you'll need to obtain an API key from [OMDB](https://www.omdbapi.com/) and follow [Setting up API key](#setup-api-key)

## Getting Started

1. Clone this project using `git clone`
2. Navigate into the project root directory
3. Run `flutter pub get` to download required packages.
4. Launch the application using `flutter run`

### Setup API Key
1. Obtain API key from [OMDB](https://www.omdbapi.com/)
2. Create a `secrets.json` file in the root of the project directory
3. Inside `secrets.json` add a key `"OMDB_API_ENDPOINT"`
4. Copy and paste the OMDB URL you receive on your email as the value for the above key.

#### Attributions
This app uses illustrations from various sources with permission to use said illustrations with proper attribution.
<div>Icons made by <a href="https://www.freepik.com" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>