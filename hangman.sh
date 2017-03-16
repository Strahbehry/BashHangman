#!/usr/bin/bash

#Config
words_file=/usr/share/dict/words

#Vars

attempts=
answer=
hangman_word=
guessed_letters=

#Called when game is lost
game_lose() {
	echo "You've failed too many times, you're hanged, unlucky"
	echo "Enter Y/N to play again"
}

#Called when game is won
game_win(){
	:
}

#Generates the word
generate_word(){
	answer=$(shuf -n 1 $words_file)

	answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')

	echo $answer

	#If a word contains a apostrophe or a special character then generate a new word
	if [[ $answer =~ [^a-z] ]]
    then
        generate_word
    fi
}

#Prints the word
print_word(){
	:
}

#Prints guessed chars
print_chars(){
	:
}

#Prints our poor guy
print_hangman(){
	:
}

#Prints a prompt for input
print_prompt(){
	:
}

#Prints help
print_help(){
	:
}

#Prints the welcome message
print_welcome(){
	clear_console

	echo "Welcome to the Bash Hangman by Mitch Terpak (2059275) and Pim Merks (2084481)"
}

#Check if the input was valid
validate_user_input(){
	:
}

#Processes the user input
process_input(){
	:
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

	#while true; do
}

main