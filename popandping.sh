#!/bin/bash

## What Image to use
IMAGE=<DEFINE_IMAGE>

## DEFINE NETWORKS
INSIDE=$(neutron net-list | grep INSIDE | awk '{ print $2 }')
PROD=$(neutron net-list | grep PROD | awk '{ print $2 }')
PUBLIC=$(neutron net-list | grep PUBLIC | awk '{ print $2 }')
TEST=$(neutron net-list | grep TEST | awk '{ print $2 }')

## DEFINE NAMESPACES
INSIDE_NS=qdhcp-`echo $INSIDE`
PROD_NS=qdhcp-`echo $PROD1`
PUBLIC_NS=qdhcp-`echo $PUBLIC`
TEST_NS=qdhcp-`echo $TEST`

# BOOT INSTANCES
nova boot --image $IMAGE --flavor 2 --security-groups default \
 --nic net-id=$INSIDE test-INSIDE

nova boot --image $IMAGE --flavor 2 --security-groups default \
 --nic net-id=$PROD test-PROD

nova boot --image $IMAGE --flavor 2 --security-groups default \
 --nic net-id=$PUBLIC test-PUBLIC

nova boot --image $IMAGE --flavor 2 --security-groups default \
 --nic net-id=$TEST test-TEST


## GRAB IPs
INSIDE_IP=$(nova list | grep INSIDE | awk '{ print $12 }' | sed 's/^.*=//')
PROD_IP=$(nova list | grep PROD1 | awk '{ print $12 }' | sed 's/^.*=//')
PUBLIC_IP=$(nova list | grep PUBLIC | awk '{ print $12 }' | sed 's/^.*=//')
TEST_IP=$(nova list | grep TEST | awk '{ print $12 }' | sed 's/^.*=//')


## VERIFY PING
ip netns exec $INSIDE_NS ssh \
-oStrictHostKeyChecking=no cirros@INSIDE_IP 'ping -q -c 3 google.com'

ip netns exec $PROD_NS ssh \
-oStrictHostKeyChecking=no cirros@PROD_IP 'ping -q -c 3 google.com'

ip netns exec $PUBLIC_NS ssh \
-oStrictHostKeyChecking=no cirros@PUBLIC_IP 'ping -q -c 3 google.com'

ip netns exec $TEST_NS ssh \
-oStrictHostKeyChecking=no cirros@TEST_IP 'ping -q -c 3 google.com'
