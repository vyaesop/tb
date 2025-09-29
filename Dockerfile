# Stage 1: Set up the build environment
FROM cirrusci/flutter:stable AS build

# Set the working directory
WORKDIR /app

# Copy dependency files and get packages
COPY pubspec.* ./
RUN flutter pub get

# Copy the rest of the application code
COPY . .

# Build the Android APK
RUN flutter build apk --debug

# Stage 2: Create a minimal image with the APK
FROM scratch

# Copy the built APK from the build stage
COPY --from=build /app/build/app/outputs/flutter-apk/app-debug.apk /app/app-debug.apk
