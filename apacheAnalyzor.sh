#!/bin/bash

#Author: SeyedFoadAtaei, SSN: 9821833, Start: 1/17/2022, Finish:
#Project is a bash script that analyzes an Apache log file.
#Various queries are defined so that the user can retrieve information from the relevant file.

clear
#The definition of functions and how they work are stated in order.

#Function 1: Show the number of hits of a particular url.
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

#Function 3: Show which browsers are the most visited.
#To store information, the list of these Browsers will be saved in the topBrowsers.txt file.
function showTopBrowsers {
    echo Top 10 Browsers:
    cat $log | awk '{count[$(NF)]++} END {for (browser in count) print browser, count[browser]}' | sort -k 2nr | head -n 10
    cat $log | awk '{count[$(NF)]++} END {for (browser in count) print browser, count[browser]}' | sort -k 2nr | head -n 10 > topBrowsers.txt
}

#Function 4: Show which addresses are the most referenced in order.
#For convenience, we use the awk to separate all the references and then display a list of the top 10 for instance.
#To store information, the list of these Refrences will be saved in the topRefrences.txt file.
function showTopRefrences {
    cat $log | awk -F\" '{ print $4 }'| grep -v '-'| wc | awk '{print "All of Refrences : " $1}'
    echo Top 10 Refrences:
    cat $log | awk -F\" '{ print  $4 }'| grep -v '-'| sort | uniq -c | sort -nr | head -n 10
    cat $log | awk -F\" '{ print  $4 }'| grep -v '-'| sort | uniq -c | sort -nr | head -n 10 > topRefrences.txt
}

#Function 5: Show which operating system has been visited the most.
#To store information, the list of these OS will be saved in the topOS.txt file.
function showTopOS {
    echo Top 10 Opeation System:
    awk '{count[$13]++} END {for (os in count) print os, count[os]}' $log | sort -k 2nr | head -n 10
    awk '{count[$13]++} END {for (os in count) print os, count[os]}' $log | sort -k 2nr | head -n 10 > topOS.txt
}

#Function 6: Show which URLs are the most visited.
#Show the top 10 items and To store information, the list of these URLs will be saved in the mostURLs.txt file.
function showTenTopURLs {
    echo Top 10 URLs:
    awk '{count[$7]++} END {for (url in count) print url, count[url]}' $log | sort -k 2nr | head -n 10
    awk '{count[$7]++} END {for (url in count) print url, count[url]}' $log | sort -k 2nr | head -n 10 > mostURLs.txt
}



