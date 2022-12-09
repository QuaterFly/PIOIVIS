#!/bin/bash

#Print help
Help() {
  # Display Help
  echo "The program to generate files."
  echo
  echo "syntax: sh gfiles [-h|n]"
  echo "options:"
  echo "\th Print this Help."
  echo "\tn Set the number for process"
  echo
}

# Generate files
Generate() {
  echo "\e[31mYou can't generate files with zero amount.\e[39m"
  #Clear the number from not-digital
  amount=$(echo ${OPTARG} | sed 's/[^1-9]*//g')

  #If the amount is 0
  if [ -z $amount ]; then
    echo "\e[31mYou can't generate files with zero amount.\e[39m"
    exit
  fi

  #Take the number digit
  i=$(expr length $amount)

  #The amount is 1 and you can run the generation functionality
  if [ $i -le 1 ]; then
    echo "\e[92mRunning of the generation of files.\e[39m"
    exit
  else
    #Find the largest number
    amount=$(echo $amount | sed 's/1//g')

    #Set a temporal amount
    tAmount=0
    counter=2
    while [ $counter -le $i ]; do
      tAmount=$amount
      amount=$(echo $amount | sed "s/$counter//g")
      if [ -z $amount ]; then
        break
      fi
      counter=$(expr $counter + 1)
    done

    #Take the number digit
    i=$(expr length $tAmount)

    if [ $i -le 1 ]; then
      echo "The lagest number is $tAmount"
      echo "\e[92mRunning of the generation of files.\e[39m"
	  CreateFiles
      exit
    else
      echo 'else'
      echo "The tAmount is $tAmount"
      echo "The lagest number is $counter"
      echo "Needs to process the parameters"
	  CreateFiles
      exit
    fi
  fi
}

CreateFiles() {
    k=0
	for i in `seq 1 $counter`
	do
	 	if [ $k -le 0 ]; then 
         cd Result
		echo>$i.txt
		k=1
        cd ..
	 else 
        cd Result
		date >$i.doc
		k=0
        cd ..
	fi
	done
}

#Validate the passed options
while getopts 'hn:v' flag; do
  case "${flag}" in
  n)
    Generate
    exit
    ;;
  h)
    Help
    exit
    ;;
  \D)
    Help
    exit
    ;;
  esac
done
#Needs to process the case when the user has not passed any options
#echo "\e[31mYou can't run the program without options.\e[39m \e[92mPlease run the script with the oprtion -h.\e[39m"
