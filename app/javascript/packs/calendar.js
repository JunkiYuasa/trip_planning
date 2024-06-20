/*global $*/
/*global fetch*/

import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import listPlugin from "@fullcalendar/list";

document.addEventListener('DOMContentLoaded', function() {
  var calendarEl = document.getElementById('calendar');

  fetch('/plans.json')
    .then(response => response.json())
    .then(plans => {
      let events = plans.map(plan => {
        return {
          id: plan.id,
          title: plan.name,
          start: plan.start_time,
          end: plan.end_time,
          color: plan.plan_genre.color,
          path:"/plans/"
        };
      });

      var calendar = new Calendar(calendarEl, {
        plugins: [dayGridPlugin, listPlugin],
        initialView: 'dayGridMonth',
        locale: 'ja',
        events: events,
        windowResize: function() {
          if (window.innerWidth < 991.98) {
            calendar.changeView('listMonth');
          } else {
            calendar.changeView('dayGridMonth');
          }
        },
        eventClick: function(info) {

          window.location.href = '/plans/'+ info.event.id;
          info.jsEvent.preventDefault();
        }
      });

      calendar.render();
    });
});
