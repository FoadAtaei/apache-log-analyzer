#!/bin/bash

#Author: SeyedFoadAtaei, SSN: 9821833, Start: 1/17/2022, Finish: 1/18/2022
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
function showTopTenIPs {
    cat $log | awk '{ print $1}' | sort | uniq | wc | awk '{print $1 " Finding non-duplicate IPs is done" }'
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
function showTopTenURLs {
    echo Top 10 URLs:
    awk '{count[$7]++} END {for (url in count) print url, count[url]}' $log | sort -k 2nr | head -n 10
    awk '{count[$7]++} END {for (url in count) print url, count[url]}' $log | sort -k 2nr | head -n 10 > mostURLs.txt
}

#Function 7: Show all IPs and count them.
#Using awk, we take the first data of each row, which is the same as the IPs, and display it with the number of non-duplicate IPs.
#To store information, the list of these IPs will be saved in the IPs.txt file.
function showAllIPs {
    cat $log | awk '{ print $1}' | sort | uniq | wc | awk '{print $1 " Finding non-duplicate IPs is done" }'
    cat $log | awk -F\" '{ print $1 }'| wc | awk '{print "All of IPs : " $1}'
    cat $log | awk '{ print count "times {" $1 "} IP is repeated."}' | sort -r | uniq -c | sort -r
    cat $log | awk '{ print $1}' | uniq > IPs.txt
}

#Function 8: Show top 10 users with most visit.
#The sixth variable in each row contains the names of the users who visited. As a result, the top 10 can be found with a few simple commands.
#To store information, the list of these users will be saved in the topUsers.txt file.
function showTopTenUsers {
    echo Top 10 Users:
	  cat $log | awk -F\" '{ print count $6 }' | sort | uniq -c | sort -nr | head -n 10
	  cat $log | awk -F\" '{ print count $6 }' | sort | uniq -c | sort -nr | head -n 10 > TopUsers.txt
}

#Function 9: Show requests type.
#Determining the type of each request is very important because it provides us with good information, awk easily sorts and returns these requests.
#To store information, the list of these types will be saved in the requestsType.txt file.
function showRequestsType {
    cat $log | awk '{ print $6}'  | wc | awk '{print $1 " Requests :" }'
    cat $log | awk '{ print count "times {" $6 "} Request is repeated."}' | sort -r | uniq -c | sort -r
    cat $log | awk '{ print count "times {" $6 "} Request is repeated."}' | sort -r | uniq -c | sort -r > requestsType.txt
}

#Function 10: Show the day of each request.
#The important point in defining this function is that in displaying the specifications, the date and time are shown together, So we have to separate them first with the help of awk.
#To store information, the list of these days will be saved in the days.txt file.
function showDays {
    awk '{print count "times {" $4 "} Day is repeated."}' $log | cut -d: -f1 | uniq -c  | wc | awk '{print $1 " Days :" }'
    awk '{print count "times {" $4 "} Day is repeated."}' $log | cut -b 1-6,9-19 | sort | uniq -c  | sort -nr
    awk '{print count "times {" $4 "} Day is repeated."}' $log | cut -b 1-6,9-19 | sort | uniq -c  | sort -nr > days.txt
}

#Main function
function main {
  echo Welcome to the "$log" file analyzer
  while true
  do
    echo    "Apache Log File Analyzer           "             #Definition of functions for users
    echo
    echo -e "       Please select a query       "
    echo
    echo    "1: Show count of particular URL    "
    echo
    echo    "2: Show top 10 IPs                 "
    echo
    echo    "3: Show top Browsers               "
    echo
    echo    "4: Show top Refrences              "
    echo
    echo    "5: Show top Operating System       "
    echo
    echo    "6: Show top 10 URLs                "
    echo
    echo    "7: Show all IPs                    "
    echo
    echo    "8: Show top 10 Users               "
    echo
    echo    "9: Show Type of Request            "
    echo
    echo    "10: Show Days of Request           "
    read -p "Your selection: " query
    case $query in
    1) countOfParticularURL;;
    2) showTopTenIPs;;
    3) showTopBrowsers;;
    4) showTopRefrences;;
    5) showTopOS;;
    6) showTopTenURLs;;
    7) showAllIPs;;
    8) showTopTenUsers;;
    9) showRequestsType;;
    10) showDays;;
    *) echo Sorry, The request of your choice is not available.;;
    esac
  done
}

#Take the file and then perform the necessary operations in order.
function readFile {
  echo -e "Please Enter the input file:\n"
  ls -p | grep -w log
  echo
  log="apacheLog.log"
  if [ ! -f $log ]; then                                          #Send a message when file is not found
    echo -e "\nSorry, File not found!\n"
    readFile
  else
    main
  fi
  }
  echo -e "\nApache log file analyzer\n"
  readFile