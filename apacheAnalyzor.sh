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



