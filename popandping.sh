#!/bin/bash

## What Image to use
IMAGE=<DEFINE_IMAGE>

## DEFINE NETWORKS
INSIDE=$(neutron net-list | grep INSIDE | awk '{ print $2 }')
PROD=$(neutron net-list | grep PROD1 | awk '{ print $2 }')
PUBLIC=$(neutron net-list | grep PUBLIC | awk '{ print $2 }')
TEST=$(neutron net-list | grep TEST | awk '{ print $2 }')

## DEFINE NAMESPACES
INSIDE_NS=qdhcp-`echo $INSIDE`
PROD_NS=qdhcp-`echo $PROD1`
PUBLIC_NS=qdhcp-`echo $PUBLIC`
TEST_NS=qdhcp-`echo $TEST`

# BOOT INSTANCES
nova boot --image $IMAGE --flavor 1 --security-groups default \
 --nic net-id=$INSIDE test-INSIDE

nova boot --image $IMAGE --flavor 1 --security-groups default \
 --nic net-id=$PROD test-PROD1

nova boot --image $IMAGE --flavor 1 --security-groups default \
 --nic net-id=$PUBLIC test-PUBLIC

nova boot --image $IMAGE --flavor 1 --security-groups default \
 --nic net-id=$TEST test-TEST


## GRAB IPs



## VERIFY PING
ip netns exec $INSIDE_NS ssh -oStrictHostKeyChecking=no
