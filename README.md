# README

This application is a work in progress, pending communications with my VAN database team, and so currently is just a prototype. As soon as I get my production key, I will have a production model available to see on heroku here[https://van-csv-uploader.herokuapp.com]. Future features will include admin dashboard functionality for updating/changing survey questions/ids, synching to campaign entry forms, and perhaps even summary graphs. If you feel passionate about helping local campaigns and/or have ideas to share, feel free to issue a Pull Request and get the conversation going!

This app was designed for a local senate campaign, intending to be a tool for the candidate's campaign to use for fast uploads to VAN VoteBuilder, an online database used by the Democratic Party across the United States. In our instance, my candidate was using her campaign website as a location for volunteer signups and campaign-related surveys. However, the website was built on Wordpress, and did not provide any easy way to transfer form data to her more-official campaign database: VAN. This app aims to bridge that gap, and required me to investigate several new technologies, including: React, DropZone, Wordpress/Virtual Form Builder plugin, and also allowed me to wrestle with Background Workers for the first time through REDIS/Sidekiq.

Combining my political interests with my new-found skills, the problem presented a fun challenge for my Capstone project, and the result is this application:

Simple to use and replicable, VanCSVUploader uses a simple drag-and-drop system for CSV uploads, and then leaves the work to the app. While VanCSVUploader depends on synching the parser to survey questions, it is adaptable. Future adaptions could include a way for the admin to update survey questions internally. Feel free to put in a PullRequest!

### Ruby version
This application was built using Ruby 2.4.1 and Rails 5.1.

### System dependencies
Redis
Node.js
Webpack(er)
Yarn or NPM

### Deployment instructions/ Configuration

bundle install
rake db:create
rake db:migrate

figaro install

and in the created config/application.yml file, you will need to put in your own VAN_API_KEY, VAN_USERNAME, & USER_EMAIL (from which the summary emails will be sent by default)

by the end it should look like this:

```
VAN_API_KEY: beXXXd0-680b-XXXX-9XXX-0X2X2XXXb3bb|1
VAN_USERNAME: exampleAPIUser
USER_EMAIL: 'example@gmail.com'
```

follow the (VAN Api Developer docs here)[https://developers.ngpvan.com/] to get started.

### How to run the test suite

run `rspec` to run unit, service, helper, and feature tests.
