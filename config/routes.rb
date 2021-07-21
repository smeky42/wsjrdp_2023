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

    resources :groups do
      resources :people, except: [:new, :create] do
        member do
          post :send_password_instructions
          put :primary_group

          get 'print' => 'person/print#index'
          put 'print' => 'person/print#index'
          get 'print/preview' => 'person/print#preview'
          get 'print/submit' => 'person/print#submit'
          get 'check' => 'person/check#index'
          get 'check/:qrcode' => 'person/check#index'
          get 'upload' => 'person/upload#index'
          put 'upload' => 'person/upload#index'

        end 
      end 
    end
  end
end
