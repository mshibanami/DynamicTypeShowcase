#!/usr/bin/env bash
set -ex

bundle install
bundle exec fastlane gym
bundle exec fastlane deliver
