#!/usr/bin/env bash


set -e


# Login as admin to default project
login() {
  which oc
  oc login -u system:admin
  oc project default
}


run() {
  oc run tutorial \
    --image="$(oc get is tutorial -o jsonpath="{.status.dockerImageRepository}")" \
    --replicas=1 \
    --restart=OnFailure \
    --env SVC_DNS_NAME=example-infinispan \
    --env JAVA_OPTIONS=-ea
}

wait() {
  local status=NA
  while [[ "$status" != "Running" && "$status" != "Succeeded" ]];
  do
    status=`oc get pod -l run=tutorial -o jsonpath="{.items[0].status.phase}"`
    echo "Status of tutorial pod: ${status}"
    sleep .5
  done
}

log() {
  local pod
  pod=$(oc get pod -l run=tutorial -o jsonpath="{.items[0].metadata.name}")
  oc logs ${pod} -f
}


test() {
  run
  wait
  log
}


main() {
  login
  test
}


main
