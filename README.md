panex-web-api
=============

Panex Web API


###Routes
---------

``` bash

                patients GET    /patients(.:format)            patients#index
                         POST   /patients(.:format)            patients#create
             new_patient GET    /patients/new(.:format)        patients#new
            edit_patient GET    /patients/:id/edit(.:format)   patients#edit
                 patient GET    /patients/:id(.:format)        patients#show
                         PUT    /patients/:id(.:format)        patients#update
                         DELETE /patients/:id(.:format)        patients#destroy
        new_user_session GET    /users/sign_in(.:format)       sessions#new
            user_session POST   /users/sign_in(.:format)       sessions#create
    destroy_user_session DELETE /users/sign_out(.:format)      sessions#destroy
           user_password POST   /users/password(.:format)      devise/passwords#create
       new_user_password GET    /users/password/new(.:format)  devise/passwords#new
      edit_user_password GET    /users/password/edit(.:format) devise/passwords#edit
                         PUT    /users/password(.:format)      devise/passwords#update
cancel_user_registration GET    /users/cancel(.:format)        devise/registrations#cancel
       user_registration POST   /users(.:format)               devise/registrations#create
   new_user_registration GET    /users/sign_up(.:format)       devise/registrations#new
  edit_user_registration GET    /users/edit(.:format)          devise/registrations#edit
                         PUT    /users(.:format)               devise/registrations#update
                         DELETE /users(.:format)               devise/registrations#destroy
                   users GET    /users(.:format)               users#index
                         POST   /users(.:format)               users#create
                new_user GET    /users/new(.:format)           users#new
               edit_user GET    /users/:id/edit(.:format)      users#edit
                    user GET    /users/:id(.:format)           users#show
                         PUT    /users/:id(.:format)           users#update
                         DELETE /users/:id(.:format)           users#destroy
                    root        /                              home#index


```
###A Sub-Heading
-------------
