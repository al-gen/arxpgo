Gc::Application.routes.draw do

  #вход на ресурс---------------------------------------------------------------
  root :to => 'arxivs#index'
  #маршруты авторизации---------------------------------------------------------
  devise_for :users  
  #маршруты архива решений------------------------------------------------------
  resources :imgs
  get "arxivs/getadr"
  get "arxivs/getper"  
  get "arxivs/getarx"  
  post "arxivs/index"
  
  get "arxivs/showall"
  match "arxivs/chengerada" => "arxivs#chengerada"
  match "arxivs/edit" => "arxivs#edit"
  match "arxivs/printarx" => "arxivs#printarx"
  resources :arxivs
  post "arxivs/sarxivs"
  match "arxivs/picture/:id" => "arxivs#picture"
  match "arxivs/archpgo/:id" => "arxivs#archpgo"
  match "arxivs/deleteimg/:id" => "arxivs#deleteimg"
  post "arxivs/chengerada"
  #Маршруты ПОГ-----------------------------------------------------------------
  resources :technics

  resources :animals

  resources :proplands

  resources :lands

  resources :prophouses

   post 'houses/wallsearch'
  get 'houses/wallsearch'   
  post 'houses/krovlsearch'
  get 'houses/krovlsearch'
  resources :houses
  
  post 'pers/familysearch'
  get 'pers/familysearch'
  post 'pers/surnamesearch'
  get 'pers/surnamesearch'
  post 'pers/namesearch'
  get 'pers/namesearch'
  post 'pers/midnamesearch'
  get 'pers/midnamesearch'
  resources :pers

  post 'roads/selcity'
  resources :roads

  post 'villages/selcouncil'
  resources :villages
  
    post 'allpgo/setpgo'
    get 'allpgo/setpgo'
    post 'allpgo/searchnum'
    get 'allpgo/searchnum'
    post 'allpgo/searchsur'
    get 'allpgo/searchsur'
   post 'allpgo/searchadre'
    get 'allpgo/searchadre'
    get "allpgo/index"
    get "allpgo/funcadmin"
     get "allpgo/nofound"
     get "allpgo/access_denied"


  post 'pgos/selbook'
  get "pgos/shows"
  resources :pgos

  resources :councils
  post 'books/selcouncil'
  get 'books/gobook'
  resources :books  
  

end
