class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <form>Bet Amount: <input id="betAmount" type="number" value="10"><br><button class="bet-button" type="button">Submit</button></form>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
    <div class="status-display">Game Status:</div>
    <div class="bank-container"></div>
  '

  events:
    'click .hit-button': ->
      if not @model.get('preGame')
        @model.get('playerHand').hit()
    'click .stand-button': ->
      if not @model.get('preGame')
        @model.get('dealerHand').playDealer()
    'click .bet-button': ->
      if @model.get('preGame')
        @model.get('bank').bet($("#betAmount").val())
        @model.get('playerHand').flipCardsForPreGame()
        @model.set('preGame',false)
      # alert($("#betAmount").val())
      @render()

  initialize: ->
    @render()
    @startHandListeners()
    @render()


  startHandListeners: ->
    @model.get('bank').bet(10)

    @model.get('playerHand').on('bust',
      ->
        @model.set('outcome','Player Busts')
        @model.setWinner('dealer')
        @startNewHand()
      ,  @)

    @model.get('dealerHand').on('bust',
      ->
        @model.set('outcome','Dealer Busts')
        @model.setWinner('player')
        @startNewHand()
      ,  @)

    @model.get('playerHand').on('blackJack',
      ->
        @model.set('outcome','Black Jack!!')
        @model.setWinner('player')
        @startNewHand()
      , @)

    @model.get('dealerHand').on('gameOver',
      ->
        @model.findWinner()
        @model.set('outcome',"Winner is #{@model.get('winner')}")
        @startNewHand()
      , @)

  announceGameStatus: ->
    # alert(@model.get('outcome'))
    # @model.get('outcome').el


  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.bank-container').html new BankView(model: @model.get 'bank').el
    @$('.status-display').html "Winner: #{@model.get 'outcome'}"


  startNewHand: ->
    @render()
    @announceGameStatus()
    @model.setWinner(null)
    @model.set('outcome',null)
    @model.set('preGame',true)
    @model.redeal()
    @startHandListeners()
    # @render()

