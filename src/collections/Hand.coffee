class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
    @isDealer = @isDealer

  hit: ->
    @add(@deck.pop())
    if do @scores > 21 
      if @isDealer
        alert("Player Wins") 
      else
        alert("Dealer Wins")

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    score = [@minScore(), @minScore() + 10 * @hasAce()][0]
    score2 = [@minScore(), @minScore() + 10 * @hasAce()][1]
    if score2 > 21
      score2 = score
    score2

  stand: ->
    @trigger('stand', @)
    
  dealerFinish: ->
    @at(0).flip() 
    while do @scores < 17
      do @hit
    if do @scores <= 21
      @trigger('compareHands', @)

  endGame: (playerScore) ->
    console.log('ending game')
    if playerScore == do @scores
      alert("Tie Game!")
    else if playerScore > do @scores
      alert("Player Wins")
    else 
      alert("Dealer Wins")
      

