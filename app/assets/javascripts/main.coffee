$ ->
  $("form#sign_in_user").bind("ajax:success", (event, xhr, settings)->
    if xhr['password'] is null
      error_message = "<div class='alert alert-danger pull-left'>Неверная почта или пароль!</div>"
      $(this).parents('.modal-content').children('.modal-footer').html(error_message)
    else
      alert 'Вы были успешно авторизованы'
      $(this).parents('.modal').modal('hide')
      window.location.href = '/chat_rooms'
    console.log xhr
  ).bind("ajax:error", (event, xhr, settings, exceptions) ->
    error_message = "<div class='alert alert-danger pull-left'>Неверная почта или пароль!</div>"
    $(this).parents('.modal-content').children('.modal-footer').html(error_message)
  )
$ ->
  $("form#sign_up").bind("ajax:success", (event, xhr, settings)->
    $(this).parents('.modal').modal('hide')
    alert 'Вы были успешно зарегистрированы'
    window.location.href = '/edit_profile'
  ).bind("ajax:error", (event, xhr, settings, exceptions) ->
    console.log JSON.parse(xhr.responseText)['errors']
    error_messages = if JSON.parse(xhr.responseText)['error']
      "<div class='alert alert-danger pull-left'>" + JSON.parse(xhr.responseText)['error'] + "</div>"
    else if JSON.parse(xhr.responseText)['errors']
      $.map(JSON.parse(xhr.responseText)['errors'], (v, k) ->
        "<div class='alert alert-danger pull-left'>" + " " + v + "</div>"
      ).join ""
    else
      "<div class='alert alert-danger pull-left'>Unknown error</div>"
    $(this).parents('.modal-content').children('.modal-footer').html(error_messages)
  )