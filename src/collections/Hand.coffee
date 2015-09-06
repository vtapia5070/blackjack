class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
    @isDealer = @isDealer

  hit: ->
    @add(@deck.pop())
    if do @scores > 21 
      if @isDealer
        if alert("Player Wins")
        else window.location.reload() 
      else
        if alert("Dealer Wins")
        else window.location.reload() 

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    score = [@minScore(), @minScore() + 10 * @hasAce()][0]
    score2 = [@minScore(), @minScore() + 10 * @hasAce()][1]
    if score2 > 21
      score2 = score
    score2

  stand: ->
    @trigger('stand', @)

  hitting: =>
    setTimeout (=>
      @hit()
      if @scores() < 17
        @hitting()
      else if do @scores <= 21
        @trigger('compareHands', @)
      return
    ), 750
    return
    
  dealerFinish: ->
    @at(0).flip() 
    @hitting()

  endGame: (playerScore) ->
    console.log('ending game')
    if playerScore == do @scores
      if alert("Player Wins")
      else window.location.reload() 
    else if playerScore > do @scores
      if alert("Player Wins")
      else window.location.reload() 
    else 
      if alert("Dealer Wins")
      else window.location.reload() 
