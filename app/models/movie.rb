-#  This file is  app/views/movies/index.html.haml
%h2 All Movies
= form_tag movies_path,:id=>"ratings_form", :method => :get do
  Include:
  - @all_ratings.each do |rating|
    = rating
    = check_box_tag "ratings[#{rating}]",1, @selected.include?(rating), :id => "ratings_#{rating}"
  = submit_tag 'Refresh', :id => "ratings_submit"
%table#movies.table.table-striped.col-md-12
  %thead
    %tr
      %th{:class => ("hilite" if params[:id]== "title_header" || session[:sort] == "title" )}= link_to "Movie Title", :sort => "title", :id => "title_header"
      %th Ratings
      %th{:class => ("hilite" if params[:id]== "release_data_header" || session[:sort] == "release_date")}= link_to "Release Date", :sort => "release_date", :id => "release_data_header"
      %th More Info
  %tbody
    - @movies.each do |movie|
      %tr
        %td= movie.title
        %td= movie.rating
        %td= movie.release_date
        %td= link_to "More about #{movie.title}", movie_path(movie)

= link_to 'Add new movie', new_movie_path