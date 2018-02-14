@$Mij = mijyu = {}

mijyu.getFormData = (form) ->
  result = {}
  form = $(form).serializeArray()
  for own i, val of form
    result[val.name] = val.value
  result