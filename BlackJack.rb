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
def query(game_state, bank_roll)
	while true 
		print "What would you like to do? "								# Standard query
		action = gets.chomp.upcase												# Store the users request

		if action == "M" then puts "You have $#{bank_roll}.\n\n" end
		if action == "Q" 
			puts "Goodbye" 
			return action 
		end

		# At any time if user tries to input unacceptable order, display acceptable inputs
		if ((action != "H") & (action != "S")) & ((action != "Q") & ((action != "M") & (action != "D")))	
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
			elsif action == ("H" || "S")
				return action
			elsif action == "Q"
				puts "Quit"
				return action
			end
		end
	end
end

#  Returns a new random card from the deck as well as the updated deck
#  which not longer contains the card just dealt.
def dealNewCard(deck_keys)
	new_card = deck_keys[rand(deck_keys.length)]
	deck_keys.delete(new_card)
	return new_card, deck_keys
end

#  Deals the starting hands. 
#  Operates by twice dealing to the player and then the dealer.
#  After each card is dealt, the deck is updated to reflect these 
#  missing cards. And array of player cards, and array of dealer cards,
#  and the updated deck are returned.
def deal(deck_keys)	
	player_cards, dealer_cards = Array.new(2) { [] }

	2.times do 
		new_card = dealNewCard(deck_keys)
		player_cards << new_card[0]
		deck_keys = new_card[1]

		new_card = dealNewCard(deck_keys)
		dealer_cards << new_card[0]
		deck_keys = new_card[1]
	end

	return player_cards, dealer_cards, deck_keys
end 

#  Evaluates the hands and returns a new game state 
#  Ex: push, bust, win, lose
def evaluate(game_state, player_hand, player_total, dealers_hand, dealers_actual_total)

	if game_state == "cards_dealt"
		if (player_total == 21) && (dealers_actual_total == 21)				# If dealer and player are both dealt Black Jack then push
			return "push"
		elsif (dealers_actual_total == 21) && (dealers_hand.length == 2) # If dealer is dealt Black Jack but player is not, then dealer wins
			return "dealer blackJack"
		elsif (player_total == 21) && (player_hand.length == 2)				# If player is dealt Black Jack but dealer is not, then player wins
			return "player blackJack"
		elsif (player_total > 21)
			return "bust"
		else 
			return "nothing"
		end
	else
		#evalute other things
	end
end

# Displays the players cards and Dealers cards with their associated values
def display(player_turn, players_hand, dealers_hand, player_total, dealer_visible_total)
	lineWidth = 25

	if players_hand.length > dealers_hand.length			# Take the hand that has more cards and store the number 
		largest_hand = players_hand.length - 1 				# cards in that hand into a variable
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
			if (dealer_hand.length - 1) <= i
				print "#{dealers_hand[i]}".center(lineWidth)
			else
				print "    ".center(lineWidth)
			end

			if (players_hand.length - 1) <= i
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
	print " #{dealer_visible_total}".ljust(lineWidth + 1)
	puts "#{player_total}".ljust(lineWidth + 1)
end

def bust(bank_roll)
	puts "You busted."
	puts "You lose $10"
	return bank_roll -= 10
end

def push
	puts "Push"
end

def blackJack(bank_roll, who_won)
	if who_won == "dealer blackJack"
		#display cards?
		puts "Dealer has Black Jack"
		puts "You lose $10."
		return bank_rol -= 10
	else
		puts "BLACKJACK!"
		puts "You win 1.5 times your bet: $15"
		return bank_roll += 15
	end
end



#  Deck is a hash storing all the values of a single deck
#  It is used to get the values of the cards that are dealt
#  At the beginning of the game the deck is full.
#  **NOTE: Aces have a starting value of 11 and are assumed to be 11
#  unless player with ace busts, in which case the value of the ace is 
#  switched to 1.
deck = {
	"AH" => 11,
	"2H" => 2,
	"3H" => 3,
	"4H" => 4,
	"5H" => 5,
	"6H" => 6,
	"7H" => 7,
	"8H" => 8,
	"9H" => 9,
	"10H" => 10,
	"JH" => 10,
	"QH" => 10,
	"KH" => 10,
	"AD" => 11,
	"2D" => 2,
	"3D" => 3,
	"4D" => 4,
	"5D" => 5,
	"6D" => 6,
	"7D" => 7,
	"8D" => 8,
	"9D" => 9,
	"10D" => 10,
	"JD" => 10,
	"QD" => 10,
	"KD" => 10,
	"AC" => 11,
	"2C" => 2,
	"3C" => 3,
	"4C" => 4,
	"5C" => 5,
	"6C" => 6,
	"7C" => 7,
	"8C" => 8,
	"9C" => 9,
	"10C" => 10,
	"JC" => 10,
	"QC" => 10,
	"KC" => 10,
	"AS" => 11,
	"2S" => 2,
	"3S" => 3,
	"4S" => 4,
	"5S" => 5,
	"6S" => 6,
	"7S" => 7,
	"8S" => 8,
	"9S" => 9,
	"10S" => 10,
	"JS" => 10,
	"QS" => 10,
	"KS" => 10,
}

# Starting bank roll is set to $100
bank_roll = 100

# ======================================================
# ========= Player interaction begins here =============
# ======================================================

puts "Welcome to BlackJack 1.0"
puts "You have $100. Bets are $10."

while true
	#  Builds an array of keys from the deck without associated values
	#  This deck is rebuilt each time the player chooses to deal new cards
	#  so that dealing always happens from a full deck.
	deck_keys = deck.keys 

	# Set the beginning state of the game
	possible_states = ["cards_not_dealt", "cards_dealt", "bust", "after_dealer_move"]
	game_state = possible_states[0]
	players_turn = true


	if query(game_state, bank_roll) == "D"
		starting_hands = deal(deck_keys)				# pass the 4 cards and the new deck out of the deal method
		game_state = possible_states[1]					# the deck has now been dealt
		deck_keys = starting_hands[2]						# the deck is updated to reflect the missing cards

		players_hand = starting_hands[0]																					# the players hand is stored into an array
		player_total = deck[players_hand[0]] + deck[players_hand[1]]							# the value of the players hand

		dealers_hand = starting_hands[1]																					# ditto above but with dealers hand
		dealer_visible_total = deck[dealers_hand[0]]                    					# set the visible total of the dealers hand 
		dealers_actual_total = deck[dealers_hand[0]] + deck[dealers_hand[1]]			# set the dealers actual hand value

	  display(players_turn, players_hand, dealers_hand, player_total, dealer_visible_total)
	end

	if evaluate(game_state, players_hand, player_total, dealers_hand, dealers_actual_total) == ("player blackJack" || "dealer blackJack")
		blackJack = true
		bank_roll = blackJack(bank_roll, evaluate(game_state, players_hand, player_total, dealers_hand, dealers_actual_total))[0]
	end

	while true && (blackJack != true)
		query_response = query(game_state, bank_roll)		# Just get a response from the player. At this point, only Q, H, or S are possible return values

		if query_response == "H"
			hit_returns = dealNewCard(deck_keys)
			players_hand << hit_returns[0]								# Players hand is updated to include the new card
			player_total += deck[hit_returns[0]]					# The new card value is added to the value of the rest of the players hand
			deck_keys = hit_returns[1]										# The deck is updated to reflect that it is missing the last card drawn		
			
			display(players_turn, players_hand, dealers_hand, player_total, dealer_visible_total)
			result = evaluate(game_state, players_hand, player_total, dealers_hand, dealers_actual_total)

			if result == "bust"														# If the player busts then change the bank roll and display bust message
				bank_roll = bust(bank_roll)
				break																				# Break will return game to its starting state at which point everything proceeds from beginning
			elsif result == "push"												# If push right off the bat then return game to starting state
				push
				break
			end
		else																						# If the player chooses not to hit, that is, he either Quits or Stands, then move out of this loop
			break
		end
	end	

	players_turn = false

	if query_response == "S"													# If the player chose to stand then the dealer moves
		display(players_turn, players_hand, dealers_hand, player_total, dealer_visible_total)
		while dealers_actual_total <= 16
			hit_returns = dealNewCard(deck_keys)
			dealers_hand << hit_returns[0]
			dealers_actual_total += deck[hit_returns[0]]
			deck_keys = hit_returns
			display(players_turn, players_hand, dealers_hand, player_total, dealer_visible_total)
		end

		evaluate(game_state, players_hand, player_total, dealers_hand, dealers_actual_total)
	end
	#puts "I'm outside"
end



















