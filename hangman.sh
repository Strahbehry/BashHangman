#!/usr/bin/bash

#Config
words_file=/usr/share/dict/words

#Vars
attempts=0
answer=
masked_word=""
guessed_letters=""
alphabet="abcdefghijklmnopqrstuvwxyz"

#Called when game is lost
game_lose() {
	echo "You've failed too many times, you're hanged, unlucky"
	echo "The word was $answer !"
	write_stats
	echo "Press any key to exit"
	read -n 1
	exit
}

#Called when game is won
game_win(){
	echo "You've won!"
	write_stats
	echo "Press any key to exit"
	read -n 1
	exit
}

#Echo win/lose statistics
write_stats(){
	:
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
read -r -d '' hex <<'EOF'
1f8b080025bbce580003535040055c0ac3488067b038841a02f16860b0f8
ae862a02689eab21ec3bead84b1f015cbe438acdc1e254320488f55d0dba
216802f1faf131f1282a6ae26bd0b4d0dc331802f4f41d2133881118d6be
d347f30c127f58f82e06c37731a85a0685ef74816098fb0e44d0d777004c
bdfc0d8a090000
EOF
mapfile -d$'\014' frames < <(printf "%b" $(sed 's/../\\x& /g' <<<"$hex") |gzip -d)
#here you have the array "frames[@]" - with the pictures

clear
printf "%s\n" "${frames[$attempts]}"
}

#Prints a prompt for input
print_prompt(){
	echo ""
	echo "You've $((10 - attempts)) attempts left"
	echo "The letters you've guessed already are ' $guessed_letters '"
	echo "Give the letter you would like to guess"
	echo "$masked_word"
}

#Check if the input was valid
validate_user_input(){
	clear
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

	if [[ $answer != *"$input"* ]]
		then
		((attempts++))
	fi
	guessed_letters=$guessed_letters$input
	mask_word

	return 0
}

#Processes the user input
process_input(){
	read -n 1 input
	
	validate_user_input && : || process_input
}

play_game(){
	print_hangman
	print_prompt
	check_win_lose
	process_input
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

#traps ctrl-c
ctrl_c() {
	echo ""
    echo "The word was $answer"
    exit
}

#The main program
main(){
	clear
	echo "Welcome to the Bash Hangman by Mitch Terpak (2059275) and Pim Merks (2084481)"

	validate_word_file
	generate_word
	mask_word
	play_game
}

trap ctrl_c INT
main