#!/bin/bash
data()
 {
     #the data generator function, that will create a random data to Data.pg
     touch Data.pg  
     chmod 755 Data.pg
     for x in {1..10}
     do  
     number=$((  ($RANDOM % 50)+1))
     echo $number >>Data.pg
     done 
 }
encrypt()
 {
    read -a numbers <<<$(<Data.pg)
    for x in {0..9}
    do 
        `printf "%c" ${numbers[$x]}` >>Data.pg 
         sed -i '1d' Data.pg 
    done 



 }
decrypt()
 { 
   read -a numbers <<<$(<Data.pg)
    for x in numbers
    do
        `printf "%d" ${numbers[$x]}` >>Data.pg
        sed -i '1d' Data.pg 
    done




 } 
#if Data.pg exists(so it is not a first time
if [ -a Data.pg ]; then
#decrypt(I had no time to modify the functions sorry)  
     tries=0
#for loop for each try starts here     
     for z in {0..2}
     do 
        
        
        printf "Guess Number?\n"
        read guess  
#storing the values in Data.pg         
        read -a numbers <<<$(<Data.pg)
#adding array elements to find the sum         
        sum=0 
        for i in {0..9}
        do 
           sum=$(($sum+${numbers[$i]}))
        done 
#calculations        
        avg=$(($sum/10))
        twoThirds=$(($avg/3)); twoThirds=$(($twoThirds*2))
        lower=$(($twoThirds - $(($twoThirds/10))))
        upper=$(($twoThirds + $(($twoThirds/10))))
        if [[ $guess -ge $lower && $guess -le $upper ]]; then 
                echo "You won"
#deleting the first and adding to the last                
                sed -i '1d' Data.pg ; echo $guess >>Data.pg
                tries=$(($tries+1))
                break
                 
        else 
                echo "Incorrect guess. Try again"
                tries=$(($tries+1))       
                sed -i '1d' Data.pg ; echo $guess >>Data.pg
               
        fi
                         
        done
        
#creating a new file to store the tries   
        touch numberofTries 
        chmod 755 numberofTries
        
        read -a numofTries <<<$(<numberofTries)
        echo "Number of tries you did: $tries"
#if there are 5 tries stored then delete and add, if not(less than 5) just add
        if [ ${#numofTries[@]} -eq 5 ]; then
        sed -i '1d' numberofTries ; echo $tries >>numberofTries
        else
        echo $tries >>numberofTries
        fi 
#average tries         
        sum1=0
        for l in "${numofTries[@]}"
        do
              
              sum1=$(($sum1 + $l))
              avTry=$(($sum1 / ${#numofTries[@]}))
        done

        printf "5 players took tries : "
        for i in {0..4}
        do
              printf "${numofTries[$i]} "
        done
        printf "\n"
        printf "So averge is $avTry \n" 
#encrypt
        
else     
    data
    tries=0
     for z in {0..2}
     do

        
        printf "Guess Number?\n"
        read guess

        read -a numbers <<<$(<Data.pg)
        
        
        sum=0
        for i in {0..9}
        do
           sum=$(($sum+${numbers[$i]}))
        done
        avg=$(($sum/10))
        twoThirds=$(($avg/3)); twoThirds=$(($twoThirds*2))
        lower=$(($twoThirds - $(($twoThirds/10))))
        upper=$(($twoThirds + $(($twoThirds/10))))
        if [[ $guess -ge $lower && $guess -le $upper ]]; then
                echo "You won"
                sed -i '1d' Data.pg ; echo $guess >>Data.pg
                tries=$(($tries+1))
                break

        else
                echo "Incorrect guess. Try again"
                tries=$(($tries+1))
                sed -i '1d' Data.pg ; echo $guess >>Data.pg
               
        fi
                         
        done
        
  
        touch numberofTries 
        chmod 755 numberofTries
        read -a numofTries <<<$(<numberofTries) 
        echo "Number of tries you did: $tries"
        
        if [ ${#numofTries[@]} -eq 5 ]; then 
        sed -i '1d' numberofTries ; echo $tries >>numberofTries
        else 
        echo $tries >>numberofTries
        fi 
        
        sum1=0
        for l in "${numofTries[@]}"
        do 
              
              sum1=$(($sum1 + $l))
              avTry=$(($sum1 / ${#numofTries[@]}))  
        done 
        
        printf "5 players took tries : "
        for i in {0..4}
        do  
              printf "${numofTries[$i]} "   
        done
        printf "\n"
        printf "So averge is $avTry \n"

#encrypt






fi  
