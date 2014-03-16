#  Play BlackJack 1 0n 1 vs the dealer
#
#
#

# ====================================================================
# ============= Methods are all defined here =========================
# ====================================================================

#  Query handles all querying for the game.
#  It asks for user input, then it checks if the user has requested
#  to perform a valid move. Ex: if the user has asked to hit before
#  the deck has been dealt then the user is prompted for a new response.
#  If a valid response is given, this response is returned.
def query(game_state)
	while true 
		print "What would you like to do? "								# Standard query
		action = gets.chomp.upcase												# Store the users request
		#puts "over here"

		if action == "M" 
			puts "You have $#{$bank_roll}.\n\n" 
		elsif action == "Q" 
			abort("Goodbye") 
		elsif
			((action != "H") & (action != "S")) & ((action != "Q") & ((action != "M") & (action != "D")))	
			puts "(D)eal, (H)it, (S)tand, display (M)oney, or (Q)uit."
			puts "There are no other options. Deal with it.\n\n"
		end

		# The validity of other inputs is determined by the state of the game
		if game_state == "cards_not_dealt"			
			if action == "D"
				return action
			elsif (action == "H") || (action == "S")
				puts "The cards haven't been dealt.\n\n"
			elsif action == "Q"
				puts "Goodbye"
				return action
			end
		else
			if action == "D"
				puts "The cards are already dealt.\n\n"
			elsif action == "H" || action == "S"
				puts "returning #{action}"
				return action
			end
		end
	end
end

#  Returns a new random card from the deck and updates the $deck_keys to reflect missing card
def dealNewCard
	new_card = $deck_keys[rand($deck_keys.length)]
	$deck_keys.delete(new_card)
	return new_card
end

#  Deals the starting hands. 
#  Operates by twice dealing to the player and then the dealer.
#  An array of player cards, and array of dealer cards are returned
def deal
	player_cards, dealer_cards = Array.new(2) { [] }

	2.times do 
		player_cards << dealNewCard
		dealer_cards << dealNewCard
	end

	return player_cards, dealer_cards
end 

#  Evaluates the hands and returns a new game state 
#  Ex: push, bust, win, lose
def evaluate(game_state, player_hand, player_total, dealers_hand, dealers_actual_total, player_turn)

	if (game_state == "cards_dealt") && (player_turn == true)
		if (player_total == 21) && (dealers_actual_total == 21)						# If dealer and player are both dealt Black Jack then push
			return "push"
		elsif (dealers_actual_total == 21) && (dealers_hand.length == 2) 	# If dealer is dealt Black Jack but player is not, then dealer wins
			return "dealer blackJack"
		elsif (player_total == 21) && (player_hand.length == 2)						# If player is dealt Black Jack but dealer is not, then player wins
			return "player blackJack"
		elsif (player_total > 21)
			return "bust"
		else 
			return "nothing"
		end
	elsif player_turn == false
		if dealers_actual_total > 21
			return "bust"
		elsif player_total > dealers_actual_total
			return "player win"
		elsif dealers_actual_total > player_total
			return "dealer win"
		else
			return "push"
		end
	end
end

# Displays the players cards and Dealers cards with their associated values
def display(player_turn, players_hand, dealers_hand, player_total, dealer_visible_total, dealers_actual_total)
	lineWidth = 25

	if players_hand.length > dealers_hand.length			# Take the hand that has more cards and store the number 
		largest_hand = players_hand.length - 1 					# of cards in that hand into a variable
	else
		largest_hand = dealers_hand.length - 1
	end


	# Table Headings
	print "Dealer".center(lineWidth)
	puts "Player".center(lineWidth)
	print "======".center(lineWidth)
	puts "======".center(lineWidth)

	if player_turn 
		for i in 0..largest_hand do
			if i == 0
				print "#{dealers_hand[i]}".center(lineWidth)
			elsif i == 1
				print " xx ".center(lineWidth)
			else 
				print "    ".center(lineWidth)
			end
			puts " #{players_hand[i]} ".center(lineWidth)
		end
	else
		for i in 0..largest_hand do
			if i <= (dealers_hand.length - 1)
				print "#{dealers_hand[i]}".center(lineWidth)
			else
				print "    ".center(lineWidth)
			end

			if i <= (players_hand.length - 1)
				puts " #{players_hand[i]} ".center(lineWidth)
			else
				puts "    ".center(lineWidth)
			end
		end 
	end

	# Divider
	print "======".center(lineWidth)
	puts "======".center(lineWidth)

	# Value of Players hand and visible dealer card
	print "Total:".ljust(10)
	if player_turn 
		print " #{dealer_visible_total}".ljust(lineWidth + 1)
		puts "#{player_total}\n\n".ljust(lineWidth + 1)
	else
		print " #{dealers_actual_total}".ljust(lineWidth + 1)
		puts "#{player_total}\n\n".ljust(lineWidth + 1)
	end
end

def bust
	puts "You busted."
	puts "You lose $10"
	$bank_roll -= 10
end

def push
	puts "Push"
end

def blackJack(who_won)
	if who_won == "dealer blackJack"
		#display cards?
		puts "Dealer has Black Jack"
		puts "You lose $10."
		$bank_roll -= 10
	else
		puts "BLACKJACK!"
		puts "You win 1.5 times your bet: $15"
		$bank_roll += 15
	end
end



#  Deck is a hash storing all the values of a single deck
#  It is used to get the values of the cards that are dealt
#  At the beginning of the game the deck is full.
#  **NOTE: Aces have a starting value of 11 and are assumed to be 11
#  unless player with ace busts, in which case the value of the ace is 
#  switched to 1.
deck = {
	"AH" => 11, "2H" => 2, "3H" => 3, "4H" => 4, "5H" => 5, "6H" => 6, "7H" => 7, "8H" => 8, "9H" => 9, "10H" => 10, "JH" => 10, "QH" => 10, "KH" => 10,
	"AD" => 11, "2D" => 2, "3D" => 3, "4D" => 4, "5D" => 5, "6D" => 6, "7D" => 7, "8D" => 8, "9D" => 9, "10D" => 10, "JD" => 10, "QD" => 10, "KD" => 10,
	"AC" => 11, "2C" => 2, "3C" => 3, "4C" => 4, "5C" => 5, "6C" => 6, "7C" => 7, "8C" => 8, "9C" => 9, "10C" => 10, "JC" => 10, "QC" => 10, "KC" => 10,
	"AS" => 11, "2S" => 2, "3S" => 3, "4S" => 4, "5S" => 5, "6S" => 6, "7S" => 7, "8S" => 8, "9S" => 9, "10S" => 10, "JS" => 10, "QS" => 10, "KS" => 10,
}

# Starting bank roll is set to $100
$bank_roll = 100

# ======================================================
# ========= Player interaction begins here =============
# ======================================================

puts "Welcome to BlackJack 1.0"
puts "You have $100. Bets are $10."

while true
	#  Builds an array of keys from the deck without associated values
	#  This deck is rebuilt each time the player chooses to deal new cards
	#  so that dealing always happens from a full deck.
	$deck_keys = deck.keys 

	# Set the beginning state of the game
	possible_states = ["cards_not_dealt", "cards_dealt", "bust", "after_dealer_move"]
	game_state = "cards_not_dealt"
	players_turn = true
	query_response =

	while query_response != "Q"
		query_response = query(game_state)
		#puts "1"

		if query_response == "D"									# If the user chose to deal, deal the cards
			#puts "2"
			starting_hands = deal										# Pass the starting hands out 
			game_state = "cards_dealt"							# The deck has now been dealt so the game state changes
		
			players_hand = starting_hands[0]																					# the players hand is stored into an array
			player_total = deck[players_hand[0]] + deck[players_hand[1]]							# the value of the players hand

			dealers_hand = starting_hands[1]																					# ditto above but with dealers hand
			dealer_visible_total = deck[dealers_hand[0]]                    					# set the visible total of the dealers hand 
			dealers_actual_total = deck[dealers_hand[0]] + deck[dealers_hand[1]]			# set the dealers actual hand value

		  display(players_turn, players_hand, dealers_hand, player_total, dealer_visible_total, dealers_actual_total)

		  if evaluate(game_state, players_hand, player_total, dealers_hand, dealers_actual_total, players_turn) == ("player blackJack" || "dealer blackJack")
				blackJack(evaluate(game_state, players_hand, player_total, dealers_hand, dealers_actual_total, players_turn))
				game_state = "cards_not_dealt"
			end
		elsif query_response == "H"																						# If player hits then deal a new card
			#puts "3"
			players_hand << dealNewCard																					# Players hand is updated to include the new card
			player_total += deck[players_hand[players_hand.length - 1]]					# The new card value is added to the value of the rest of the players hand	
			
			display(players_turn, players_hand, dealers_hand, player_total, dealer_visible_total, dealers_actual_total)
			
			if evaluate(game_state, players_hand, player_total, dealers_hand, dealers_actual_total, players_turn) == "bust"														# If the player busts then change the bank roll and display bust message
				bust
				break																																																										  # Break will return game to its starting state at which point everything proceeds from beginning
			elsif evaluate(game_state, players_hand, player_total, dealers_hand, dealers_actual_total, players_turn) == "push"												# If push right off the bat then return game to starting state
				push
				break
			end

		elsif query_response == "S"
			#puts "4"
			#puts "#{game_state}"
			players_turn = false
			display(players_turn, players_hand, dealers_hand, player_total, dealer_visible_total, dealers_actual_total)
			while dealers_actual_total <= 16
				dealers_hand << dealNewCard
				dealers_actual_total += deck[dealers_hand[dealers_hand.length - 1]]
				display(players_turn, players_hand, dealers_hand, player_total, dealer_visible_total, dealers_actual_total)
			end
			result = evaluate(game_state, players_hand, player_total, dealers_hand, dealers_actual_total, players_turn)
			if result == "push"
				push
				break
			elsif result == "bust"
				puts "Dealer busted"
				puts "You win $10"
				$bank_roll += 10
				break
			elsif result == "dealer win"
				puts "Dealer Wins"
				puts "You lose $10"
				$bank_roll -= 10
				break
			elsif result == "player win"
				puts "You win $10!"
				$bank_roll += 10
				break
			end
			#display(players_turn, players_hand, dealers_hand, player_total, dealer_visible_total, dealers_actual_total)
		end
	end
end	






















