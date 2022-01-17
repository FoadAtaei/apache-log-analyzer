#!/bin/bash

#Author: SeyedFoadAtaei, SSN: 9821833, Date: 1/17/2022
#Project is a bash script that analyzes an Apache log file.
#Various queries are defined so that the user can retrieve information from the relevant file.

clear
#The definition of functions and how they work are stated in order.

#Function 1: Show the number of hits of a particular url
function countOfParticularURL {
    echo Count of Particular URL:
	cat $log | awk '{ print $1 }'  |  sort | uniq | wc -l
}

#Function 2: Show the 10 most visited IPs in order.
#First we count the non-duplicate IPs and then we display the top ten IPs in order.
#To store information, the list of these IPs will be saved in the mostIPs.txt file.
function showTenTopIPs {
    cat $log | awk '{ print $1}' | sort | uniq | wc | awk '{print $1 " Finding non-duplicate IPs is over" }'
    cat $log | awk -F\" '{ print $1 }'| wc | awk '{print "All of IPs : " $1}'
    echo Top 10 IPs:
    awk '{print count "times {" $1 "} IP is repeated."}' $log | sort | uniq -c  | sort -nr | head -n 10
    awk '{print count "times {" $1 "} IP is repeated."}' $log | sort | uniq -c  | sort -nr | head -n 10 > mostIPs.txt
}

