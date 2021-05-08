#!/bin/bash

# General variables
FILE=quiz.txt
SCORE=0

# Verifies if the quiz file exists, returns an error if false.
if [ ! -f $FILE ]
then
    echo "This quiz file doesn't exist, maybe try to change the path in the script file."
    exit 1
fi

# Loop over quiz file/line, to prompt for each questions, so you won't have to add a new line in the code for each question
while read -u9 line
do
# Parses the quiz file for the questions
    question=`echo -e $line | cut -f1 -d' '`
    choice1=`echo -e $line | cut -f2 -d' '`
    choice2=`echo -e $line | cut -f3 -d' '`
    choice3=`echo -e $line | cut -f4 -d' '`
    solution=`echo -e $line | cut -f5 -d' '`

    # Print the questions and the choices to the player
    echo -e "$question?"
    echo -e "1) $choice1"
    echo -e "2) $choice2"
    echo -e "3) $choice3"

    # Reads the player answer choice
    read -p "- Give your answer: " player_choice

    # Compares player score with solution and increment score if necessary
    if [ "$player_choice" == "$solution" ]
    then
        SCORE=$(( ++SCORE ))
        echo -e "Correct answer! Great job."
    else
        echo -e "You gave the wrong answer. The solution is $solution"
    fi

    echo
done 9< $FILE

# Print the score of the player
echo "Your score is $SCORE/`wc -l $FILE`"

# The quiz.txt file form:

# question1 rep1 rep2 rep3 rep2
    ## The way the correct answer is set is by pasting rep'x' to the end of the current $line
