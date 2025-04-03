#!/bin/bash

# Directory where the project is located
PROJECT_DIR=~/keyhunt

# File to compile
SOURCE_FILE="secp256k1/Random.cpp"

# Check if sys/random.h exists
if ! [ -f /usr/include/sys/random.h ]; then
  echo "sys/random.h not found. Installing necessary dependencies..."

  # Install dependencies (example for a Debian-based system)
  sudo apt-get update
  sudo apt-get install -y libbsd-dev

  # Check again
  if [ -f /usr/include/sys/random.h ]; then
    echo "sys/random.h successfully installed."
  else
    echo "Failed to install sys/random.h. Please check your system for the correct library."
    exit 1
  fi
fi

# Remove unrecognized compiler flag -Wno-deprecated-copy
COMPILE_FLAGS="-m64 -march=native -mtune=native -mssse3 -Wall -Wextra -Ofast -ftree-vectorize -flto"
OUTPUT_FILE="Random.o"

# Navigate to the project directory
cd $PROJECT_DIR

# Compile the source file
g++ $COMPILE_FLAGS -c $SOURCE_FILE -o $OUTPUT_FILE

# Check if the compilation was successful
if [ $? -eq 0 ]; then
  echo "Compilation successful."
else
  echo "Compilation failed."
  exit 1
fi
