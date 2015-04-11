class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
    <div class="bank-container"></div>
  '

  events:
    'click .hit-button': ->
      @model.get('playerHand').hit()
    'click .stand-button': ->
      @model.get('dealerHand').playDealer()


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
    alert(@model.get('outcome'))

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.bank-container').html new BankView(model: @model.get 'bank').el

  startNewHand: ->
    @announceGameStatus()
    @model.setWinner(null)
    @model.redeal()
    @startHandListeners()
    @render()

