#!/usr/bin/bash

#Config
words_file=/usr/share/dict/words

#Vars
attempts=0
answer=
hangman_word=
masked_word=""
guessed_letters=""
alphabet="abcdefghijklmnopqrstuvwxyz"

#Called when game is lost
game_lose() {
	echo "You've failed too many times, you're hanged, unlucky"
	exit
}

#Called when game is won
game_win(){
	echo "You've won!"
	exit
}

#Generates the word
generate_word(){
	answer=$(shuf -n 1 $words_file)

	answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')

	#If a word contains a apostrophe or a special character then generate a new word
	if [[ $answer =~ [^a-z] ]]
    then
        generate_word
        return 0
    fi    
}

#Checks if you won or lost
check_win_lose(){
	if [[ ! "$masked_word" =~ - ]]; then
        game_win
    else
    	if (( attempts >= 10 ))
    		then
    		game_lose
    	else
    		return 0
    	fi
    fi
}

#Masks the word and reveals guessed letters
mask_word(){
	masked_word=$(tr -c "\n $guessed_letters" "-" <<< "$answer")
}


#Prints our poor guy
print_hangman(){

if [[ $attempts = 0 ]]
then
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""

elif [[ $attempts = 1 ]]
then
	echo "      "
	echo "               "
	echo "               "
	echo "               "
	echo "               "
	echo "               "
	echo "               "
	echo "               "
	echo "               "
	echo "               "
	echo "               "
	echo "               "
	echo "_______________"

elif [[ $attempts = 2 ]]
then
	echo "      "
	echo "               "
	echo "               "
	echo "               "
	echo "               "
	echo "               "
	echo "               "
	echo "               |"
	echo "               |"
	echo "               |"
	echo "               |"
	echo "               |"
	echo "_______________|"

elif [[ $attempts = 3 ]]
then
	echo "         "
	echo "               |"
	echo "               |"
	echo "               |"
	echo "               |"
	echo "               |"
	echo "               |"
	echo "               |"
	echo "               |"
	echo "               |"
	echo "               |"
	echo "               |"
	echo "_______________|"

elif [[ $attempts = 4 ]]
then
	echo "      __________"
	echo "               |"
	echo "               |"
	echo "               |"
	echo "               |"
	echo "               |"
	echo "               |"
	echo "               |"
	echo "               |"
	echo "               |"
	echo "               |"
	echo "               |"
	echo "_______________|"

elif [[ $attempts = 5 ]]
then
	echo "      __________"
	echo "     |         |"
	echo "     |         |"
	echo "   _/_\_       |"
	echo "    |_|        |"
	echo "               |"
	echo "               |"
	echo "               |"
	echo "               |"
	echo "               |"
	echo "               |"
	echo "               |"
	echo "_______________|"

elif [[ $attempts = 6 ]]
then
	echo "      __________"
	echo "     |         |"
	echo "     |         |"
	echo "   _/_\_       |"
	echo "    |_|        |"
	echo "     |         |"
	echo "     |         |"
	echo "     |         |"
	echo "     |         |"
	echo "               |"
	echo "               |"
	echo "               |"
	echo "_______________|"

elif [[ $attempts = 7 ]]
then
	echo "      __________"
	echo "     |         |"
	echo "     |         |"
	echo "   _/_\_       |"
	echo "    |_|        |"
	echo "     |         |"
	echo "     |         |"
	echo "     |         |"
	echo "     |         |"
	echo "    /          |"
	echo "   /           |"
	echo "               |"
	echo "_______________|"

elif [[ $attempts = 8 ]]
then
	echo "      __________"
	echo "     |         |"
	echo "     |         |"
	echo "   _/_\_       |"
	echo "    |_|        |"
	echo "     |         |"
	echo "     |         |"
	echo "     |         |"
	echo "     |         |"
	echo "    / \        |"
	echo "   /   \       |"
	echo "               |"
	echo "_______________|"

elif [[ $attempts = 9 ]]
then
	echo "      __________"
	echo "     |         |"
	echo "     |         |"
	echo "   _/_\_       |"
	echo "    |_|        |"
	echo "     |         |"
	echo " ----|         |"
	echo "     |         |"
	echo "     |         |"
	echo "    / \        |"
	echo "   /   \       |"
	echo "               |"
	echo "_______________|"

elif [[ $attempts = 10 ]]
then
	echo "      __________"
	echo "     |         |"
	echo "     |         |"
	echo "   _/_\_       |"
	echo "    |_|        |"
	echo "     |         |"
	echo " ----|----     |"
	echo "     |         |"
	echo "     |         |"
	echo "    / \        |"
	echo "   /   \       |"
	echo "               |"
	echo "_______________|"
fi

}

#Prints a prompt for input
print_prompt(){
	echo ""
	echo "You've $((10 - attempts)) attempts left"
	echo "The letters you've guessed already are ' $guessed_letters '"
	echo "Give the letter you would like to guess"
	echo "$masked_word"
}

#Prints the welcome message
print_welcome(){
	clear_console

	echo "Welcome to the Bash Hangman by Mitch Terpak (2059275) and Pim Merks (2084481)"
}

#Check if the input was valid
validate_user_input(){
	echo ""

	if [[ $input =~ [^a-z] ]]
		then
			echo "$input is invalid"
			print_prompt
			return 1
		fi

	if [[ $guessed_letters = *"$input"* ]]
		then
			echo "You've already guessed ' $input ' before"
			print_prompt
			return 1
		fi

	((attempts++))
	guessed_letters=$guessed_letters$input
	mask_word

	return 0
}

#Processes the user input
process_input(){
	read input
	
	validate_user_input && : || process_input
}

play_game(){
	print_hangman
	print_prompt
	process_input

	check_win_lose
	play_game
}

#Check if the word file exists
validate_word_file(){
	if [ ! -f $words_file ]
	then
		echo "Word File at $words_file not found!"
		exit 1
	fi
}

#Clears the console
clear_console(){
	printf "\033c"
}

#The main program
main(){
	print_welcome
	validate_word_file
	generate_word
	mask_word

	play_game
}

main
