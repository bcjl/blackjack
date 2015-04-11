class window.BankView extends Backbone.View
  className: 'bank'

  template: _.template '<div>Current Bet: <%= currentBet %> <br> <%= value %></div>'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
