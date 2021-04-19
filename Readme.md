https://find-peers.herokuapp.com/ 


An app to see who works on which project and studend ranking



2 main pages: ranking and projects 

<a href="https://find-peers.herokuapp.com/"><H3>Ranking</h3></a>

I use the rules we use in Paris for the days, but some campuses like tokyo for example has their own blackhole days system count.



<a href="https://find-peers.herokuapp.com/"><H3>Projects doing</h3></a>

Only works for the inner circle

Again I use the Paris rules for every campuses, this is why in some campuses some people are misplaced.
 

Rules: 
You can't subscribe to any project on a circle if you did not validate all projects from the previous circle exam incuded.
 
update: During corona time, to validate an exam is not mandatory anymore to be able to sub to the projects of the next circle.





<H3>Slow responses</h3>

Sometimes a request can take a long time,
It's because app is hosted on a free heroku account,

So, if an app has receives no web traffic in a 30 minute period, it will <a href="https://devcenter.heroku.com/articles/free-dyno-hours">sleep</a>. 

If a sleeping app receives web traffic, it will take between 1 and 2 minutes to wake before it becomes active again



I have set a cron to ping the app each 30 min on <a href="https://cron-job.org/en/">cron-job.org</a> so now it should be ok.


<h3>concerned</h3>

Students belonging to the "42 cursus" cursus who joined 42 from 7th October 2019. 

 
<H3>Intra Applications</h3>
 
 <a href="https://profile.intra.42.fr/oauth/applications">Here</a> you can see all the 42 apps you gave a token access to and revoke the access if needed. 
 
