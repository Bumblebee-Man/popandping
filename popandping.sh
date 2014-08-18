#!/bin/bash

## What Image to use
IMAGE=9fd36b73-bf8a-440a-ad75-f93597924e50

## DEFINE NETWORKS
INSIDE=$(neutron net-list | grep INSIDE | awk '{ print $2 }')
PROD1=$(neutron net-list | grep PROD1 | awk '{ print $2 }')
PROD2=$(neutron net-list | grep PROD2 | awk '{ print $2 }')
PUBLIC=$(neutron net-list | grep PUBLIC | awk '{ print $2 }')
TEST=$(neutron net-list | grep TEST | awk '{ print $2 }')

## DEFINE NAMESPACES
INSIDE_NS=qdhcp-`echo $INSIDE`
PROD1_NS=qdhcp-`echo $PROD1`
PROD2_NS=qdhcp-`echo $PROD2`
PUBLIC_NS=qdhcp-`echo $PUBLIC`
TEST_NS=qdhcp-`echo $TEST`

# BOOT INSTANCES
nova boot --image $IMAGE --flavor 1 --security-groups default \
 --nic net-id=$INSIDE test-INSIDE

nova boot --image $IMAGE --flavor 1 --security-groups default \
 --nic net-id=$PROD1 test-PROD1

nova boot --image $IMAGE --flavor 1 --security-groups default \
 --nic net-id=$PROD2 test-PROD2

nova boot --image $IMAGE --flavor 1 --security-groups default \
 --nic net-id=$PUBLIC test-PUBLIC

nova boot --image $IMAGE --flavor 1 --security-groups default \
 --nic net-id=$TEST test-TEST


## GRAB IPs



## VERIFY PING
ip netns exec $INSIDE_NS ssh -oStrictHostKeyChecking=no
