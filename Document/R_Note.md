R Note
================

Output plot with transparent background
=======================================

Create plot: set `panel.background` and `plot.background` to 'transparent'

    ggplot() +
      (...) +
      theme(
        panel.background = element_rect(fill = 'transparent'),
        plot.background = element_rect(fill = 'transparent')
      )

Save plot: set `bg` to 'transparent\`

    ggsave(..., bg = 'transparent')

Fixing Power BI R HTML Custom Visual Error
==========================================

Replace line

    el.appendChild(document.createTextNode(window.atob(payloadBase64)));

By

    el.innerHTML = window.atob(payloadBase64);

Inside **src\\visual.ts**
