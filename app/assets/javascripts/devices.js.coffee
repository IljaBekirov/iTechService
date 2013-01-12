jQuery ->
  
  $('.device_task_task').live 'change', () ->
    task_id = $(this).val()
    task_cost = $(this).parents('.device_task').find('.device_task_cost')
    $.getJSON '/tasks/'+task_id+'.json', (data) ->
      task_cost.val data.cost
      
  $('.device_comment_tooltip').tooltip()

  $('.device_progress').tooltip
    placement: 'left'
    html: true
  
  $('#history').live 'click', '.close_history', (event) ->
    $history = $('#history')
    $history.remove()

  $('a', 'ul#locations_list').live 'click', (event) ->
    $('#location_value').text($(this).text())
    $('#device_location_id').val($(this).attr('location_id'))
    event.preventDefault()

  $('#device_security_code_none').click (event)->
    $('#device_security_code').val('-')