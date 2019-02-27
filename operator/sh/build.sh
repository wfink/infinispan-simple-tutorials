#!/usr/bin/env bash


set -e -x


# Login as admin to default project
login() {
  which oc
  oc login -u system:admin
  oc project default
}


# Delete any leftovers
clean() {
  oc delete all --selector=run=tutorial || true
  oc delete imagestream tutorial || true
  oc delete buildconfig tutorial || true
}


# Build the tutorial code
build() {
  oc new-build \
      --binary \
      --strategy=source \
      --name=tutorial \
      -l app=tutorial \
      fabric8/s2i-java:3.0-java8

  mvn clean package compile -DincludeScope=runtime

  oc start-build tutorial --from-dir=target/ --follow --loglevel=8
}


main() {
  login
  clean
  build
}


main
