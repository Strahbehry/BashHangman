#!/usr/bin/hangman

#Config
words_file=/usr/share/dict/words

#Vars

attempts=
answer=
hangman_word=
guessed_letters=()

game_lose() {
	echo -e "You've failed too many times, you're hanged, unlucky"
	echo -e "Enter Y/N to play again"
}

game_win(){

}

generate_word(){

}

print_word(){

}

print_hangman(){

}

print_prompt(){

}

print_help(){

}

clear_console(){
	printf "\033c"
}