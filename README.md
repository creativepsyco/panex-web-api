panex-web-api
=============

Panex Web API


###Routes
---------

``` ruby

                         POST   /patients/:patient_id/patient_data/upload(.:format) patient_data#upload
                         GET    /patients/:patient_id/patient_data(.:format)        patient_data#index
   patients_patient_data GET    /patients/patient_data(.:format)                    patient_data#index_all
                patients GET    /patients(.:format)                                 patients#index
                         POST   /patients(.:format)                                 patients#create
             new_patient GET    /patients/new(.:format)                             patients#new
            edit_patient GET    /patients/:id/edit(.:format)                        patients#edit
                 patient GET    /patients/:id(.:format)                             patients#show
                         PUT    /patients/:id(.:format)                             patients#update
                         DELETE /patients/:id(.:format)                             patients#destroy
                    apps GET    /apps(.:format)                                     apps#index
                     app GET    /apps/:id(.:format)                                 apps#show
                services GET    /services(.:format)                                 services#index
                 service GET    /services/:id(.:format)                             services#show
        new_user_session GET    /users/sign_in(.:format)                            sessions#new
            user_session POST   /users/sign_in(.:format)                            sessions#create
    destroy_user_session DELETE /users/sign_out(.:format)                           sessions#destroy
           user_password POST   /users/password(.:format)                           devise/passwords#create
       new_user_password GET    /users/password/new(.:format)                       devise/passwords#new
      edit_user_password GET    /users/password/edit(.:format)                      devise/passwords#edit
                         PUT    /users/password(.:format)                           devise/passwords#update
cancel_user_registration GET    /users/cancel(.:format)                             devise/registrations#cancel
       user_registration POST   /users(.:format)                                    devise/registrations#create
   new_user_registration GET    /users/sign_up(.:format)                            devise/registrations#new
  edit_user_registration GET    /users/edit(.:format)                               devise/registrations#edit
                         PUT    /users(.:format)                                    devise/registrations#update
                         DELETE /users(.:format)                                    devise/registrations#destroy
               user_apps GET    /users/:user_id/apps(.:format)                      apps#index
                         POST   /users/:user_id/apps(.:format)                      apps#create
            new_user_app GET    /users/:user_id/apps/new(.:format)                  apps#new
           edit_user_app GET    /users/:user_id/apps/:id/edit(.:format)             apps#edit
                user_app GET    /users/:user_id/apps/:id(.:format)                  apps#show
                         PUT    /users/:user_id/apps/:id(.:format)                  apps#update
                         DELETE /users/:user_id/apps/:id(.:format)                  apps#destroy
           user_services GET    /users/:user_id/services(.:format)                  services#index
                         POST   /users/:user_id/services(.:format)                  services#create
        new_user_service GET    /users/:user_id/services/new(.:format)              services#new
       edit_user_service GET    /users/:user_id/services/:id/edit(.:format)         services#edit
            user_service GET    /users/:user_id/services/:id(.:format)              services#show
                         PUT    /users/:user_id/services/:id(.:format)              services#update
                         DELETE /users/:user_id/services/:id(.:format)              services#destroy
                   users GET    /users(.:format)                                    users#index
                         POST   /users(.:format)                                    users#create
                new_user GET    /users/new(.:format)                                users#new
               edit_user GET    /users/:id/edit(.:format)                           users#edit
                    user GET    /users/:id(.:format)                                users#show
                         PUT    /users/:id(.:format)                                users#update
                         DELETE /users/:id(.:format)                                users#destroy
                    root        /                                                   home#index



```

###Requirements
---------------
Symlink your system folder with rails public/system folder
``` perl
bash $ ln -s /panex/system public/system 
```

###Job Management
-----------------

####Delayed Job

Uses [Delayed Job][1] for management of worker tasks.

In order to make the the realtime viewing of the tasks online, there is a web interface to it [Delayed Job Web][2].

Must run following in testing mode:
```
rake jobs:work
```

In production must use the following:
``` bash
RAILS_ENV=production script/delayed_job start
RAILS_ENV=production script/delayed_job stop

# Runs two workers in separate processes.
RAILS_ENV=production script/delayed_job -n 2 start
RAILS_ENV=production script/delayed_job stop

# Set the --queue or --queues option to work from a particular queue.
RAILS_ENV=production script/delayed_job --queue=tracking start
RAILS_ENV=production script/delayed_job --queues=mailers,tasks start

# Runs all available jobs and the exits
RAILS_ENV=production script/delayed_job start --exit-on-complete
# or to run in the foreground
RAILS_ENV=production script/delayed_job run --exit-on-complete
```

####Service Management
---------------------
For developers who are interested in developing backend services for the online system, you must make sure of the following things:
  * Submit your services as packaged zip files, don't submit individual libraries etc.
  * Make sure your packaged out-of-the-box service runs as scheduled, otherwise you as a developer will be sent emails about the service failing to run. Keep to the server's configuration
  * If there are scripts that you wish to run you can do in a file called `.setup` supplied in your zipped collection. It is a `bash` script and does your initial setup job
  * Your program binary will be invoked as specfied in `commandLine` field during upload. e.g. a valid command line can be `java myprogram`, this ofcourse assumes you run a `javac myprogram.java` in your `.setup` file. 
  * In addition you will be provided 2 more parameters `input_dir` and `output_dir` in the command line, you must use these as the location of input and output files respectively. This is done as there might be some services which will work on only some files or perhaps on all the files and produce multiple/single results. All these will be linked back to the patient and browsed as such.
  * As such you must make sure to run through all the files within the directory yourself. The service is run in a sandbox so you will not have access to other directories other than the current one (in which your program will be placed)
  * Also see bash script writing formats

An example service, does copying of data written in ruby
```ruby
#!/usr/bin/env ruby

require 'fileutils'

puts ARGV

input_dir = ARGV[0]
output_dir = ARGV[1]

# Addidtional params
Dir.foreach(input_dir) do |item|
	next if item == '.' or item == '..'
	# do work on real items
	puts item
	name = File.basename(item)
	abs_input_path = "#{input_dir}/#{name}"
	dest_file = "#{output_dir}/output_#{name}"
	FileUtils.copy_file abs_input_path, dest_file
	puts "copying to #{dest_file}"
end
```

####Supporting new type of Data
-------------------------------
Addition of new types is easy, At some point, I wish to move out the code, refactor it and make it packaged as an interface or a base class. The design is not really decoupled as computation requires me to get the understand the type of data being dealt with.

Some of the data types are supported by default. To add a new data type here are the following steps:

  - Add the corresponding handler for upload function in `patient_data_controller.rb`
  - Add the corresponding handler in download function
  - Add the necessary input file checkout function
  - Add the necessary output file checkout function

[1]: https://github.com/collectiveidea/delayed_job
[2]: https://github.com/ejschmitt/delayed_job_web
