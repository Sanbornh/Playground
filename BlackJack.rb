#  Play BlackJack 1 0n 1 vs the dealer
#
#
#

#  Query handles all querying for the game.
#  It asks for user input, then it checks if the user has requested
#  to perform a valid move. Ex: if the user has asked to hit before
#  the deck has been dealt then the user is prompted for a new response.
#  If a valid response is given, this response is returned.
def query(cards_dealt, bank_roll)
	while true 
		print "What would you like to do? "
		action = gets.chomp.upcase

		if cards_dealt == false
			if action == "D"
				return "D"
			elsif (action == "H") || (action == "S")
				puts "The cards haven't been dealt.\n\n"
			elsif action == "Q"
				puts "Goodbye"
				return "G"
			elsif action == "M"
				puts "You have $#{bank_roll}.\n\n"
			else
				puts "\nI don't understand."
				puts "You may: (D)eal, (H)it, (S)tand, display (M)oney, or (Q)uit."
				puts "Therea are no other options. Deal with it.\n\n"
			end
		else
			if action == "D"
				puts "The cards are already dealt.\n\n"
			elsif (action == "H") 
				return "H"
			elsif (action == "S")
				return "S"
			elsif action == "Q"
				puts "Goodbye"
				return "G"
			elsif action == "M"
				puts "You have $#{bank_roll}.\n\n"
			else
				puts "I don't understand. You may:"
				puts "(D)eal, (H)it, (S)tand, display (M)oney, or (Q)uit."
				puts "Therea are no other options. Deal with it.\n\n"
			end
		end
	end
end

#  When asked to deal, cards are dealt to the player and the dealer
#  A random card is first given to the player and then is removed from the deck array
#  so that it is not available to be drawn from the deck anymore. 
#  This process is repeated next for the dealer etc.. until player and dealer
#  have two cards in front of them.
#  The cards are returned as is the current state of the deck. 
#  Ex: once dealt, four random cards will be returned and the deck minus those four cards will be
#  returned. This new deck will later be passed to the hit function so that no cards can be drawn
#  twice.
def deal(deck_keys)	
	player_card_one = deck_keys[rand(deck_keys.length)]
	deck_keys.delete(player_card_one)

	dealer_card_one = deck_keys[rand(deck_keys.length)]
	deck_keys.delete(dealer_card_one)

	player_card_two = deck_keys[rand(deck_keys.length)]
	deck_keys.delete (player_card_two)

	dealer_card_two = deck_keys[rand(deck_keys.length)]
	deck_keys.delete(dealer_card_two)

	return player_card_one, player_card_two, dealer_card_one, dealer_card_two, deck_keys
end 

#  Returns a new random card from the deck as well as the updated deck
def hit(deck_keys)
	new_card = deck_keys[rand(deck_keys.length)]
	deck_keys.delete(new_card)
	return new_card, deck_keys
end

def compare(player_total, dealers_actual_total)

	if (player_total == 21) && (dealers_actual_total == 21)
		return "push"
	elsif (player_total > 21)
		return "bust"
	elsif (player_total > dealers_actual_total)
		return "win"
	else 
		return "lose"
	end
end

# Displays the players cards and Dealers cards with their associated values
def display(players_hand, dealers_hand, player_total, dealer_visible_total)
	lineWidth = 25

	# Table Headings
	print "Dealer".center(lineWidth)
	puts "Player".center(lineWidth)
	print "======".center(lineWidth)
	puts "======".center(lineWidth)


	for i in 0..players_hand.length - 1 do
		if i == 0
			print "#{dealers_hand[i]}".center(lineWidth)
		else
			print " xx ".center(lineWidth)
		end
		puts " #{players_hand[i]} ".center(lineWidth)
	end

	# Divider
	print "======".center(lineWidth)
	puts "======".center(lineWidth)

	# Value of Players hand and visible dealer card
	print "Total:".ljust(10)
	print " #{dealer_visible_total}".ljust(lineWidth + 1)
	puts "#{player_total}".ljust(lineWidth + 1)
end


# Set the beginning state of the game
# No cards have been dealt and player starts with $100
cards_dealt = false
bank_roll = 100

#  Deck is a hash storing all the values of a single deck
#  It is used to get the values of the cards that are dealt
#  At the beginning of the game the deck is full
deck = {
	#"AH" => [1, 11],
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
	# "AD" => [1, 11],
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
	# "AC" => [1, 11],
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
	# "AS" => [1, 11],
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

#  Builds an array of all the cards (without associated values)
deck_keys = deck.keys 


# Player interaction begins here
puts "Welcome to BlackJack 1.0"
puts "You have $100. Bets are $10."

if query(cards_dealt, bank_roll) == "D"
	starting_hands = deal(deck_keys)		# pass the 4 cards and the new deck out of the deal method
	cards_dealt = true									# the deck has now been dealt
	deck_keys = starting_hands[4]				# the deck is updated to reflect the missing cards

	players_hand = starting_hands[0], starting_hands[1] 											# the players hand is stored into an array
	player_total = deck[players_hand[0]] + deck[players_hand[1]]							# the value of the players hand

	dealers_hand = starting_hands[2], starting_hands[3]												# ditto above but with dealers hand
	dealer_visible_total = deck[dealers_hand[0]]                    					# set the visible total of the dealers hand 
	dealers_actual_total = deck[dealers_hand[0]] + deck[dealers_hand[1]]			# set the dealers actual hand value

  display(players_hand, dealers_hand, player_total, dealer_visible_total)
end
compare(player_total, dealers_actual_total)

while query(cards_dealt, bank_roll) == "H"
	hit_returns = hit(deck_keys)
	players_hand << hit_returns[0]								# players hand is updated to include the new card
	player_total += deck[hit_returns[0]]					# the new card value is added to the value of the rest of the players hand
	deck_keys = hit_returns[1]										# the deck is updated to reflect that it is missing the last card drawn		
	display(players_hand, dealers_hand, player_total, dealer_visible_total)
	puts compare(player_total, dealers_actual_total)

end	



















