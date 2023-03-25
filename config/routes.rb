# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.


Rails.application.routes.draw do

  extend LanguageRouteScope

  language_scope do
    get '/registration', to: "registration#index"
    post '/registration', to: "registration#index"
    put '/registration', to: "registration#index"
    
    get '/map', to: "map#index"
    post '/map/color', to: "map#color"
    get '/statistic', to: "statistic#index"
    get '/medicinecheck', to: "medicinecheck#index"
    post '/medicinecheck', to: "medicinecheck#index"

    resources :groups do
        get 'print_group_registration' => 'group/print_registration#index' 
      resources :people, except: [:new, :create] do
        member do
          post :send_password_instructions
          put :primary_group

          get 'print' => 'person/print#index'
          put 'print' => 'person/print#index'
          get 'print/preview' => 'person/print#preview'
          get 'print/submit' => 'person/print#submit'
          get 'accounting' => 'person/accounting#index'
          put 'accounting' => 'person/accounting#index'
          get 'istjobs' => 'person/istjobs#index'
          put 'istjobs' => 'person/istjobs#index'
          get 'check' => 'person/check#index'
          put 'check' => 'person/check#index'
          get 'check/:url' => 'person/check#index'
          get 'check/:url/:task' => 'person/check#index'
          get 'upload' => 'person/upload#index'
          put 'upload' => 'person/upload#index'
          get 'upload/show_passport' => 'person/upload#show_passport'
          get 'upload/show_registration' => 'person/upload#show_registration'
          get 'upload/show_registration_generated' => 'person/upload#show_registration_generated'
          get 'upload/show_recommondation' => 'person/upload#show_recommondation'
          get 'upload/show_good_conduct' => 'person/upload#show_good_conduct'
          get 'upload/show_sepa' => 'person/upload#show_sepa'
          get 'upload/show_data_processing' => 'person/upload#show_data_processing'
          get 'upload/show_additional' => 'person/upload#show_additional'


        end 
      end 
    end
  end
end
