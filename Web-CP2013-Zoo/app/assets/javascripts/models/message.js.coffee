# Message Model
window.MessageModel = Backbone.Model.extend({

  # default value for a new instance of message
  defaults: {
    employee_id: ""
    message: ""
  }

  sync: (method, model, options) ->

    getValue = (object, prop) ->
      if !(object && object[prop])
        null
      else if _.isFunction(object[prop])
        object[prop]()
      else
        object[prop]

    methodMap = {
      'create': 'POST',
      'update': 'PUT',
      'delete': 'DELETE',
      'read':   'GET'
    }

    type = methodMap[method]

    # Default options, unless specified.
    options || (options = {})

    # Default JSON-request options.
    params = {type: type, dataType: 'json'}

    # Ensure that we have a URL.
    if !options.url
      params.url = getValue(model, 'url') || urlError()

    # Ensure that we have the appropriate request data.
    if (!options.data && model && (method == 'create' || method == 'update'))
      params.contentType = 'application/json';
      modelJSONObj = {
        message: model.toJSON()
      }
      params.data = JSON.stringify(modelJSONObj)

    # For older servers, emulate JSON by encoding the request into an HTML-form.
    if (Backbone.emulateJSON)
      params.contentType = 'application/x-www-form-urlencoded';
      if params.data
        params.data = { mode: params.data }
      else
        params.data = {}

    # For older servers, emulate HTTP by mimicking the HTTP method with `_method`
    # And an `X-HTTP-Method-Override` header.
    if (Backbone.emulateHTTP)
      if (type == 'PUT' || type == 'DELETE')
        if (Backbone.emulateJSON)
          params.data._method = type
        params.type = 'POST';
        params.beforeSend = (xhr) ->
          xhr.setRequestHeader('X-HTTP-Method-Override', type);

    # Don't process data on a non-GET request.
    if (params.type != 'GET' && !Backbone.emulateJSON)
      params.processData = false;

    # Make the request, allowing the user to override any Ajax options.
    $.ajax(_.extend(params, options))

})
