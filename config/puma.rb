# frozen_string_literal: true

app_path = File.expand_path("../..", __FILE__)
app_name = File.basename(app_path)
bind "unix://#{app_path}/run/#{app_name}.sock"
