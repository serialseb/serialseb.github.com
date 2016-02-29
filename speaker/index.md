---
layout: page
title: Talks and Workshops
---
{%
assign cities = '' | split: ''                                              %}{%
assign active = site.talks | where: "active","true"                         %}{%
assign talks = active |  | where: "type", "talk"                            %}{%
assign retired_talks = site.talks | where: "active", "false"                %}{%
assign workshops = active | where: "type","workshop"                        %}{%
assign totalEvents = 0                                                      %}{%
assign all = site.talks | map: "deliveries"                                 %}{%
for deliveries in all                                                       %}{%
  assign totalEvents = totalEvents | plus: deliveries.size                  %}{%
  for delivery in deliveries                                                %}{%
    unless cities contains delivery.location %}{%
    assign cities = cities | push: delivery.location                        %}{%
    endunless %}{%
  endfor %}{%
endfor %}

### Overview

I have given {{ site.talks.size }} talks and workshops a total of {{totalEvents}} times in {{ cities.size}} cities.

### Talks

{%for talk in active %}
 - [{{talk.title}}]({{site.url}}{{talk.url}})
{% endfor %}

### Workshops

{%for talk in workshops %}
 - [{{talk.title}}]({{site.url}}{{talk.url}})
{% endfor %}

### Past talks

Those talks have not been presented in a while, were a one-off or are just here because they are funny.

If you want one of these talks for your user-group or conference, please contact me and we can discuss bringing it back.

 {% for talk in retired_talks %}
  - [{{talk.title}}]({{site.url}}{{talk.url}})
 {% endfor %}

### Copyright notice

Please note, the providing of the links to the videos, slides and does not grant you any additional rights. All content
is copyrighted Sebastien Lambla and / or Caffeine IT and / or naughtyProd Limited.

Each conference may release material independently from this site and may do so under a different licensing term, please
check on each web site what license it's under. For the avoidance of doubt, if there is no license you have no license
to use the content.

Code license is usually in the codebase (most of the time I go for MIT).

If you want to reuse, deliver or distribute some of the material presented here, it's usually fine but you have to
contact us, let me know and get permission first.
