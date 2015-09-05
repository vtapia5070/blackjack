# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'stand', => 
      @get('dealerHand').dealerFinish()

    @get('dealerHand').on 'compareHands', =>
      playerScore = @get('playerHand').scores()
      console.log(playerScore)
      @get('dealerHand').endGame(playerScore)
      console.log('endgame should have been triggered')
