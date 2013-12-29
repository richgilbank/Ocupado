var Fixtures = {};

Fixtures.Calendars = {
  ca: 'en.canadian#holiday@group.v.calendar.google.com',
  us: 'en.usa#holiday@group.v.calendar.google.com'
};

Fixtures.Room = {
  calendarId: Fixtures.Calendars.ca,
  unAuthenticated: true
};

Fixtures.OccurringEvent = function(room){
  return {
    startDate: (new Date()).subtractHours(1).getTime(),
    endDate: (new Date()).addHours(1).getTime(),
    creatorName: 'Rich Gilbank',
    creatorEmail: 'foo@bar.com',
    name: 'Event 01',
    room: room
  }
}

Fixtures.UpcomingEvent = function(room){
  return {
    startDate: (new Date()).addHours(1).getTime(),
    endDate: (new Date()).addHours(2).getTime(),
    creatorName: 'Rich Gilbank',
    creatorEmail: 'foo@bar.com',
    name: 'Event 02',
    room: room
  }
};

Fixtures.PastEvent = function(room){
  return {
    startDate: (new Date()).subtractHours(2).getTime(),
    endDate: (new Date()).subtractHours(1).getTime(),
    creatorName: 'Rich Gilbank',
    creatorEmail: 'foo@bar.com',
    name: 'Event 03',
    room: room
  }
};

Fixtures.FutureEvent = function(room){
  return {
    startDate: (new Date()).addHours(2).getTime(),
    endDate: (new Date()).addHours(3).getTime(),
    creatorName: 'Rich Gilbank',
    creatorEmail: 'foo@bar.com',
    name: 'Event 03',
    room: room
  }
};

