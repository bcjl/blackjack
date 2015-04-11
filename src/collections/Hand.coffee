class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
    # @set 'cards' , array
    # @set 'deck' , @deck
    # @set 'isDealer' , @isDealer

  hit: ->
    @add(@deck.pop())
    if @minScore() > 21
      console.log('busted')
      @trigger('bust',@)
    if 21 in @scores()
      @trigger('blackJack',@)
      console.log('blackjack')

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  playDealer: ->
    @at(0).flip()
    while @minScore() < 17
      @hit()
    @trigger('gameOver',@)

  bestScore: ->
    checkScore = (score) -> if score <= 21 then score else 0
    Math.max(checkScore(@scores()[0]),checkScore(@scores()[1]))

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]



