class window.CardView extends Backbone.View
  className: 'card'
  # template: _.template '<%= rankName %> of <%= suitName %>'
  template: _.template '<div style="display: block; background-size:contain; background-image:url(\'./img/cards/<%= rankName %>-<%= suitName %>.png\'); width:100px; height:140px" ></div>'
  # template: _.template '<div>test</div>'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'

