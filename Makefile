#!/bin/bash

sort: sort-src sort-example

sort-src:
	- ./scripts/sort-Xcode-project-file "./AlertBar.xcodeproj"

sort-example:
	- ./scripts/sort-Xcode-project-file "./Example/AlertBarExample.xcodeproj"
