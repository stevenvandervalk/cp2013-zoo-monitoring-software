# Create a global ISODateString object.
# The ISODateString can provide a timedate string for UTC (GMT) in the ISO standard.
window.ISODateString = {
  # Function to pad a number (e.g. 1 becomes 01)
  pad: (n) ->
    if n < 10
      '0' + n
    else
      n

  # Get the ISODateString for Date d
  getString: (d) ->
    return d.getUTCFullYear() + '-' +
      window.ISODateString.pad(d.getUTCMonth()+1) + '-' +
      window.ISODateString.pad(d.getUTCDate()) + 'T' +
      window.ISODateString.pad(d.getUTCHours()) + ':' +
      window.ISODateString.pad(d.getUTCMinutes()) + ':' +
      window.ISODateString.pad(d.getUTCSeconds()) + 'Z'
}
