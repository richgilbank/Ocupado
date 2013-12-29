var Fixtures = {};

Fixtures.Room = {
  calendarId: 'en.canadian#holiday@group.v.calendar.google.com',
  unAuthenticated: true
};

Fixtures.OccurringEvent = function(room){
  return {
    startDate: Date.now(),
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

