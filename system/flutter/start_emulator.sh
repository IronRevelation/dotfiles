#!/usr/bin/env bash

  # Define the emulator name and properties
      EMULATOR_NAME="sdk_gphone64_x86_64"
      API_LEVEL="35"

      # Function to check if emulator exists
      check_emulator_exists() {
          echo "Checking if emulator '$EMULATOR_NAME' exists..."
          if avdmanager list avd | grep -q "Name: $EMULATOR_NAME"; then
              echo "Emulator '$EMULATOR_NAME' already exists."
              return 0
          else
              echo "Emulator '$EMULATOR_NAME' does not exist."
              return 1
          fi
      }

      # Function to create the emulator
      create_emulator() {
          echo "Creating emulator '$EMULATOR_NAME'..."
          echo "no" | avdmanager create avd \
              --name "$EMULATOR_NAME" \
              --package "system-images;android-$API_LEVEL;google_apis_playstore_ps16k;x86_64" \

          if [ $? -eq 0 ]; then
              echo "Emulator '$EMULATOR_NAME' created successfully."
          else
              echo "Failed to create emulator. Please check if the system image is installed."
              echo "You may need to run: sdkmanager \"system-images;android-$API_LEVEL;google_apis_playstore_ps16k;x86_64\""
              exit 1
          fi
      }

      # Function to check if emulator is running
      check_emulator_running() {
          echo "Checking if emulator '$EMULATOR_NAME' is running..."
          if adb devices | grep -q "emulator"; then
              echo "An emulator is already running."
              return 0
          else
              echo "No emulator is currently running."
              return 1
          fi
      }

      # Function to start the emulator
      start_emulator() {
          echo "Starting emulator '$EMULATOR_NAME'..."
          emulator -avd "$EMULATOR_NAME" > /dev/null 2>&1 &

          # Wait for the emulator to boot completely
          echo "Waiting for emulator to boot completely..."
          adb wait-for-device

          # Additional boot completion check
          until adb shell getprop sys.boot_completed 2>/dev/null | grep -q "1"; do
            echo "Waiting for boot completion..."
            sleep 2
          done

          echo "Emulator '$EMULATOR_NAME' is now running and ready to use."
      }

      # Main script execution
      echo "Android Emulator Management Script"
      echo "=================================="

      # Check if Android SDK tools are available
      if ! command -v avdmanager &>/dev/null || ! command -v emulator &>/dev/null || ! command -v adb &>/dev/null; then
          echo "Error: Android SDK tools (avdmanager, emulator, adb) are not in your PATH."
          echo "Please ensure the Android SDK is installed and properly configured."
          exit 1
      fi

      # Check and create emulator if needed
      if ! check_emulator_exists; then
          create_emulator
      fi

      # Check and start emulator if needed
      if ! check_emulator_running; then
          start_emulator
      fi
