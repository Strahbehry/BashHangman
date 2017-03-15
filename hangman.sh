#!/usr/bin/hangman

#Config
words_file=/usr/share/dict/words

#Vars

attempts=
answer=
hangman_word=
guessed_letters=()

#Called when game is lost
game_lose() {
	echo -e "You've failed too many times, you're hanged, unlucky"
	echo -e "Enter Y/N to play again"
}

#Called when game is won
game_win(){

}

#Generates the word
generate_word(){

}

#Prints the word
print_word(){

}

#Prints guessed chars
print_chars(){

}

#Prints our poor guy
print_hangman(){

}

#Prints a prompt for input
print_prompt(){

}

#Prints help
print_help(){

}

#Prints the welcome message
print_welcome(){
	clear_console

	echo -e "Welcome to the Bash Hangman by Mitch Terpak (2059275) and Pim Merks (2084481)"
}

#Check if the input was valid
validate_user_input(){

}

#Processes the user input
process_input(){

}

#Clears the console
clear_console(){
	printf "\033c"
}

#The main program
main(){
	

	print_welcome

}