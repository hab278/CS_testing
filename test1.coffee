root = exports ? window
root.hours = []
class weeklyhours
  constructor: () ->
    @currentlyOpen = currentlyOpen #open or not exactly when this code is executed.
    @status = status #24hours or not.
    #The above two varibales are not for any specific day but exactly right when yourun the code so the not linked to the variable below
    #@weeklyHours[52] = ['sunday':['date':"",'from': "", 'to': ""],'monday':['date':"",'from': "", 'to': ""],'tuesday':['date':"",'from': "", 'to': ""],'wednesday':['date':"",'from': "", 'to': ""],'thursday':['date':"",'from': "", 'to': ""],'friday':['date':"",'from': "", 'to': ""],'saturday':['date':"",'from': "", 'to': ""]]
    @dates[366] = ['date':"":['day':"",'from': "", 'to': ""]]

class HoursLibcal
  constructor: (name,category,phone,email,address1,address2,tmz) ->
    @name = name
    @category = category
    @phone = phone
    @email = email
    @address1 = address1
    @address2 = address2
    @tmz = tmz
    #@weekhours = new weeklyhours()


init = ->
  $.getJSON 'http://api3.libcal.com/api_hours_grid.php?iid=1287&format=json&weeks=52&callback=?', (data) ->
    d = new Date();
    day = d.getDay();
    weekday = new Array(7);
    weekday[0]=  "Sunday"
    weekday[1] = "Monday"
    weekday[2] = "Tuesday"
    weekday[3] = "Wednesday"
    weekday[4] = "Thursday"
    weekday[5] = "Friday"
    weekday[6] = "Saturday";
    for i in [0..data.locations.length-1] by 1
      name = data.locations[i].name
      category = data.locations[i].category
      contacts = data.locations[i].contact
      phone = contacts.substring(0,contacts.indexOf(";")).trim()
      contacts = contacts.substring(contacts.indexOf(";")+1).trim()
      email = contacts.substring(0,contacts.indexOf(";")).trim()
      contacts = contacts.substring(contacts.indexOf(";")+1).trim()
      tmz = contacts.substring(0,contacts.indexOf(";")).toUpperCase().trim()
      contacts = contacts.substring(contacts.indexOf(";")+1).trim()
      address1 = contacts.substring(0,contacts.indexOf(";")+1).trim()
      contacts = contacts.substring(contacts.indexOf(";")+1).trim()
      address2 = contacts.trim();
      currentlyOpen = if data.locations[i].weeks[0][weekday[day]].times.currently_open then "OPEN" else "CLOSED"
      #alert ""+currentlyopen
      #for j in [0..data.locations[i].weeks.length] by 1

      root.hours[i] = new HoursLibcal(name,category,phone,email,address1,address2,tmz)
    #alert ""+root.hours[1].name
    return
  return


init();
