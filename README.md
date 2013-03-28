panex-web-api
=============

Panex Web API


###Routes
---------

``` bash

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
