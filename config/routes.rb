Rails.application.routes.draw do

  post '/webhooks/bLNQJ8nHH72zcLzqN6Tx' => 'webhooks#callback'

  root :to => "sites#index"

end
