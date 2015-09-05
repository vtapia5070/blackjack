class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    #card = random number 0-51
    @add _([0...52]).shuffle().map (card) ->
      new Card
        #0-12
        rank: card % 13
        suit: Math.floor(card / 13)

  dealPlayer: -> new Hand [@pop(), @pop()], @

  dealDealer: -> new Hand [@pop().flip(), @pop()], @, true

