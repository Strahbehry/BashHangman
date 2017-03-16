#!/usr/bin/bash

#Config
words_file=/usr/share/dict/words

#Vars

attempts=
answer=
hangman_word=
masked_word=""
guessed_letters=""

#Called when game is lost
game_lose() {
	echo "You've failed too many times, you're hanged, unlucky"
}

#Called when game is won
game_win(){
	echo "You've won!"
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
check_word(){
	if [[ ! "$masked_word" =~ _ ]]; then
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
	:
}

#Prints a prompt for input
print_prompt(){
	echo ""
	echo "You've $((10 - attempts)) attempts left"
	echo "The letters you've guessed already are ' $guessed_letters '"
	echo "Give the letter you would like to guess"
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

	return 0
}

#Processes the user input
process_input(){
	read input
	
	validate_user_input && echo "valid" || process_input
}

play_game(){
	print_prompt
	process_input

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